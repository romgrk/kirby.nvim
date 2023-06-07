import { Timer } from 'kui'
import { Picker } from './types'
import { Selector } from './components/Selector'
import { getEntries, onChangeDefault } from './pick'

export let selector: Selector | null = null
export let timer: Timer | null = null
export const pickers = {} as Record<string, Picker>

export function open(this: void, opts: Picker, args: any[]) {
  timer?.stop()
  selector?.close()

  const startBuffer = selector?.startBuffer ?? vim.api.nvim_get_current_buf()

  selector = new Selector(startBuffer, opts, args)
  selector.setInitialEntries(getEntries(opts, args))
  selector.onChange(opts.onChange ?? onChangeDefault)
  selector.onDidClose(() => {
    selector = null
  })
  Timer.wait(100).then(() => {
    selector?.render()
  })
}

export function select(this: void, n: number) {
  selector?.select(n)
}

export function accept(this: void) {
  selector?.accept()
}

export function close(this: void) {
  selector?.close()
  selector = null
}


export function listPickers(): string[] {
  return Object.keys(pickers)
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

export function openFilePicker(this: void, directory: string = '.') {
  openPickerByID('files', directory)
}
