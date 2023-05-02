
command! -nargs=+ Kirby :lua require'kirby'.openPickerByID(<f-args>)<CR>

command! -nargs=? KirbyFilePicker :lua require'kirby'.openFilePicker(<f-args>)<CR>

if empty(maparg('<C-p>', 'n')) 
    nnoremap <silent> <C-p> :KirbyFilePicker<CR>
end
