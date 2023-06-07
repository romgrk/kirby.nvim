import { Timer } from 'kui'
import { openPickerByID } from '../api'
import type { Entry, Picker } from '../types'

type Command = {
  name: string,
  bang: boolean,
  preview: boolean,
  nargs: string,
  range: unknown,
  complete: string | null,
  script_id: number,
  addr: string | null,
  bar: boolean,
  register: boolean,
  complete_arg: string | null,
  count: number | null,
  keepscript: boolean,
  definition: string,
}


let commands = undefined as undefined | Command[]
let entries = undefined as undefined | Entry[]

function setup() {
  if (!commands || !entries) {
    commands = Object.values(vim.api.nvim_get_commands({})) as Command[]
    entries = commands.map(command => {
      const { name, definition } = command
      return {
        label: name,
        details: definition,
        text: name,
        value: name,
        data: command,
      }
    })
    table.sort(entries, (a, b) => a.text < b.text)
  }
}

const list = {
  id: 'commands-list',
  prefix: '> ',
  prefixColor: 'keyword',
  hasIcon: false,
  singleLine: true,
  detailsAlign: 'right',
  entries: function(this: void, args: any[]) {
    setup()
    return entries!
  },
  onAccept: (entry: Entry) => {
    const command = entry.data as Command
    if (command.nargs === '0') {
      vim.cmd(command.name)
    } else {
      Timer.wait(0).then(() => {
        openPickerByID('commands-run', command.name)
      })
    }
  },
} as Picker

const run = {
  id: 'commands-run',
  prefix: (args: any[]) => args[0] + ' ',
  prefixColor: 'keyword',
  hasIcon: false,
  singleLine: true,
  entries: function(this: void, args: any[]) {
    setup()

    const [name] = args
    const command = commands!.find(c => c.name === name)

    if (!command) {
      return []
    }

    const { complete, complete_arg } = command

    switch (complete) {
      case 'custom': {
        const fn = (vim.fn as any)[complete_arg as string] as ((this: void, a: string, b: string, c: string) => string)
        const values = fn('', '', '').split('\n')
        return values.map(text => ({
          text,
          label: text,
          value: text,
        }))
      }
      case 'customlist': {
        const fn = (vim.fn as any)[complete_arg as string] as ((this: void, a: string, b: string, c: string) => string[])
        const values = fn('', '', '')
        return values.map(text => ({
          text,
          label: text,
          value: text,
        }))
      }
      default: return []
    }
  },
  onAccept: (entry: Entry) => {
    const command = entry.data as Command
    if (command.nargs === '0') {
      vim.cmd(command.name)
    } else {
      vim.fn.feedkeys(':' + command.name + ' ', 'n')
    }
  },
} as Picker

export default {
  list,
  run,
}
