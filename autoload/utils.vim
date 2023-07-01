let s:level=0
fun! s:debug(...) abort
    if s:level
        echo 'debug: '. join(a:000, ' ')
    endif
endfun
fun! utils#machine_script() abort
    let machine_file = tolower(hostname()) . '.vim'
    exe 'runtime ' . machine_file
endfun

function! utils#configurePlugin(name) abort
    let filepath = g:home . 'plugins/' . a:name . '.vim'
    if (filereadable(filepath)) 
        exec 'source ' . filepath
        echom 'sourced ' filepath
    else 
        let filepath = g:home . 'plugins/' . a:name . '.lua'
        if (filereadable(filepath) && has('nvim')) 
            exec 'luafile ' . filepath
            echom 'sourced ' filepath
        endif
    endif
endfun

function! utils#os_script() abort
    let machine_file = 'base_posix.vim'
    if has('win32')
        let machine_file = 'base_windows.vim'
    endif
    exec 'runtime ' . machine_file
endfun

fun! utils#createIfNotExists(dir) abort
    if !isdirectory(a:dir)
        call mkdir(a:dir, 'p')
    endif
endfunction

func! utils#systemwrapper(cmd) abort
    echom a:cmd
    let output=system(a:cmd)
    return output
endfunction

func! utils#GitBrowser() abort
    if executable('smerge')
        let cmd = 'smerge '
    elseif executable('gitex')
        let cmd = 'gitex '
    endif
    let cmd = cmd . '"' . expand('%:p:h') . '"'
    call utils#systemwrapper(cmd)
endfunc

func! utils#Filemanager() abort
    if executable('explorer')
        let cmd = 'explorer '
    elseif executable('dolphin')
        let cmd = 'dolphin '
    endif
    let cmd = cmd . '"' . expand('%:p:h') . '"'
    call utils#systemwrapper(cmd)
endfunc

func! utils#Console() abort
    if executable('ConEmu64')
        let cmd='start ConEmu64 -dir '. expand('%:p:h'). ' -run {cmd}'
    elseif exists('$TMUX')
        let cmd='tmux splitw -h -c ' . expand('%:p:h')
    elseif executable('konsole')
        let cmd='konsole --workdir ' . expand('%:p:h'). ' &'
    else
        let cmd='xterm'
    endif
    call utils#systemwrapper(cmd)
endfun

func! utils#ReadExCommandOutput(newbuf, cmd) abort
    redir => l:message
    silent! execute a:cmd
    redir END
    if a:newbuf | wincmd n | endif
    silent put=l:message
endf

function! utils#ToHtml() abort
    :w
    let file=expand('%:p')
    let outfile=fnamemodify(file, ':r') . '.html'
    if &ft == 'markdown'
        let css=fnamemodify(file, ':h') . 'pandoc.css'
        exec 'silent !pandoc --toc  -c '. css .
                    \ ' -F mermaid-filter.cmd' .
                    \ '  -fmarkdown_github' .
                    \ '+footnotes' .
                    \ '+implicit_header_references'.
                    \ '+auto_identifiers'.
                    \ '+superscript'.
                    \ '+subscript'.
                    \ '+fancy_lists'.
                    \ '+startnum'.
                    \ '+strikeout -i ' . file . ' -o ' . outfile
    elseif &ft == 'asciidoc'
        exec 'silent !asciidoctor -a icons:font -a sectnums -a sectlinks '. file
    endif
    echom 'wrote' . ' ' . outfile
    call xolox#misc#open#url('file:///'.substitute(outfile, '\\', '/', 'g'))
endfunction

fun! utils#RemoveCtrlM() abort
    :update
    :e ++ff=dos
    :%s/\r$//e
endfun

function! utils#Getfont() abort
    let font=''
    if exists('+GuiFont')
        redir => font
        GuiFont
        redir END
        return substitute(font, '\r\+\|\n\+', '','')
    elseif exists('+guifont')
        return &guifont
    else
        :silent !echo "Running in console - cannot get font name"
    endif
