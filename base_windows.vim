
func! s:local()
    call utils#machine_script(g:home)
    let g:fonts="Fantasque_Sans_Mono:h13:cANSI,"
                \ . "Ubuntu_Mono_derivative_Powerlin:h13,"
                \ . "Source_Code_Pro_Light:h11,"
                \ . "Powerline_Consolas:h11,"
                \ . "DejaVu_Sans_Mono_For_Powerline:h11,"
                \ . "PragmataPro_Mono:h11"
    let g:fonts=split(g:fonts, ",")
endfun

call s:local()
