
function! RipgrepFzf(query, fullscreen)
    let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#wrap(spec), a:fullscreen)
endfunction
let $FZF_DEFAULT_COMMAND='find . \! \( -type d -path ./.git -prune \) \! -type d \! -name ''*.tags'' -printf ''%P\n'''
nnoremap <silent> <leader><space> :Files<cr>
nnoremap <silent> <leader>r :History<cr>
nnoremap <silent> <c-tab> :History<cr>
nnoremap <silent> <leader>t :Tags<cr>
nnoremap <silent> <leader>, :exe "Files ".expand("%:p:h")<cr>
nnoremap <silent> <leader>l :BLines<cr>
nnoremap <silent> <leader>co :Colors<cr>
nnoremap <silent> <leader>: :Commands<cr>
nnoremap <silent> <leader>m :Marks<cr>
nnoremap <silent> <leader>* :exe "Rg ".expand('<cword>')<cr>
" interactive grep mode
nnoremap <silent> <leader>g :Rg<cr>
