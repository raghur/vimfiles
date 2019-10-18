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
    call GuiWindowMaximized(1)
    GuiPopupmenu 0
endif
if exists('g:fvim_loaded')
    " good old 'set guifont' compatibility
    set guifont=Fantasque\ Sans\ Mono:h19
    " Ctrl-ScrollWheel for zooming in/out
    nnoremap <silent> <C-ScrollWheelUp> :set guifont=+<CR>
    nnoremap <silent> <C-ScrollWheelDown> :set guifont=-<CR>
    nnoremap <A-CR> :FVimToggleFullScreen<CR>
    " FVimCursorSmoothMove v:true
    " FVimCursorSmoothBlink v:true
    FVimFontAntialias v:true
    FVimFontAutohint v:true
    FVimFontSubpixel v:true
    FVimFontLcdRender v:true
    FVimFontHintLevel 'full'
    " FVimFontLineHeight '+1.0' " can be 'default', '14.0', '-1.0' etc.
    FVimFontAutoSnap v:true

    " Font weight tuning, possible valuaes are 100..900
    FVimFontNormalWeight 200
    FVimFontBoldWeight 900

    " Font debugging -- draw bounds around each glyph
    " FVimFontDrawBounds v:true
    FVimUIPopupMenu v:true
    set guicursor=n-v-c:block,i-ci-ve:hor100,r-cr:hor20,o:hor50
          \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
          \,sm:block-blinkwait175-blinkoff150-blinkon175
endif
