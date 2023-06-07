import * as fzy from 'fzy-lua-native'
import type { Entry, Picker } from './types'
import type { Selector } from './components/Selector'

export function getEntries(this: void, opts: Picker, args: any[]) {
  let entries: Entry[]
  if ('values' in opts) {
    const valuesOpt = opts.values
    const values = typeof valuesOpt === 'function' ? valuesOpt(args) : valuesOpt
    entries = values.map(v => ({ label: v, text: v, value: v }))
  } else {
    const entriesOpt = opts.entries 
    entries = typeof entriesOpt === 'function' ? entriesOpt(args) : entriesOpt
  }

  return entries
}

export function fuzzyMatch(entries: Entry[], input: string) {
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
  return filtered
}

export function onChangeDefault(
  this: void,
  selector: Selector,
  input: string
) {
  selector.setEntries(fuzzyMatch(selector.initialEntries, input))
}
