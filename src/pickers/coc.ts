import { editor, Timer } from 'kui';
import type { Entry, Picker } from '../types';
import { fuzzyMatch } from '../pick';

type Range = {
  end: {
    character: number;
    line: number;
  };
  start: {
    character: number;
    line: number;
  };
};

type Location = {
  uri: string; // "file:///home/romgrk/.config/coc/extensions/node_modules/coc-sumneko-lua/nvim_lua_types/api.lua"
  range: Range;
};

type Diagnostic = {
  file: string; // '/home/romgrk/src/kirby.nvim/src/pickers/coc.ts',
  lnum: number;
  end_lnum: number;
  location: Location;
  source: string;
  code: number;
  level: number;
  message: string;
  end_col: number;
  col: number;
  severity: 'Error' | 'Warning' | 'Information' | 'Hint';
};

const ICON_BY_SEVERITY = {
  Error: '',
  Warning: '',
  Information: '',
  Hint: '',
};

const COLOR_BY_SEVERITY = {
  Error: 'CocErrorSign',
  Warning: 'CocWarningSign',
  Information: 'CocInfoSign',
  Hint: 'CocHintSign',
};

function getDiagnostics() {
  let buffer = vim.fn.bufnr('%');
  if (!vim.api.nvim_buf_get_option(buffer, 'buflisted')) {
    buffer = vim.fn.bufnr('#');
  }

  const fn = (vim.fn as any)['CocAction'] as (this: void, ...args: any[]) => Diagnostic[];
  const diagnostics = fn('diagnosticList') ?? [];

  const colorBySeverity = {
    Error: editor.getHighlight(COLOR_BY_SEVERITY.Error).foreground ?? 0xffffff,
    Warning: editor.getHighlight(COLOR_BY_SEVERITY.Warning).foreground ?? 0xffffff,
    Information:
      editor.getHighlight(COLOR_BY_SEVERITY.Information).foreground ?? 0xffffff,
    Hint: editor.getHighlight(COLOR_BY_SEVERITY.Hint).foreground ?? 0xffffff,
  };

  return diagnostics.map((d) => {
    const line = d.location.range.start.line;
    const label = d.message;
    const details = vim.fn.fnamemodify(d.file, ':~:.') + ':' + line;
    const text = `${details} ${label}`;
    return {
      icon: ICON_BY_SEVERITY[d.severity],
      iconColor: colorBySeverity[d.severity],
      label: label,
      details: details,
      text: text,
      value: text,
      data: d,
    };
  });
}

const diagnostics: Picker = {
  id: 'coc-diagnostics',
  prefix: 'Jump to ',
  prefixColor: 'comment',
  hasIcon: true,
  singleLine: true,
  detailsAlign: 'right',
  entries: function (this: void) {
    return getDiagnostics();
  },
  onAccept: (entry?: Entry) => {
    if (!entry) return;
    const d = entry.data as Diagnostic;
    vim.cmd(`edit ${d.file}`);
    vim.cmd('normal! zz');
    vim.api.nvim_win_set_cursor(0, [
      d.location.range.start.line + 1,
      d.location.range.start.character,
    ]);
  },
};

type WorkspaceSymbol = {
  kind: number;
  location: Location;
  name: string;
  source: string;
};

type DocumentSymbol = {
  lnum: number;
  col: number;
  range: Range;
  selectionRange: Range;
  level: number;
  kind: string;
  text: string;
};

// The list is too big to pass between vimscript & lua efficiently, we only select a few symbols
// to improve the latency.
vim.cmd(`
function Kirby__coc_workspace_symbols(input, buffer)
  let symbols = CocAction('getWorkspaceSymbols', a:input, a:buffer)
  if empty(symbols)
    return []
  end
  return slice(symbols, 0, 50)
endfunction

function Kirby__coc_document_symbols(input, buffer)
  let symbols = CocAction('documentSymbols', a:input, a:buffer)
  if empty(symbols)
    return []
  end
  return slice(symbols, 0, 50)
endfunction
`);

function getWorkspaceSymbols(input: string) {
  let buffer = vim.fn.bufnr('%');
  if (!vim.api.nvim_buf_get_option(buffer, 'buflisted')) {
    buffer = vim.fn.bufnr('#');
  }

  const fn = (vim.fn as any)['Kirby__coc_workspace_symbols'] as (
    this: void,
    ...args: any
  ) => WorkspaceSymbol[];
  const symbols = fn(input, buffer);

  return symbols.map((symbol) => {
    const line = symbol.location.range.start.line;
    const text = symbol.name;
    return {
      label: text,
      details: vim.fn.fnamemodify(symbol.location.uri.slice(7), ':~:.') + ':' + line,
      text: text,
      value: text,
      data: symbol,
    };
  });
}

function getDocumentSymbols(input: string) {
  let buffer = vim.fn.bufnr('%');
  if (!vim.api.nvim_buf_get_option(buffer, 'buflisted')) {
    buffer = vim.fn.bufnr('#');
  }

  const fn = (vim.fn as any)['Kirby__coc_document_symbols'] as (
    this: void,
    ...args: any
  ) => DocumentSymbol[];
  const symbols = fn(input, buffer);

  return symbols.map((symbol) => {
    const line = symbol.lnum;
    const text = symbol.text;
    return {
      label: text,
      details: '    ' + (vim.fn.getline(line, line)[0] as string),
      text: text,
      value: text,
      data: symbol,
    };
  });
}

let timer = null as Timer | null;

const workspaceSymbols: Picker = {
  id: 'coc-workspace-symbols',
  prefix: 'Jump to ',
  prefixColor: 'comment',
  hasIcon: false,
  singleLine: true,
  detailsAlign: 'right',
  entries: function (this: void) {
    return getWorkspaceSymbols('');
  },
  onChange: (selector, input) => {
    timer?.stop();
    timer = new Timer(50, () => {
      const symbols = fuzzyMatch(getWorkspaceSymbols(input), input);
      selector.setEntries(symbols);
    });
  },
  onAccept: (entry?: Entry) => {
    if (!entry) return;
    const symbol = entry.data as WorkspaceSymbol;
    vim.cmd(`edit ${symbol.location.uri.slice(7)}`);
    vim.cmd('normal! zz');
    vim.api.nvim_win_set_cursor(0, [
      symbol.location.range.start.line + 1,
      symbol.location.range.start.character,
    ]);
  },
};

const documentSymbols: Picker = {
  id: 'coc-document-symbols',
  prefix: 'Jump to ',
  prefixColor: 'comment',
  hasIcon: false,
  singleLine: true,
  detailsAlign: 'right',
  entries: function (this: void) {
    return getDocumentSymbols('');
  },
  onAccept: (entry?: Entry) => {
    if (!entry) return;
    const symbol = entry.data as DocumentSymbol;
    vim.api.nvim_win_set_cursor(0, [
      symbol.range.start.line + 1,
      symbol.range.start.character,
    ]);
    vim.cmd('normal! zz');
  },
};

export default {
  diagnostics,
  workspaceSymbols,
  documentSymbols,
};
