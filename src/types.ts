import { Entry, AcceptFn } from './components/Selector'

export type Picker =
  (
    | { values: string[] | ((this: void, ...args: any[]) => string[]) }
    | { entries: Entry[] | ((this: void, ...args: any[]) => Entry[]) }
  ) &
  {
    name?: string,
    onAccept: AcceptFn | string,
  }

