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
import { HIGHLIGHT_COLORS } from '../constants'

const cellPixels = settings.DIMENSIONS.cell_pixels
const screenCells = settings.DIMENSIONS.screen_cells

const setKeymap = vim.api.nvim_buf_set_keymap

export type Entry = {
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
export type AcceptFn = (entry: Entry) => void

export type Events = {
  accept: [entry: Entry],
  didClose: [],
}

export class Selector extends EventEmitter<Events> {
  width: number
  height: number
  paddingX: number
  paddingY: number
  renderer: Renderer
  stage: Container
  input: Input
  focus: Graphics | null
  container: Container
  labelStyle: TextStyle
  detailsStyle: TextStyle
  maxEntries: number
  entries: Entry[]
  activeIndex: number

  constructor() {
    super()

    const cw = cellPixels.width
    const ch = cellPixels.height

    const width  = this.width = Math.max(10, screenCells.width - 20) * cw
    const height = this.height = 20 * ch
    const paddingX = this.paddingX = 2 * cw
    const paddingY = this.paddingY = 1 * ch

    const renderer = this.renderer = new Renderer({ col: 10, row: 5, width, height })
    const stage = this.stage = new Container()

    const background = stage.addChild(new Graphics())
    background.x = 0
    background.y = 0
    background.beginFill(0x3e4556)
    background.drawRoundedRect(0, 0, width, height, 20)
    background.endFill()
    background.lineStyle(2, 0x20232C, 1)
    background.drawRoundedRect(0, 0, width, height, 20)

    const input = this.input = stage.addChild(new Input({
      padding: 5,
      width: width - 4 * cw,
      backgroundColor: 0x4F586D,
      borderColor: 0xdddddd,
      borderWidth: 1,
      borderRadius: 5,
    }))
    input.x = paddingX
    input.y = 1 * ch
    input.onMount(this.onMountInput)

    this.focus = null

    const containerY = input.y + input.height + 0.5 * ch
    const containerHeight = height - containerY - paddingY
    const container = this.container = stage.addChild(new Graphics())
    container.x = paddingX
    container.y = input.y + input.height + 0.5 * ch
    // container.lineStyle(2, 0x20232C, 1)
    // container.drawRect(0, 0, width - paddingX * 2, containerHeight)

    const hlNormal = editor.getHighlight('NormalFloat')
    const color = hlNormal.foreground ?? 0xffffff

    this.labelStyle = new TextStyle({ fill: color })
    this.detailsStyle = new TextStyle({
      fill: color - 0x303030,
      fontSize: TextStyle.defaultStyle.fontSize as number * 0.9,
    })

    this.maxEntries = Math.floor(containerHeight / ch)
    this.entries = []
    this.activeIndex = -1

    renderer.render(stage)
  }

  onChange(fn: (value: string) => void) {
    this.input.onChange(fn)
  }

  onDidClose(fn: Function) {
    this.on('didClose', fn as any)
  }

  onAccept(fn: (entry: Entry) => void) {
    this.on('accept', fn)
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

    this.focus.y = this.activeIndex * cellPixels.height
    this.render()
  }

  onMountInput = (bufferId: number) => {
    setKeymap(bufferId, 'i', '<CR>',  '<Esc>:lua require("kirby").selector:accept()<CR>', { noremap: true, silent: true })
    setKeymap(bufferId, 'i', '<Esc>', '<Esc>:lua require("kirby").selector:close()<CR>',  { noremap: true, silent: true })
    setKeymap(bufferId, 'i', '<A-j>', '<C-o>:lua require("kirby").selector:select(1)<CR>',  { noremap: true, silent: true })
    setKeymap(bufferId, 'i', '<A-k>', '<C-o>:lua require("kirby").selector:select(-1)<CR>',  { noremap: true, silent: true })
    vim.cmd('startinsert')
  }

  setEntries(entries: Entry[]) {
    this.entries = entries
    this.activeIndex = entries.length > 0 ? 0 : -1

    const cw = cellPixels.width
    const ch = cellPixels.height

    const container = this.container
    while (container.children.length > 0) {
      container.removeChildAt(0)
    }

    const yForIndex = (i: number) => i * ch

    if (this.activeIndex !== -1) {
      const focus = this.focus = container.addChild(new Graphics())
      focus.y = yForIndex(this.activeIndex)
      focus.beginFill(0x2C3A7F)
      focus.drawRoundedRect(0 - 5, 0, this.width - 2 * this.paddingX + 10, ch, 5)
    }

    let i = 0
    for (const entry of entries) {
      const line = container.addChild(new Container())
      line.y = yForIndex(i)

      let currentX = 0
      if (entry.icon) {
        const style = this.labelStyle.clone()
        if (entry.iconColor)
          style.fill = parseInt(entry.iconColor.slice(1), 16)
        const textIcon = line.addChild(new Text(entry.icon, style))
        textIcon.x = currentX
      }
      currentX += 2 * cw

      const positions = entry.positions
      const disableHighlights = true // Text layout going wrong

      {
        const label = entry.label
        if (!positions || disableHighlights) {
          const textEntry = line.addChild(new Text(label, this.labelStyle))
          textEntry.x = currentX
          currentX += textEntry.width
        } else {
          const highlightStyles = getLabelHighlightStyles(this.labelStyle)
          let nextHighlight = 0

          let current = 0
          let currentPositionI = positions.findIndex(p => p >= (entry.labelOffset ?? 0))
          const currentPosition = () => positions[currentPositionI] ?
            positions[currentPositionI] - (entry.labelOffset ?? 0) : undefined
          while (current < label.length) {
            const currentEnd = currentPosition() ?? label.length

            if (currentEnd > current) {
              const slice = label.slice(current, currentEnd)

              const textEntry = line.addChild(new Text(slice, this.labelStyle))
              textEntry.x = currentX
              currentX += textEntry.width
              current += slice.length
            }

            while (currentPosition() === current) {
              const character = label[current]
              const style = highlightStyles[nextHighlight++ % highlightStyles.length]
              const textEntry = line.addChild(new Text(character, style))
              textEntry.x = currentX
              currentX += textEntry.width

              currentPositionI++
              current++
            }
          }
        }
      }
      currentX += 1 * cw

      if (entry.details !== undefined) {
        const details = entry.details
        if (!positions || disableHighlights) {
          const textEntry = line.addChild(new Text(details, this.detailsStyle))
          textEntry.x = currentX
          currentX += textEntry.width
        } else {
          const highlightStyles = getDetailsHighlightStyles(this.detailsStyle)
          let nextHighlight = 0

          let current = 0
          let currentPositionI = positions.findIndex(p => p >= (entry.detailsOffset ?? 0))
          const currentPosition = () => positions[currentPositionI] ?
            positions[currentPositionI] - (entry.detailsOffset ?? 0) : undefined
          while (current < details.length) {
            const currentEnd = currentPosition() ?? details.length

            if (currentEnd > current) {
              const slice = details.slice(current, currentEnd)

              const textEntry = line.addChild(new Text(slice, this.detailsStyle))
              textEntry.x = currentX
              currentX += textEntry.width
              current += slice.length
            }

            while (currentPosition() === current) {
              const character = details[current]
              const style = highlightStyles[nextHighlight++ % highlightStyles.length]
              const textEntry = line.addChild(new Text(character, style))
              textEntry.x = currentX
              currentX += textEntry.width

              currentPositionI++
              current++
            }
          }
        }
      }

      i++
      if (i >= this.maxEntries)
        break
    }

    this.render()
  }

  render() {
    this.renderer.render(this.stage)
  }

  close() {
    this.input.destroy()
    this.stage.destroy()
    this.renderer.destroy()
    this.emit('didClose')
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
