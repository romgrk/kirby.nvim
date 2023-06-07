import { editor } from 'kui'
import type { Entry, Picker } from '../types'

const HIGHLIGHT_BY_TYPE = {
  'function': '@function',
  'method': '@function',
  'variable': 'identifier',
  'property': '@property',
  'alias': 'typedef',
  'class': 'structure',
} as Record<string, string | undefined>

const ICON_BY_TYPE = {
  'function': '󰊕',
  'method': '󰊕',
  'class': '',
  'interface': '',
  'enum': '',
  'alias': '',
  'default': '',
} as Record<string, string | undefined>

const currentFile: Picker = {
  id: 'ctags-current-file',
  prefix: 'Jump to ',
  prefixColor: 'comment',
  hasIcon: true,
  singleLine: true,
  detailsAlign: 'right',
  entries: function(this: void) {
    const file = vim.fn.bufname()
    if (!file || file === '') {
      return []
    }

    const lines = vim.fn.system(`ctags '--fields=*' -f- ${file}`).trim().split('\n')
    const colors = {} as Record<string, number>
    function getColor(name: string = 'comment') {
      colors[name] ??= editor.getHighlight(name).foreground ?? 0xffffff
      return colors[name]
    }
    function getIcon(type: string) {
      return ICON_BY_TYPE[type] ?? ICON_BY_TYPE['default']
    }

    const entries = lines.map(line => {
      const parts = line.split('\t')
      const [name, _file, address] = parts
      const pattern = address.slice(2).slice(0, -4)
      const code = pattern.trim()
      const columnNumber = pattern.length - pattern.trimStart().length
      const fields = parts.slice(3).reduce((acc, cur) => {
        const [key] = cur.split(':')
        acc[key] = cur.split(':').slice(1).join(':')
        return acc
      }, {} as Record<string, string>)

      let scope = undefined as string | undefined
      if (fields.scope) {
        scope = fields.scope.split(':')[1].trim()
      }

      const symbol = scope ? (scope + ' ' + name) : name
      const text = symbol
      const details = `${fields.line}: ${code}`
      return {
        icon: getIcon(fields.kind),
        iconColor: getColor(HIGHLIGHT_BY_TYPE[fields.kind as string]),
        label: text,
        details: details,
        text: text,
        value: text,
        data: {
          lineNumber: parseInt(fields.line),
          columnNumber,
        },
      }
    })
    entries.sort((a, b) => { return a.data.lineNumber - b.data.lineNumber })
    return entries
  },
  onAccept: (entry: Entry) => {
    vim.api.nvim_win_set_cursor(0, [entry.data.lineNumber, entry.data.columnNumber])
    vim.cmd('normal! zz')
  },
}

export default {
  currentFile,
}
