import { Entry, AcceptFn } from './components/Selector'

export type Picker =
  (
    | { values: string[] | ((this: void, ...args: any[]) => string[]) }
    | { entries: Entry[] | ((this: void, ...args: any[]) => Entry[]) }
  ) &
  {
    name?: string,
    prefix?: string,
    prefixColor?: string | number,
    hasIcon?: boolean,
    singleLine?: boolean,
    width?: number,
    onAccept: AcceptFn | string,
  }

