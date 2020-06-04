nnoremap <silent> <C-ScrollWheelUp> :call utils#FontSize(1)<CR>
nnoremap <silent> <C-=> :call utils#FontSize(1)<CR>
nnoremap <silent> <C-ScrollWheelDown> :call utils#FontSize(-1)<CR>
nnoremap <silent> <C--> :call utils#FontSize(-1)<CR>
nnoremap <silent> <C-+> :call utils#CycleFont(1)<CR>
nnoremap <silent> <C-_> :call utils#CycleFont(-1)<CR>
if exists("g:neovide")
    let g:neovide_cursor_animation_length=0
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

    if exists("+guicursor")
        set guicursor=n-v-c:block,i-ci-ve:hor100,r-cr:hor20,o:hor50
                    \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
                    \,sm:block-blinkwait175-blinkoff150-blinkon175
    endif
endif

let g:fonts= ""
            \ . ",Fantasque Sans Mono"
            \ . ",Iosevka Term Curly"
            \ . ",Fira Code"
            \ . ",Bitstream Vera Sans Mono"
            \ . ",Source Code Pro"
            \ . ",Hack"
            \ . ",DejaVu Sans Mono - Bront"
let g:fonts=split(g:fonts, ",")
" let g:fontsize=13
" call utils#Setfont(g:fonts[0]. ":h". g:fontsize)
if &guifont==""
    call utils#Setfont(g:fonts[0], 15)
endif
