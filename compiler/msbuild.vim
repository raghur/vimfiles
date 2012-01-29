" Vim compiler file
" Compiler: msbuild

if exists("current_compiler")
finish
endif
let current_compiler = "msbuild"

function! FindParentProjectFile(file)
    let l:path = fnamemodify (a:file, ":p:h")
"    echom l:path
    let l:found = 0
    while l:found == 0
        let l:projectFile = split(globpath(l:path,  "*.csproj"), "\n", 1)[0]
        if l:projectFile != ""
            return fnamemodify(l:projectFile, ":p")
        else
            let l:path = fnamemodify(l:path, ":h")
"            echom l:path
        endif
    endwhile
endfunction

if exists(":CompilerSet") != 2 " older Vim always used :setlocal
command -nargs=* CompilerSet setlocal <args>
endif

" default errorformat
CompilerSet errorformat=\ %#%f(%l\\\,%c):\ %m
let b:msbuildCommand="msbuild\\ /nologo\\ /v:q\\ /property:GenerateFullPaths=true\\ " . FindParentProjectFile(@%)
" default make
echo "CompilerSet makeprg=" . b:msbuildCommand
execute "CompilerSet makeprg=" . b:msbuildCommand
" Automatically open, but do not go to (if there are errors) the quickfix /
" location list window, or close it when is has become empty.
"
" Note: Must allow nesting of autocmds to enable any customizations for quickfix
" buffers.
" Note: Normally, :cwindow jumps to the quickfix window if the command opens it
" (but not if it's already open). However, as part of the autocmd, this doesn't
" seem to happen.
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow
