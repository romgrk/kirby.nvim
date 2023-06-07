import {
  settings,
  editor,
  EventEmitter,
  Renderer,
  Container,
  Graphics,
  Text,
  TextStyle,
  Input,
} from 'kui'
import type { AcceptFn, ChangeFn, Entry, Picker } from '../types'
import { HIGHLIGHT_COLORS } from '../constants'
import { onChangeDefault } from '../pick'

const cellPixels = settings.DIMENSIONS.cell_pixels
const screenCells = settings.DIMENSIONS.screen_cells

const setKeymap = vim.api.nvim_buf_set_keymap

export type Events = {
  accept: [entry: Entry],
  didClose: [],
}

const COLOR = {
  FOCUS: 0x1D4891,
}

const DESIRED_CELL_WIDTH = 100

export class Selector extends EventEmitter<Events> {
  startBuffer: number
  opts: Picker
  args: any[]

  width: number
  height: number
  paddingX: number
  paddingY: number
  textPaddingX: number
  iconWidth: number

  renderer: Renderer
  stage: Container
  input: Input
  focus: Graphics | null
  container: Container
  labelStyle: TextStyle
  detailsStyle: TextStyle

  didInit: boolean
  initialEntries: Entry[]
  entries: Entry[]
  maxEntries: number
  activeIndex: number
  entryHeight: number
  separatorColor: number

  constructor(startBuffer: number, opts: Picker, args: any[]) {
    super()
    this.startBuffer = startBuffer
    this.opts = Object.assign({}, opts)
    this.opts.singleLine = opts.singleLine === undefined ? true : opts.singleLine
    this.args = args

    opts = this.opts

    const cw = cellPixels.width
    const ch = cellPixels.height

    const window = getWindowDimensions()
    const marginHorizontal = 5
    const row = window.row + 2
    const col = window.col + marginHorizontal
    const availableWidth = window.width

    const desiredCellWidth = opts.width ?? DESIRED_CELL_WIDTH
    const width  = this.width = clamp(10, availableWidth - marginHorizontal * 2, desiredCellWidth) * cw
    const height = this.height = 20 * ch
    const paddingX = this.paddingX = 2 * cw
    const paddingY = this.paddingY = 1 * ch

    this.iconWidth = opts.hasIcon ? (opts.singleLine ? 3 * cw : 3 * cw) : 0
    this.textPaddingX = this.paddingX + this.iconWidth

    this.renderer = new Renderer({ col, row, width, height })
    const stage = this.stage = new Container()

    const hlFloat = editor.getHighlight('NormalFloat')
    const backgroundColor = hlFloat.background ?? 0x434343
    const foregroundColor = hlFloat.foreground ?? 0xffffff
    const borderColor = backgroundColor + 0x303030
    const titleTextColor = 0xcccccc
    this.separatorColor = backgroundColor + 0x303030

    const background = stage.addChild(new Graphics())
    background.x = 0
    background.y = 0
    background.beginFill(backgroundColor)
    background.drawRoundedRect(0, 0, width, height, 20)
    background.endFill()
    background.lineStyle(2, borderColor, 1)
    background.drawRoundedRect(0, 0, width, height, 20)

    const prefix = this.prefix
    const inputX = paddingX + prefix.length * cw
    const input = this.input = stage.addChild(new Input({
      width: width - 4 * cw - prefix.length * cw,
      color: foregroundColor,
    }))
    input.x = inputX
    input.y = 1 * ch
    input.onMount(this.onMountInput)

    this.focus = null

    if (opts.name !== undefined) {
      const name = new Text(opts.name, new TextStyle({
        fill: titleTextColor,
        fontSize: settings.DEFAULT_FONT_SIZE * 0.8,
      }))
      name.x = inputX
      name.y = 0
      stage.addChild(name)
    }
    if (prefix !== '') {
      const color =
        opts.prefixColor === undefined ?
          titleTextColor :
        typeof opts.prefixColor === 'number' ?
          opts.prefixColor :
          editor.getHighlight(opts.prefixColor).foreground || 0xffffff

      const element = new Text(prefix, new TextStyle({ fill: color }))
      element.x = paddingX
      element.y = 1 * ch
      stage.addChild(element)
    }

    const containerY = input.y + input.height + 0.5 * ch
    const containerHeight = height - containerY - paddingY
    const container = this.container = stage.addChild(new Graphics())
    container.x = 0
    container.y = input.y + input.height + 0.5 * ch

    this.labelStyle = new TextStyle({ fill: foregroundColor })
    this.detailsStyle = new TextStyle({
      fill: foregroundColor - 0x404040,
      fontSize: opts.singleLine ? settings.DEFAULT_FONT_SIZE : settings.DEFAULT_FONT_SIZE * 0.9,
    })

    this.didInit = false
    this.initialEntries = []
    this.entries = []
    this.maxEntries = Math.floor(containerHeight / ch)
    this.activeIndex = -1
    this.entryHeight = this.opts.singleLine ? 2 * ch : 3 * ch

    this.onAccept(opts.onAccept)
    this.onChange(opts.onChange ?? onChangeDefault)
  }

  get prefix() {
    return typeof this.opts.prefix === 'function' ?
      this.opts.prefix(this.args) :
      this.opts.prefix ?? ''
  }

  onChange(fn: ChangeFn) {
    const self = this
    this.input.onChange(function(input) {
      fn(self, input)
    })
  }

  onDidClose(fn: Function) {
    this.on('didClose', fn as any)
  }

  onAccept(callback: string | AcceptFn) {
    const fn =
      typeof callback === 'function' ?
        (entry: Entry) => { callback(entry, this.args) } :
        (entry: Entry) => { vim.cmd(`${callback} ${entry.text}`) }

    this.on('accept', fn)
  }

  render() {
    this.renderer.render(this.stage)
  }

  close() {
    this.input?.destroy()
    this.stage?.destroy()
    this.renderer?.destroy()
    this.emit('didClose')
  }

  accept() {
    this.close()
    const entry = this.entries[this.activeIndex]
    if (entry !== undefined)
      this.emit('accept', entry)
  }

  select(direction: number) {
    if (this.activeIndex === -1 || !this.focus)
      return

    this.activeIndex += direction
    if (this.activeIndex < 0)
      this.activeIndex += this.entries.length
    if (this.activeIndex >= this.entries.length)
      this.activeIndex -= this.entries.length

    this.focus.y = this.activeIndex * this.entryHeight
    this.render()
  }

  onMountInput = (bufferId: number) => {
    setKeymap(bufferId, 'i', '<CR>',  '<Esc>:lua require("kirby").accept()<CR>', { noremap: true, silent: true })
    setKeymap(bufferId, 'i', '<Esc>', '<Esc>:lua require("kirby").close()<CR>',  { noremap: true, silent: true })
    setKeymap(bufferId, 'i', '<A-j>', '<C-o>:lua require("kirby").select(1)<CR>',  { noremap: true, silent: true })
    setKeymap(bufferId, 'i', '<A-k>', '<C-o>:lua require("kirby").select(-1)<CR>',  { noremap: true, silent: true })
    vim.cmd('startinsert')
  }

  setInitialEntries(entries: Entry[]) {
    this.didInit = true
    this.initialEntries = entries
    this.setEntries(this.initialEntries)
  }

  drawMessage(message: string) {
    const style = new TextStyle({
      fill: editor.getHighlight('comment').foreground ?? 0xffffff,
      fontSize: settings.DEFAULT_FONT_SIZE,
    })
    const textEntry = this.container.addChild(new Text(message, style))
    textEntry.y = 0.5 * cellPixels.height
    textEntry.x = this.textPaddingX
  }

