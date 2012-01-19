" Vim compiler file
" Compiler: msbuild

if exists("current_compiler")
finish
endif
let current_compiler = "msbuild"

if exists(":CompilerSet") != 2 " older Vim always used :setlocal
command -nargs=* CompilerSet setlocal <args>
endif

" default errorformat
CompilerSet errorformat=\ %#%f(%l\\\,%c):\ %m

" default make
CompilerSet makeprg=msbuild\ /nologo\ /v:q\ /property:GenerateFullPaths=true

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
