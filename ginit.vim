if exists('*GuiFont') "trigger only for neovim-qt which has this
    let g:fonts=
                \ "Fantasque\ Sans\ Mono:h13,"
                \ . "Input:h12"
    let g:fonts=split(g:fonts, ",")
    echom "setting font"
    call Setfont(g:fonts[0])
endif
call GuiWindowMaximized(1)