  setEntries(entries: Entry[]) {
    const isEmpty = entries.length === 0
    this.entries = entries
    this.activeIndex = !isEmpty ? 0 : -1

    const cw = cellPixels.width
    const ch = cellPixels.height

    const container = this.container
    while (container.children.length > 0) {
      container.removeChildAt(0)
    }

    if (isEmpty) {
      this.drawMessage(this.didInit ? 'No results' : 'Loading entries...')
      this.render()
      return
    }

    const { hasIcon, singleLine, detailsAlign } = this.opts
    const alignDetailsRight = detailsAlign === 'right'
    const yForIndex = (i: number) => i * this.entryHeight

    if (!isEmpty) {
      const focus = this.focus = container.addChild(new Graphics())
      focus.y = yForIndex(this.activeIndex)
      const bg = focus.addChild(new Graphics())
      bg.beginFill(COLOR.FOCUS)
      bg.drawRect(0 - 5, 0, this.width + 10, this.entryHeight)
    }

    let i = 0
    for (const entry of entries) {
      const line = container.addChild(new Container())
      line.y = yForIndex(i)

      let currentX = this.paddingX

      if (hasIcon) {
        if (entry.icon) {
          const style = this.labelStyle.clone()
          if (entry.iconColor) {
            style.fill = typeof entry.iconColor === 'string' ?
              parseInt(entry.iconColor.slice(1), 16) :
              entry.iconColor
          }
          if (!singleLine) {
            style.fontSize = settings.DEFAULT_FONT_SIZE * 1.2
          }
          const textIcon = line.addChild(new Text(entry.icon, style))
          textIcon.x = singleLine ? currentX : 1.5 * cw
          textIcon.y = singleLine ? 0.5 * ch : 0.8 * ch
        }
        currentX += this.iconWidth
      }

      // const positions = entry.positions
      // const disableHighlights = true // Text layout going wrong

      {
        const label = entry.label
        const textEntry = line.addChild(new Text(label, this.labelStyle))
        textEntry.y = singleLine ? 0.5 * ch : 0.5 * ch
        textEntry.x = currentX
        currentX += textEntry.width

        // if (hasHighlight) {
        //   const highlightStyles = getLabelHighlightStyles(this.labelStyle)
        //   let nextHighlight = 0
        //
        //   let current = 0
        //   let currentPositionI = positions.findIndex(p => p >= (entry.labelOffset ?? 0))
        //   const currentPosition = () => positions[currentPositionI] ?
        //     positions[currentPositionI] - (entry.labelOffset ?? 0) : undefined
        //   while (current < label.length) {
        //     const currentEnd = currentPosition() ?? label.length
        //
        //     if (currentEnd > current) {
        //       const slice = label.slice(current, currentEnd)
        //
        //       const textEntry = line.addChild(new Text(slice, this.labelStyle))
        //       textEntry.x = currentX
        //       currentX += textEntry.width
        //       current += slice.length
        //     }
        //
        //     while (currentPosition() === current) {
        //       const character = label[current]
        //       const style = highlightStyles[nextHighlight++ % highlightStyles.length]
        //       const textEntry = line.addChild(new Text(character, style))
        //       textEntry.x = currentX
        //       currentX += textEntry.width
        //
        //       currentPositionI++
        //       current++
        //     }
        //   }
        // }
      }
      currentX += 1 * cw

      if (entry.details !== undefined) {
        const details = entry.details
        const textEntry = line.addChild(new Text(details, this.detailsStyle))
        if (singleLine) {
          textEntry.y = 0.5 * ch
          if (alignDetailsRight) {
            const endX = this.width - this.paddingX
            const x = endX - textEntry.width
            textEntry.x = Math.max(currentX, x)
          } else {
            textEntry.x = currentX
          }
        }
        if (!singleLine) {
          textEntry.y = 1.5 * ch
          textEntry.x = this.textPaddingX
        }
      }

      {
        const separator = line.addChild(new Graphics())
        separator.x = 0
        separator.y = 0
        separator.lineStyle(2, this.separatorColor, 0.5)
        separator.moveTo(0, 0)
        separator.lineTo(this.width, 0)
        // separator.drawRect(0, 0, this.width, 1)
      }
      if (i + 1 === this.maxEntries || entry === entries[entries.length - 1]){
        const separator = line.addChild(new Graphics())
        separator.x = 0
        separator.y = this.entryHeight
        separator.lineStyle(2, this.separatorColor, 0.5)
        separator.moveTo(0, 0)
        separator.lineTo(this.width, 0)
        // separator.drawRect(0, 0, this.width, 1)
      }

      i++
      if (i >= this.maxEntries)
        break
    }

    this.render()
  }
}

let labelHlStyle: TextStyle[] | null = null
function getLabelHighlightStyles(baseStyle: TextStyle) {
  if (labelHlStyle)
    return labelHlStyle
  labelHlStyle = HIGHLIGHT_COLORS.map(color => {
    const style = baseStyle.clone()
    style.fill = color
    // style.fontWeight = 'bold'
    return style
  })
  return labelHlStyle
}

let detailsHlStyle: TextStyle[] | null = null
function getDetailsHighlightStyles(baseStyle: TextStyle) {
  if (detailsHlStyle)
    return detailsHlStyle
  detailsHlStyle = HIGHLIGHT_COLORS.map(color => {
    const style = baseStyle.clone()
    style.fill = color
    style.fontWeight = 'bold'
    return style
  })
  return detailsHlStyle
}

function getWindowDimensions() {
  const [row, col] = vim.fn.win_screenpos(0) as number[]
  const width = vim.fn.winwidth(0)
  const height = vim.fn.winheight(0)
  return { row, col, width, height }
}

function clamp(min: number, max: number, value: number) {
  return Math.max(min, Math.min(max, value))
}
