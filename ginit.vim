if exists('*GuiFont') "trigger only for neovim-qt which has this
    let g:fonts=
                \ "Input:h12"
                \ . ",Fantasque Sans Mono:h13"
                \ . ",Iosevka:h13"
                \ . ",Source Code Pro:h13"
                \ . ",Hack:h13"
                \ . ",Fira Code:h13"
    let g:fonts=split(g:fonts, ",")
    call Setfont(g:fonts[0])
endif
call GuiWindowMaximized(1)
GuiPopupmenu 0
