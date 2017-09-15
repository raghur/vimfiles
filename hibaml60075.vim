if !has('unix')
    let g:python3_host_prog="d:/sdks/python36/python.exe"
    " let g:python_host_prog="c:/python27/python.exe"
    let g:ruby_host_prog="C:/tools/ruby24/bin/ruby.EXE"
endif

let g:fonts="Fantasque_Sans_Mono:h13:cANSI,"
            \ . "Ubuntu_Mono_derivative_Powerlin:h13,"
            \ . "Source_Code_Pro_Light:h11,"
            \ . "Powerline_Consolas:h11,"
            \ . "DejaVu_Sans_Mono_For_Powerline:h11,"
            \ . "PragmataPro_Mono:h11"
let g:fonts=split(g:fonts, ",")
let g:completor_python_binary = 'd:/sdks/python36/python.exe'
