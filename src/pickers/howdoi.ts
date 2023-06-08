import { Timer } from 'kui'
import Job from '../utils/job'
import type { Entry, Picker } from '../types'

let timer: Timer | null = null
let job: Job | null = null
let answers = [] as Answer[]
let lastInput = ''

type Answer = {
  answer: string,
  link: string,
  position: 1,
}

const howdoi: Picker = {
  id: 'howdoi',
  prefix: '󰠗',
  prefixColor: 'question',
  hasIcon: false,
  singleLine: true,
  detailsAlign: 'right',
  entries: function(this: void) {
    return []
  },
  onChange: (selector, input) => {
    job?.shutdown()
    job = null
    lastInput = input

    if (input === '') {
      selector.setMessage('Type your query')
      return
    }

    timer?.stop()
    timer = new Timer(200, () => {
      const self = job = Job.new({
        command: 'howdoi',
        args: ['--json', input],
        on_exit: vim.schedule_wrap((code: number) => {
          job = null
          if (code !== 0) {
            return
          }

          const data = self.result().join('')
          answers = data.startsWith('ERROR:') ? [] : vim.json.decode(data) as Answer[]
          const answer = answers[0]

          if (!answer) {
            selector.setMessage('No result found')
          } else {
            selector.setLines(answer.answer.split('\n'))
          }
        }) as any,
      })
      job.start()
    })

    selector.setMessage('Loading...')
  },
  onAccept: () => {
    const answer = answers[0]
    if (!answer) return;
    const currentLine = (vim.fn.getpos('.') as number[])[1] - 1
    vim.api.nvim_buf_set_lines(
      0,
      currentLine + 1,
      currentLine + 1,
      false,
      answer.answer.split('\n')
    )
  },
}

export default howdoi
