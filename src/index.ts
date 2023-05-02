import * as fzy from 'fzy-lua-native'
import path from './path'
import { getIcon } from './icons'
import { Picker } from './types'
import { Selector, Entry } from './components/Selector'

export let selector: Selector | null = null
export const pickers = {} as Record<string, Picker>

const fileCommand =
  vim.fn.executable('fd') !== 0 ?
    'fd -t f' :
    'git ls-files'

export function open(this: void, opts: Picker, ...args: any[]) {
  let entries: Entry[]

  if ('values' in opts) {
    const valuesOpt = opts.values
    const values = typeof valuesOpt === 'function' ? valuesOpt(...args) : valuesOpt
    entries = values.map(v => ({ label: v, text: v, value: v }))
  } else {
    const entriesOpt = opts.entries 
    entries = typeof entriesOpt === 'function' ? entriesOpt(...args) : entriesOpt
  }

  const onAccept =
    typeof opts.onAccept === 'function' ?
      opts.onAccept :
      (entry: Entry) => {
        vim.cmd(`${opts.onAccept} ${entry.text}`)
      }

  selector?.close()
  selector = new Selector(opts)
  selector.setEntries(entries)
  selector.onChange(input => {
    const sensitive = input !== input.toLowerCase()
    const filtered = entries.filter((e, i) => {
      const hasMatch = fzy.has_match(input, e.text, sensitive)
      if (hasMatch) {
        e.score = fzy.score(input, e.text, sensitive)
        e.positions = fzy.positions(input, e.text, sensitive)
        e.positions.forEach((_, i) => {
          e.positions![i] -= 1
        })
      }
      return hasMatch
    })
    filtered.sort((a, b) => (b.score ?? 0) - (a.score ?? 0))
    selector!.setEntries(filtered)
  })
  selector.onAccept(onAccept)
  selector.onDidClose(() => {
    selector = null
  })
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
  name: 'Files',
  entries: (args: any[]) => {
    const [directory = '.'] = args
    const entries =
      vim.fn.system(`cd ${directory} && ${fileCommand}`).trim().split('\n')
      .map(line => {
        const parsed = path.parse(line)
        const { icon, color } = getIcon(parsed.base, parsed.ext)
        return {
          icon,
          iconColor: color,
          label: parsed.base,
          details: parsed.dir,
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
