fun! utils#machine_script(base)
    let machine_file = glob(a:base . tolower(hostname()) . '.vim')
    if !empty(machine_file)
        exec "so " . machine_file
    endif
endfun

function! utils#os_script(base)
    if has('win32')
        let machine_file = glob(a:base . "base_windows.vim")
    else
        let machine_file = glob(a:base . "base_posix.vim")
    endif
    exec "so " . machine_file
endfun

fun! utils#createIfNotExists(dir)
    if !isdirectory(a:dir)
        call mkdir(a:dir, "p")
    endif
endfunction

func! utils#systemwrapper(cmd)
    echom a:cmd
    let output=system(a:cmd)
    return output
endfunction

func! utils#GitBrowser()
    if executable('smerge')
        let cmd = "smerge "
    elseif executable("gitex")
        let cmd = "gitex "
    endif
    let cmd = cmd . '"' . expand("%:p:h") . '"'
    call utils#systemwrapper(cmd)
endfunc

func! utils#Filemanager()
    if executable('explorer')
        let cmd = "explorer "
    elseif executable('dolphin')
        let cmd = "dolphin "
    endif
    let cmd = cmd . '"' . expand("%:p:h") . '"'
    call utils#systemwrapper(cmd)
endfunc

func! utils#Console()
    if executable('ConEmu64')
        let cmd='start ConEmu64 -dir "'. expand("%:p:h"). '" -run {cmd}'
    elseif exists("$TMUX")
        let cmd="tmux splitw -h -c " . expand("%:p:h")
    elseif executable("konsole")
        let cmd="konsole --workdir " . expand("%:p:h"). " &"
    else
        let cmd="xterm"
    endif
    call utils#systemwrapper(cmd)
endfun

func! utils#ReadExCommandOutput(newbuf, cmd)
    redir => l:message
    silent! execute a:cmd
    redir END
    if a:newbuf | wincmd n | endif
    silent put=l:message
endf

function! utils#ToHtml()
    :w
    let file=expand("%:p")
    let outfile=fnamemodify(file, ":r") . ".html"
    if &ft == 'markdown'
        let css=fnamemodify(file, ":h") . "pandoc.css"
        exec "silent !pandoc --toc  -c ". css .
                    \ " -F mermaid-filter.cmd" .
                    \ "  -fmarkdown_github" .
                    \ "+footnotes" .
                    \ "+implicit_header_references".
                    \ "+auto_identifiers".
                    \ "+superscript".
                    \ "+subscript".
                    \ "+fancy_lists".
                    \ "+startnum".
                    \ "+strikeout -i " . file . " -o " . outfile
    elseif &ft == 'asciidoc'
        exec "silent !asciidoctor -a icons:font -a sectnums -a sectlinks ". file
    endif
    echom "wrote" . " " . outfile
    call xolox#misc#open#url("file:///".substitute(outfile, "\\", "/", "g"))
endfunction

fun! utils#RemoveCtrlM()
    :update
    :e ++ff=dos
    :%s/\r$//e
endfun

function! utils#Getfont()
    let font=""
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

function! utils#Setfont(font)
    if exists('+GuiFont')
        exec "GuiFont! " . a:font
    elseif exists('+guifont')
        exec "set guifont=".substitute(a:font, " ", "\\\\ ", "g")
    else
        :silent !echo "Running in console - change your console font."
    endif
    " redraw \| echo a:font
endfunction

