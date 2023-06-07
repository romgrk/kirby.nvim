import * as api from './api'
import files from './pickers/files'
import ctags from './pickers/ctags'
import commands from './pickers/commands'

export * from './api'

api.register(files)
api.register(ctags.currentFile)
api.register(commands.list)
api.register(commands.run)
