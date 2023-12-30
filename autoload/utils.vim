let s:level=0
fun! s:log(lvl, ...) abort
    let levels = ['', 'INFO', 'DBG']
    let targetLvl = s:level
    if has_key(environ(), 'NVIM_LOG')
        let targetLvl = $NVIM_LOG
    endif
    if a:lvl <= targetLvl
        if has('vim_starting')
            " record to history for inspection
            echom levels[a:lvl].': '. join(a:000[0], ' ')
        else
            echo levels[a:lvl].': '.join(a:000[0], ' ')
        endif
    endif
endfun
fun! utils#dbg(...) abort
    call s:log(1, a:000)
endfunction

fun! utils#info(...) abort
    call s:log(2, a:000)
endfunction

fun! utils#loglvl(lvl) abort
    if a:lvl == 'INFO'
        let $NVIM_LOG=1
    elseif a:lvl == 'DBG'
        let $NVIM_LOG=2
    else
        let $NVIM_LOG=0
    endif
endfunction

fun! utils#createIfNotExists(dir) abort
    if !isdirectory(a:dir)
        call mkdir(a:dir, 'p')
    endif
endfunction

func! utils#ReadExCommandOutput(newbuf, cmd) abort
    redir => l:message
    silent! execute a:cmd
    redir END
    if a:newbuf | wincmd n | endif
    silent put=l:message
endf

fun! utils#RemoveCtrlM() abort
    :update
    :e ++ff=dos
    :%s/\r$//e
endfun

function! utils#MkNonExDir(file, buf) abort
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction

function! utils#toggleZoom() abort
    if tabpagewinnr(tabpagenr(), '$') > 1
        :tab split
    else 
        :tabclose
    endif
endfun
