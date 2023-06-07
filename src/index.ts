import { Timer } from 'kui'
import { Picker } from './types'
import { Selector } from './components/Selector'
import { getEntries, onChangeFZY } from './pick'
import files from './pickers/files'
import ctags from './pickers/ctags'
import commands from './pickers/commands'

export let selector: Selector | null = null
export let timer: Timer | null = null
export const pickers = {} as Record<string, Picker>

export function open(this: void, opts: Picker, ...args: any[]) {
  timer?.stop()
  selector?.close()

  selector = new Selector(opts)
  selector.setInitialEntries(getEntries(opts, args))
  selector.onChange(onChangeFZY)
  selector.onDidClose(() => {
    selector = null
  })
  Timer.wait(100).then(() => {
    selector?.render()
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

register(files)
register(ctags.currentFile)
register(commands)

export function openFilePicker(this: void, directory: string = '.') {
  openPickerByID('files', directory)
}
