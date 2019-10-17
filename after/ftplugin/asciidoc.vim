" From https://github.com/mjakl/vim-asciidoc/
" Fixed it so that it doesn't interpret every line starting with `=` as heading
" Removed conditional fold options
function! Foldexpr_asciidoc(lnum)
    let l0 = getline(a:lnum)
    if l0 =~ '^=\{1,5}\s\+\S.*$'
        return '>'.matchend(l0, '^=\+')
    else
        return '='
    endif
endfunc

setlocal foldexpr=Foldexpr_asciidoc(v:lnum)
setlocal foldmethod=expr