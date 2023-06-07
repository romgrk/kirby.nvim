import type { Entry } from '../types'

const currentFile = {
  id: 'ctags-current-file',
  prefix: 'Jump to ',
  prefixColor: 'comment',
  hasIcon: false,
  singleLine: true,
  entries: function(this: void) {
    const file = vim.fn.bufname(0)
    if (!file || file === '') {
      return []
    }

    const lines = vim.fn.system(`ctags --excmd=combine -f- ${file}`).trim().split('\n')

    const entries = lines.map(line => {
      const [symbol, _file, address, _type] = line.split('\t')
      const addressParts = address.split(';')
      const lineNumber = parseInt(addressParts[0])
      const rest = addressParts.slice(1).join(';')
      const pattern = rest.slice(2).slice(0, -4)
      const code = pattern.trim()
      const columnNumber = pattern.length - pattern.trimStart().length

      return {
        label: symbol,
        details: `${lineNumber}: ${code}`,
        text: symbol,
        value: symbol,
        data: {
          lineNumber,
          columnNumber,
        },
      }
    })
    entries.sort((a, b) => { return a.data.lineNumber - b.data.lineNumber })
    return entries
  },
  onAccept: (entry: Entry) => {
    vim.api.nvim_win_set_cursor(0, [entry.data.lineNumber, entry.data.columnNumber])
  },
}

export default {
  currentFile,
}
