call utils#machine_script()
let g:GPGExecutable="gpg2"
command! W :execute ':silent w !sudo tee % > /dev/null' | :edit!
" echom "sourced " . expand("<sfile>")
