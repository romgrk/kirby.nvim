
" Commands

command! -nargs=+ -complete=custom,KirbyComplete Kirby :lua require'kirby'.openPickerByID(<f-args>)<CR>
function KirbyComplete(A, L, P)
  return join(v:lua.require('kirby').listPickers(), "\n")
endfunction

command! -nargs=? KirbyFilePicker :lua require'kirby'.openFilePicker(<f-args>)<CR>

" Mappings

if empty(maparg('<C-p>', 'n')) 
  nnoremap <silent> <C-p> :KirbyFilePicker<CR>
end
