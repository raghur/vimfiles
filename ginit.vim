nnoremap <silent> <M-]> :call utils#CycleFont(1)<CR>
nnoremap <silent> <M-[> :call utils#CycleFont(-1)<CR>

if exists('+guicursor')
    set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor25,o:hor25
                \,a:blinkon0-Cursor/lCursor
                \,sm:block-blinkwait175-blinkoff10-blinkon175
endif

if exists('g:neovide')
    " Put anything you want to happen only in Neovide here
    " let g:neovide_remember_window_size = v:true
    let g:neovide_underline_automatic_scaling = v:true
    let g:neovide_cursor_animation_length = 0.01
    let g:neovide_cursor_trail_length=0.01
    let g:neovide_remember_window_size=v:true
    let g:neovide_cursor_antialiasing=v:true
    let g:neovide_cursor_vfx_mode = ''
endif

if exists('g:fvim_loaded')
    nnoremap <A-CR> :FVimToggleFullScreen<CR>
    FVimBackgroundComposition 'acrylic'
    FVimBackgroundOpacity 0.95
    FVimBackgroundAltOpacity 0.95
    FVimBackgroundComposition 'acrylic'
    FVimCursorSmoothMove v:false
    FVimCursorSmoothBlink v:true
    FVimFontAntialias v:true
    FVimFontAutohint v:true
    FVimFontSubpixel v:true
    FVimFontLigature v:true
    FVimFontNoBuiltinSymbols v:true
    " FVimFontHintLevel 'full'
    FVimFontAutoSnap v:true
    " FVimFontLineHeight "+1.0"

    " Font weight tuning, possible valuaes are 100..900
    FVimFontNormalWeight 400
    FVimFontBoldWeight 700

    " Font debugging -- draw bounds around each glyph
    " FVimFontDrawBounds v:true
    FVimUIPopupMenu v:true
endif

" echom "sourced ginit.vim"
