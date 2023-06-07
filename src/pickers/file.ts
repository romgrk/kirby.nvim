import path from '../path'
import { getIcon } from '../icons'

const fileCommand =
  vim.fn.executable('fd') !== 0 ?
    'fd -t f' :
    'git ls-files'

export default {
  id: 'file',
  prefix: 'Open ',
  prefixColor: 'comment',
  hasIcon: true,
  singleLine: false,
  entries: function(this: void, args: any[]) {
    const [directory = '.'] = args
    const entries =
      vim.fn.system(`cd ${directory} && ${fileCommand}`).trim().split('\n')
      .map(line => {
        const parsed = path.parse(line)
        const { icon, color } = getIcon(parsed.base, parsed.ext)

        let directory = parsed.dir.trim()
        if (!directory || directory === '')
          directory = '.'
        directory += '/ '

        return {
          icon,
          iconColor: color,
          label: parsed.base,
          details: directory,
          text: line,
          value: line,
          labelOffset: parsed.dir.length > 0 ? parsed.dir.length + 1 : 0,
          detailsOffset: 0,
        }
      })
    entries.sort((a, b) => { return a.text.length - b.text.length })
    return entries
  },
  onAccept: 'edit',
}
