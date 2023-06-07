import type { Selector } from './components/Selector'

export type Entry = {
  data?: any,
  icon?: string,
  iconColor?: string,
  label: string,
  text: string,
  value: string,
  details?: string,
  score?: number,
  positions?: number[],
  labelOffset?: number,
  detailsOffset?: number,
}

export type AcceptFn = (this: void, entry: Entry) => void
export type ChangeFn = (this: void, selector: Selector, input: string) => void

export type Picker =
  (
    | {
        /**
         * A function that returns a list of string values to pick.
         */
        values: string[] | ((this: void, ...args: any[]) => string[])
      }
    | {
        /**
         * A function that returns a list of entries to pick.
         */
        entries: Entry[] | ((this: void, ...args: any[]) => Entry[])
      }
  ) &
  {
    /** The picker id */
    id: string,
    /** The name, the small label above the input */
    name?: string,
    /** The prefix, on the left of the input */
    prefix?: string,
    /**
     * The prefix color. 
     * If it's a number, it is used directly as a color.
     * If it's a string, the corresponding highlight's fg color is used.
     */
    prefixColor?: string | number,
    /** If set, leaves a space for the `.icon` property of the entries */
    hasIcon?: boolean,
    /**
     * If set, the entry's `.text` and its `.details` are on a single line.
     * Default: `true`
     */
    singleLine?: boolean,
    /** The desired width, in terminal columns */
    width?: number,
    /**
     * The callback after selecting an entry.
     * If it's a string, it is used as run like a command as `:${onAccept} ${entry.value}`.
     * If it's a function, it is called with the `entry`.
     */
    onAccept: AcceptFn | string,
    /** The callback after user input */
    onChange?: ChangeFn,
  }

