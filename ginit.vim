function! Getfont()
    let font=""
    if exists('*GuiFont')
        redir => font
        GuiFont
        redir END
        return substitute(font, '\r\+\|\n\+', '','')
    else
        return &guifont
    endif
endfunction

function! Setfont(font)
    " echom "Setting font to: ". a:font
    if exists('*GuiFont')
        exec "GuiFont! " . a:font
    elseif exists('+guifont')
        exec "set guifont=".substitute(a:font, " ", "\\\\ ", "g")
    else
        :silent !echo "Running in console - change your console font."
    endif
endfunction
command! FontNext call utils#CycleFont(1)
command! FontPrev call utils#CycleFont(-1)

if exists('*GuiFont') "trigger only for neovim-qt which has this
    call GuiWindowMaximized(1)
    GuiPopupmenu 0
endif
if exists('g:fvim_loaded')
    " Ctrl-ScrollWheel for zooming in/out
    nnoremap <silent> <C-ScrollWheelUp> :set guifont=+<CR>
    nnoremap <silent> <C-=> :set guifont=+<CR>
    nnoremap <silent> <C-ScrollWheelDown> :set guifont=-<CR>
    nnoremap <silent> <C--> :set guifont=-<CR>
    nnoremap <silent> <C-+> :call utils#CycleFont(1)<CR>
    nnoremap <silent> <C-0> :call Setfont(g:fonts[1])<CR>
    nnoremap <A-CR> :FVimToggleFullScreen<CR>
    " FVimCursorSmoothMove v:true
    " FVimCursorSmoothBlink v:true
    FVimFontAntialias v:true
    FVimFontAutohint v:true
    FVimFontSubpixel v:true
    FVimFontLcdRender v:true
    FVimFontHintLevel 'full'
    FVimFontAutoSnap v:true
    FVimFontLineHeight "+1.0"

    " Font weight tuning, possible valuaes are 100..900
    FVimFontNormalWeight 400
    FVimFontBoldWeight 900

    " Font debugging -- draw bounds around each glyph
    " FVimFontDrawBounds v:true
    FVimUIPopupMenu v:true
    set guicursor=n-v-c:block,i-ci-ve:hor100,r-cr:hor20,o:hor50
          \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
          \,sm:block-blinkwait175-blinkoff150-blinkon175
endif
let g:fonts=
            \ "Bitstream Vera Sans Mono:h12"
            \ . ",iA Writer Mono:h12"
            \ . ",Input:h12"
            \ . ",Fantasque Sans Mono:h13"
            \ . ",Iosevka:h13"
            \ . ",Source Code Pro:h13"
            \ . ",Hack:h13"
            \ . ",Fira Code:h13"
let g:fonts=split(g:fonts, ",")
call Setfont(g:fonts[1])
