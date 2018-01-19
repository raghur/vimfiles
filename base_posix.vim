call utils#machine_script(g:home)
let g:fonts= "Fantasque\ Sans\ Mono\ 11,"
            \ . "Meslo\ LG\ S\ for\ Powerline\ 12,"
            \ . "Monaco\ for\ Powerline\ 12,"
            \ . "Pragmata\ Pro\ 13,"
            \ . "Source\ Code\ Pro\ for\ Powerline\ 12,"
            \ . "DejaVu\ Sans\ Mono\ for\ Powerline\ 12,"
            \ . "Monospace\ 10,"
            \ . "Ubuntu\ Mono\ 11"
let g:fonts=split(g:fonts, ",")
let g:GPGExecutable="gpg2"
command! W :execute ':silent w !sudo tee % > /dev/null' | :edit!
