nnoremap <silent> <M-ScrollWheelUp> :call utils#FontSize(1)<CR>
nnoremap <silent> <M-ScrollWheelDown> :call utils#FontSize(-1)<CR>

nnoremap <silent> <M-=> :call utils#FontSize(1)<CR>
nnoremap <silent> <M--> :call utils#FontSize(-1)<CR>

nnoremap <silent> <M-+> :call utils#CycleFont(1)<CR>
nnoremap <silent> <M-_> :call utils#CycleFont(-1)<CR>

if exists("g:neovide")
    let g:neovide_cursor_animation_length=0
    let g:neovide_cursor_vfx_mode=""
endif

if exists('*GuiFont') "trigger only for neovim-qt which has this
    call GuiWindowMaximized(1)
    GuiPopupmenu 0
endif

if exists('g:fvim_loaded')
    nnoremap <A-CR> :FVimToggleFullScreen<CR>
    " FVimCursorSmoothMove v:true
    " FVimCursorSmoothBlink v:true
    " FVimFontAntialias v:true
    " FVimFontAutohint v:true
    " FVimFontSubpixel v:true
    " FVimFontLcdRender v:true
    " FVimFontHintLevel 'full'
    " FVimFontAutoSnap v:true
    " FVimFontLineHeight "+1.0"

    " Font weight tuning, possible valuaes are 100..900
    FVimFontNormalWeight 400
    FVimFontBoldWeight 900

    " Font debugging -- draw bounds around each glyph
    " FVimFontDrawBounds v:true
    FVimUIPopupMenu v:true

endif

if exists("+guicursor")
    set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor25,o:hor25
                \,a:blinkon0-Cursor/lCursor
                \,sm:block-blinkwait175-blinkoff10-blinkon175
endif

if &guifont==""
    call utils#Setfont(g:fonts[0], 15)
endif
" echom "sourced ginit.vim"
