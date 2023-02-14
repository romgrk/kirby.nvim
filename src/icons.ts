import * as devicons from 'nvim-web-devicons'

const icons = devicons.get_icons()
const defaultIcon = {
  icon: '',
  color: undefined,
}

export function getIcon(filename: string, extname: string) {
  return icons[filename] ?? icons[extname.slice(1)] ?? defaultIcon
}