fun! utils#CycleFont(dir)
    if !exists("g:fonts")
        return
    endif
    call utils#FontSize(0)
    let font = substitute(utils#Getfont(), ':h'.g:fontsize, '','')
    let c = utils#CycleArray(g:fonts, font, a:dir)
    "let font = substitute(arr[c], " ", '\\ ', "g")
    call utils#Setfont(g:fonts[c]. ":h". g:fontsize)
endfun

function! utils#FontSizeInt(size, inc) 
    let g:fontsize=a:size+a:inc
    return ":h".(a:size + a:inc)
endfunction

function! utils#FontSize(sizeInc)
    let pattern = ':h\(\d\+\)'
    if exists("+guifont")
        if a:sizeInc > 0
            let &guifont=substitute(&guifont, pattern, '\=utils#FontSizeInt(submatch(1), 1)', '')
        elseif a:sizeInc < 0
            let &guifont=substitute(&guifont, pattern, '\=utils#FontSizeInt(submatch(1), -1)', '')
        else
            " only sets global var g:fontsize
            let &guifont=substitute(&guifont, pattern, '\=utils#FontSizeInt(submatch(1), 0)', '')
        endif
    endif
endfunction

fun! utils#CycleColorScheme(dir)
    let c = utils#CycleArray(g:colorschemes, g:colors_name, a:dir)
    let scheme = g:colorschemes[c]
    exec "colors " scheme
    redraw | echom "Setting colorscheme to: ".scheme
endfun

fun! utils#CycleArray(arr, value, dir)
    let c = index(a:arr, a:value) + a:dir
    if (a:dir > 0)
        if (c >= len(a:arr))
            let c = 0
        endif
    else
        if (c < 0)
            let c = len(a:arr) - 1
        endif
    endif
    return c
endfunction

function! utils#MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction

function! utils#ZoomWindow()
    if winheight(0) >= (&lines - 4) && winwidth(0) >= (&columns - 2)
        exec "resize " . g:lastwh " | vertical resize ". g:lastww
    else
        let g:lastwh = winheight(0)
        let g:lastww = winwidth(0)
        wincmd _
        wincmd |
    endif
endfun

func! utils#BlogSave(file)
    " to debug, replace with
    " exec "!easyblogger file " . a:file
    let output=utils#systemwrapper("easyblogger file ". a:file)
    echom output
endfunction

func! utils#StartWatcher(action)
    let file=expand("%:p")
    let action = substitute(a:action, "%[:a-z]*", "\\=expand(submatch(0))", "g")
    let outfile = substitute(file, "\\", "/", "g")
    if &ft == 'asciidoc'
        " The asciidoc browser plugin does a good enough job if you don't use 
        " other features like diagrams and such. In that, we can get rid of 
        " this code and just open the current file in the browser.
        "
        " let jobId=jobstart("chokidar ". file . " -c \"" . action . "\"")
        let cmd = "chokidar ". file . " -c \"" . "asciidoctor " . file  . "\""
        let jobId=jobstart(cmd)
        let outfile = substitute(outfile, ".adoc$", ".html", "g")
        echom cmd
    elseif &ft == 'markdown' || &ft == 'pandoc'
        let css=glob($HOME . "/pandoc.css")
        let css = "file:///" . substitute(css, '\\', '/' , "g")
        let outfile = substitute(outfile, '\v\.(markdown|md|rst)$', ".html", "g")
        let pandocCmd = "pandoc -t html --toc --css " . css .
                    \ " -F mermaid-filter.cmd" .
                    \ " -fmarkdown_github" .
                    \ "+footnotes" .
                    \ "+implicit_header_references".
                    \ "+auto_identifiers".
                    \ "+superscript".
                    \ "+subscript".
                    \ "+fancy_lists".
                    \ "+startnum".
                    \ "+strikeout -o " . outfile . " -i "
        let action = substitute(action, "pandoc", pandocCmd, "g")
        let chokidarCmd = "chokidar ". file . " -c \"" . action . file. "\""
        echom chokidarCmd
        let jobId=jobstart(chokidarCmd)
    else
        return
    endif
    call xolox#misc#open#url("file:///". outfile)
    if !exists("b:jobIds")
        let b:jobIds =[]
    endif
    let b:jobIds = b:jobIds + [jobId]
    " echom "Watcher job ids: ". join(b:jobIds, ", ")
endfunction

func! utils#CleanupWatcher()
    if !exists("b:jobIds")
        return
    endif
    for j in b:jobIds
        call jobstop(j)
    endfor
    unlet b:jobIds
    echom "Watchers cleaned"
endfunc

fun! utils#GhostStart()
    if exists(":GhostStart") == 2
        GhostStart
    endif
endfun
