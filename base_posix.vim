call utils#machine_script(g:home)
let g:GPGExecutable="gpg2"
command! W :execute ':silent w !sudo tee % > /dev/null' | :edit!
