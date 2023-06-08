import * as api from './api'
import files from './pickers/files'
import howdoi from './pickers/howdoi'
import commands from './pickers/commands'
import ctags from './pickers/ctags'
import coc from './pickers/coc'

export * from './api'

api.register(files)
api.register(howdoi)
api.register(commands.list)
api.register(commands.run)
api.register(ctags.currentFile)
api.register(coc.diagnostics)
api.register(coc.workspaceSymbols)
