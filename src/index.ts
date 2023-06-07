import { Picker } from './types'
import { Selector } from './components/Selector'
import { getEntries, onChangeFZY } from './pick'
import file from './pickers/file'
import ctags from './pickers/ctags'

export let selector: Selector | null = null
export const pickers = {} as Record<string, Picker>

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

export function register(this: void, opts: Picker): void {
  pickers[opts.id] = opts
}

export function openPickerByID(this: void, id: string, ...args: any[]) {
  if (pickers[id] !== undefined)
    open(pickers[id], args)
  else
    print(`Could not find picker ${id}`)
}

register(file)
register(ctags.currentFile)

export function openFilePicker(this: void, directory: string = '.') {
  openPickerByID('file', directory)
}
