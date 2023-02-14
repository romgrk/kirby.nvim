import {
  settings,
  editor,
  Renderer,
  Container,
  Graphics,
  Text,
  TextStyle,
  Input,
} from 'kui'

const setKeymap = vim.api.nvim_buf_set_keymap

type Entry = {
  icon?: string,
  iconColor?: string,
  label: string,
  details?: string,
}

export class Selector {
  maxEntries: number
  renderer: Renderer
  stage: Container
  input: Input
  container: Container
  labelStyle: TextStyle
  detailsStyle: TextStyle

  constructor() {
    const screenCells = settings.DIMENSIONS.screen_cells
    const cellPixels = settings.DIMENSIONS.cell_pixels
    const cw = cellPixels.width
    const ch = cellPixels.height

    const width  = Math.max(10, screenCells.width - 20) * cw
    const height = 20 * ch
    const paddingX = 2 * cw
    const paddingY = 1 * ch

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

    const containerY = input.y + input.height + 0.5 * ch
    const containerHeight = height - containerY - paddingY
    const container = this.container = stage.addChild(new Graphics())
    container.x = paddingX
    container.y = input.y + input.height + 0.5 * ch
    // container.lineStyle(2, 0x20232C, 1)
    // container.drawRect(0, 0, width - paddingX * 2, containerHeight)
    this.maxEntries = Math.floor(containerHeight / ch)

    const hlNormal = editor.getHighlight('NormalFloat')
    const color = hlNormal.foreground ?? 0xffffff

    this.labelStyle = new TextStyle({ fill: color })
    this.detailsStyle = new TextStyle({
      fill: color - 0x303030,
      fontSize: TextStyle.defaultStyle.fontSize as number * 0.9,
    })

    renderer.render(stage)
  }

  onChange(fn: (value: string) => void) {
    this.input.onChange(fn)
  }

  onMountInput = (bufferId: number) => {
    setKeymap(bufferId, 'i', '<CR>',  '<nop>', {})
    setKeymap(bufferId, 'i', '<Esc>', '<Esc>:lua require("kirby").close()<CR>', { noremap: true, silent: true })
    vim.cmd('startinsert')
  }

  setEntries(entries: Entry[]) {
    const cellPixels = settings.DIMENSIONS.cell_pixels
    const cw = cellPixels.width
    const ch = cellPixels.height

    const container = this.container
    while (container.children.length > 0) {
      container.removeChildAt(0)
    }

    let i = 0
    for (const entry of entries) {
      const line = container.addChild(new Container())
      line.y = i * ch

      let currentX = 0
      if (entry.icon) {
        const style = this.labelStyle.clone()
        if (entry.iconColor)
          style.fill = parseInt(entry.iconColor.slice(1), 16)
        const textIcon = line.addChild(new Text(entry.icon, style))
        textIcon.x = currentX
      }
      currentX += 2 * cw

      const textEntry = line.addChild(new Text(entry.label, this.labelStyle))
      textEntry.x = currentX
      currentX += (entry.label.length + 0.5) * cw

      if (entry.details !== undefined) {
        const textEntry = line.addChild(new Text(entry.details, this.detailsStyle))
        textEntry.x = currentX
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
  }
}
