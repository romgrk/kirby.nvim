import * as fzy from 'fzy-lua-native'
import path from './path'
import { getIcon } from './icons'
import { Selector } from './components/Selector'

export let selector: Selector | null = null

export function open() {
  selector?.close()
  selector = new Selector()

  const entries =
    vim.fn.system('git ls-files').trim().split('\n')
    .map(line => {
      const parsed = path.parse(line)
      const { icon, color } = getIcon(parsed.base, parsed.ext)
      return {
        icon,
        iconColor: color,
        label: parsed.base,
        details: parsed.dir,
        text: line,
      }
    })
  entries.sort((a, b) => { return a.text.length - b.text.length })

  selector.setEntries(entries)
  selector.onChange(input => {
    const sensitive = input !== input.toLowerCase()
    const filtered = entries.filter(e => {
      return fzy.has_match(input, e.text, sensitive)
    })
    selector!.setEntries(filtered)
  })
  selector.onAccept(entry => {
    vim.cmd(`edit ${entry.text}`)
  })
  selector.onDidClose(() => {
    selector = null
  })
}

export function close() {
  selector?.close()
  selector = null
}

export function accept() {
  selector?.accept()
}
