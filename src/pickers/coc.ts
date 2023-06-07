import { editor } from 'kui'
import type { Entry, Picker } from '../types'

type Location = {
  uri: string, // "file:///home/romgrk/.config/coc/extensions/node_modules/coc-sumneko-lua/nvim_lua_types/api.lua"
  range: {
    end: {
      character: number,
      line: number,
    },
    start: {
      character: number,
      line: number,
    }
  },
}

type Diagnostic = {
  file: string, // '/home/romgrk/src/kirby.nvim/src/pickers/coc.ts',
  lnum: number,
  end_lnum: number,
  location: Location,
  source: string,
  code: number,
  level: number,
  message: string,
  end_col: number,
  col: number,
  severity: 'Error' | 'Warning' | 'Information' | 'Hint'
}

const ICON_BY_SEVERITY = {
  Error: '',
  Warning: '',
  Information: '',
  Hint: '',
}

const COLOR_BY_SEVERITY = {
  Error: 'CocErrorSign',
  Warning: 'CocWarningSign',
  Information: 'CocInfoSign',
  Hint: 'CocHintSign'
}


function getDiagnostics() {
  let buffer = vim.fn.bufnr('%')
  if (!vim.api.nvim_buf_get_option(buffer, 'buflisted')) {
    buffer = vim.fn.bufnr('#')
  }

  const fn = (vim.fn as any)['CocAction'] as (this: void, ...args: any[]) => Diagnostic[]
  const diagnostics = (fn('diagnosticList') ?? [])

  const colorBySeverity = {
    Error: editor.getHighlight(COLOR_BY_SEVERITY.Error).foreground ?? 0xffffff,
    Warning: editor.getHighlight(COLOR_BY_SEVERITY.Warning).foreground ?? 0xffffff,
    Information: editor.getHighlight(COLOR_BY_SEVERITY.Information).foreground ?? 0xffffff,
    Hint: editor.getHighlight(COLOR_BY_SEVERITY.Hint).foreground ?? 0xffffff,
  }

  return diagnostics.map(d => {
    const line = d.location.range.start.line
    const label = d.message
    const details = vim.fn.fnamemodify(d.file, ':~:.') + ':' + line
    const text = `${details} ${label}`
    return {
      icon: ICON_BY_SEVERITY[d.severity],
      iconColor: colorBySeverity[d.severity],
      label: label,
      details: details,
      text: text,
      value: text,
      data: d,
    }
  })
}

const diagnostics: Picker = {
  id: 'coc-diagnostics',
  prefix: 'Jump to ',
  prefixColor: 'comment',
  hasIcon: true,
  singleLine: true,
  detailsAlign: 'right',
  entries: function(this: void) {
    return getDiagnostics()
  },
  onAccept: (entry: Entry) => {
    const d = entry.data as Diagnostic
    vim.cmd(`edit ${d.file}`)
    vim.cmd('normal! zz')
    vim.api.nvim_win_set_cursor(0, [
      d.location.range.start.line + 1,
      d.location.range.start.character,
    ])
  },
}


type Symbol = {
  kind: number,
  location: Location,
  name: string,
  source: string,
}

function getSymbols(input: string) {
  let buffer = vim.fn.bufnr('%')
  if (!vim.api.nvim_buf_get_option(buffer, 'buflisted')) {
    buffer = vim.fn.bufnr('#')
  }

  const fn = (vim.fn as any)['CocAction'] as (this: void, ...args: any[]) => Symbol[] | null
  const symbols = (fn('getWorkspaceSymbols', input, buffer) ?? []).slice(0, 20)

  return symbols.map(symbol => {
    const line = symbol.location.range.start.line
    const text = symbol.name
    return {
      label: text,
      details: vim.fn.fnamemodify(symbol.location.uri.slice(7), ':~:.') + ':' + line,
      text: text,
      value: text,
      data: symbol,
    }
  })
}

const workspaceSymbols: Picker = {
  id: 'coc-workspace-symbols',
  prefix: 'Jump to ',
  prefixColor: 'comment',
  hasIcon: false,
  singleLine: true,
  detailsAlign: 'right',
  entries: function(this: void) {
    return getSymbols('')
  },
  onChange: (selector, input) => {
    const symbols = getSymbols(input)
    selector.setEntries(symbols)
  },
  onAccept: (entry: Entry) => {
    const symbol = entry.data as Symbol
    vim.cmd(`edit ${symbol.location.uri.slice(7)}`)
    vim.cmd('normal! zz')
    vim.api.nvim_win_set_cursor(0, [
      symbol.location.range.start.line + 1,
      symbol.location.range.start.character,
    ])
  },
}

export default {
  diagnostics,
  workspaceSymbols,
}
