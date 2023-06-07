import * as fzy from 'fzy-lua-native'
import path from './path'
import { getIcon } from './icons'
import { Picker } from './types'
import { Selector } from './components/Selector'
import { getEntries, onChangeFZY } from './pick'

export let selector: Selector | null = null
export const pickers = {} as Record<string, Picker>

const fileCommand =
  vim.fn.executable('fd') !== 0 ?
    'fd -t f' :
    'git ls-files'

export function open(this: void, opts: Picker, ...args: any[]) {
  selector?.close()
  selector = new Selector(opts)

  selector.setInitialEntries(getEntries(opts, args))
  selector.onChange(onChangeFZY)
  selector.onDidClose(() => {
    selector = null
  })
}

export function listPickers(): string[] {
  return Object.keys(pickers)
}

export function close() {
  selector?.close()
  selector = null
}

export function register(this: void, id: string, opts: Picker) {
  pickers[id] = opts
}

export function openPickerByID(this: void, id: string, ...args: any[]) {
  if (pickers[id] !== undefined)
    open(pickers[id], args)
  else
    print(`Could not find picker ${id}`)
}

register('file', {
  prefix: 'Open ',
  prefixColor: 'comment',
  hasIcon: true,
  singleLine: false,
  entries: (args: any[]) => {
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
})

export function openFilePicker(this: void, directory: string = '.') {
  openPickerByID('file', directory)
}
