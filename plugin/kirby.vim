command! -nargs=? KirbyFilePicker :lua require'kirby'.openFilePicker(<f-args>)<CR>

if empty(maparg('<C-p>', 'n')) 
    nnoremap <silent> <C-p> :KirbyFilePicker<CR>
end