endfunction

let s:fontsep=' '
if has('nvim') || has('win32') || has('win64')
    let s:fontsep=':h'
endif

function! utils#Setfont(font, size) abort 
    call s:debug('inputs', a:font , 'size:', a:size)
    if exists('+GuiFont')
        exec 'GuiFont! ' . a:font
    elseif exists('+guifont')
        let fontspec=a:font. s:fontsep . a:size
        let newfont = substitute(fontspec, ' ', '\\ ', 'g')
        call s:debug ('Setting to:',newfont)
        exec 'set guifont='.newfont
        echom newfont
        call s:debug('set font done')
    else
        :silent !echo 'Running in console - change your console font.'
    endif
endfunction

fun! utils#CycleFont(dir) abort
    if !exists('g:fonts')
        return
    endif
    let size=utils#FontSize(0)
    let pattern=s:fontsep.g:fontsize
    let font = trim(substitute(utils#Getfont(), pattern,'','g'))
    let c = utils#CycleArray(g:fonts, font, a:dir)
    call utils#Setfont(c, size)
endfun

function! utils#FontSizeInt(size, inc) abort
    let g:fontsize=a:size+a:inc
    return g:fontsize
endfunction

function! utils#AdjustFontSize(sizeInc) abort
    let font = utils#Getfont()
    let fontname=substitute(font, '\(:h\)\=\(\d\+\)', '', '')
    let newSize=utils#FontSize(a:sizeInc)
    call utils#Setfont(fontname, newSize)
endfun
    function! utils#FontSize(sizeInc) abort
    let pattern = '.\{-}:h\(\d\+\)'
    let font=utils#Getfont()
    call s:debug('font',font)
    let fontname=substitute(font, '\(:h\)\=\(\d\+\)', '', '')
    if a:sizeInc > 0
        let size=substitute(font, pattern, '\=utils#FontSizeInt(submatch(1), 1)', '')
    elseif a:sizeInc < 0
        let size=substitute(font, pattern, '\=utils#FontSizeInt(submatch(1), -1)', '')
    else
        let size=substitute(font, pattern, '\=utils#FontSizeInt(submatch(1), 0)', '')
    endif
    call s:debug('size',size)
    return size
endfunction

let g:fonts=[]
function utils#SetFonts(...) abort
    for f in a:000
        let g:fonts = g:fonts + [f]
    endfor
endfunction

let s:colorschemes={}
function utils#SetColors(...) abort
    for kv in a:000
        let p = split(kv, ',')
        let cname=p[0]
        let bg = ''
        if len(p) == 2
            let bg = p[1]
        endif
        let s:colorschemes[cname] = bg
    endfor
endfunction

fun! utils#CycleColorScheme(dir) abort
    let bg = &background
    let arr = keys(s:colorschemes)
    let c = utils#CycleArray(arr, g:colors_name, a:dir)
    let scheme = arr[c]
    let bgScheme = s:colorschemes[l:scheme]
    if bgScheme == ''
        exec 'set background='.bg
    else
        exec 'set background='. bgScheme
    endif
    exec 'colors '. scheme
    redraw | echom scheme &background
endfun

function! utils#CycleArray(arr, value, dir) abort
    call s:debug('inputs:', a:value,'dir:',a:dir)
    let c = index(a:arr, a:value) + a:dir
    call s:debug('found c:',c)
    let _size = len(a:arr)
    call s:debug('size',_size)

    if c < 0
        let c = _size - 1
    endif

    if c >= _size
        let c = 0
    endif
    return a:arr[c]
endfunction

function! utils#MkNonExDir(file, buf) abort
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction

let s:lastwh=0
let s:lastww=0
function! utils#ZoomWindow() abort
    if winheight(0) >= (&lines - 4) && winwidth(0) >= (&columns - 2)
        exec 'resize ' . s:lastwh ' | vertical resize '. s:lastww
    else
        let s:lastwh = winheight(0)
        let s:lastww = winwidth(0)
        wincmd _
        wincmd |
    endif
endfun
