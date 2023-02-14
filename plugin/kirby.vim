command! KirbyFilePicker :lua require'kirby'.openFilePicker()<CR>

if empty(maparg('<C-p>', 'n')) 
    nnoremap <silent> <C-p> :KirbyFilePicker<CR>
end
