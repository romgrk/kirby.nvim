import type { Entry } from '../types'

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

export default {
  id: 'commands',
  prefix: '> ',
  prefixColor: 'keyword',
  hasIcon: false,
  singleLine: true,
  entries: function(this: void, args: any[]) {
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

    return entries
  },
  onAccept: (entry: Entry) => {
    const command = entry.data as Command
    if (command.nargs === '0') {
      vim.cmd(command.name)
    } else {
      vim.fn.feedkeys(':' + command.name + ' ', 'n')
    }
  },
}
