" Last change:  2008 Dec 17
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"         for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"       for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
    finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
set hidden
set showmode 
filetype plugin indent on
" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
    set nobackup      " do not keep a backup file, use versions instead
else
    set backup        " keep a backup file
endif
set history=50      " keep 50 lines of command line history
set ruler       " show the cursor position all the time
set showcmd     " display incomplete commands
set incsearch       " do incremental searching
set encoding=utf-8

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
    set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

    " Enable file type detection.
    " Use the default filetype settings, so that mail gets 'tw' set to 72,
    " 'cindent' is on in C files, etc.
    " Also load indent files, to automatically do language-dependent indenting.
    filetype plugin indent on

    " Put these in an autocmd group, so that we can delete them easily.
    augroup vimrcEx
        au!

        " For all text files set 'textwidth' to 120 characters.
        autocmd FileType text setlocal textwidth=120

        " When editing a file, always jump to the last known cursor position.
        " Don't do it when the position is invalid or when inside an event handler
        " (happens when dropping a file on gvim).
        " Also don't do it when the mark is in the first line, that is the default
        " position when opening a file.
        autocmd BufReadPost *
                    \ if line("'\"") > 1 && line("'\"") <= line("$") |
                    \   exe "normal! g`\"" |
                    \ endif

    augroup END

else

    set autoindent        " always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
                \ | wincmd p | diffthis
endif

let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc("$HOME/.vim/bundle")

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'
Bundle 'kshenoy/vim-signature'
Bundle 'https://git.gitorious.org/vim-gnupg/vim-gnupg'
Bundle 'raghur/VimRepress'
Bundle 'raghur/vim-helpnav'
Bundle 'vim-scripts/L9'
Bundle 'altercation/vim-colors-solarized'
Bundle 'kien/ctrlp.vim'
Bundle 'Raimondi/delimitMate'
Bundle 'sjl/gundo.vim'
Bundle 'wikitopian/hardmode'
Bundle 'hallettj/jslint.vim'
Bundle 'gregsexton/MatchTag'
Bundle 'scrooloose/nerdcommenter'
Bundle 'sjl/splice.vim'
Bundle 'SirVer/ultisnips'
"Bundle 'Valloric/YouCompleteMe'
Bundle 'scrooloose/syntastic'
Bundle 'kchmck/vim-coffee-script'
Bundle 'raghur/vim-colorschemes'
Bundle 'pangloss/vim-javascript'
Bundle 'elzr/vim-json'
Bundle 'tsaleh/vim-matchit'
Bundle 'tpope/vim-ragtag'
Bundle 'xolox/vim-misc'
Bundle 'xolox/vim-session'
Bundle 'tpope/vim-surround'
Bundle 'kana/vim-textobj-indent'
Bundle 'kana/vim-textobj-user'
Bundle 'maxbrunsfeld/vim-yankstack'
Bundle 'mattn/zencoding-vim'
" vim-airline and fonts
Bundle 'bling/vim-airline'
Bundle 'Lokaltog/powerline-fonts'
Bundle 'nosami/Omnisharp'
Bundle 'tpope/vim-dispatch'
Bundle 'airblade/vim-rooter'
" Powerline v1 and fonts
"Bundle 'Lokaltog/vim-powerline'
"Bundle 'eugeneching/consolas-powerline-vim'
" autocomplpop
"Bundle 'clones/vim-autocomplpop'
"source $HOME/.vim/autocomplpop-custom.vim
 "neocomplete
 Bundle 'Shougo/neocomplete.vim'
source $HOME/.vim/neocomplete-custom.vim
filetype plugin indent on

set wildchar=<Tab> wildmenu
set wildmode=longest,list
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set pastetoggle=<F11>
set ignorecase smartcase
set guioptions-=T
set guioptions-=r
set guioptions+=R
let g:proj_flags="imstg"
set ttimeoutlen=50

" disable arrow keys
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>

map [[ ?{<CR>w99[{
map ][ /}<CR>b99]}
map ]] j0[[%/{<CR>
map [] k$][%?}<CR>

let s:find_prog = "grep"
let s:grepopts='\ --exclude-dir=.git\ --exclude-dir=.svn\ --exclude-dir=tmp\ --exclude=*.tmp\ --exclude=*.min.js\ -PHIirn'
let s:ackopts='\ -a\ --no-group\ -Hi '
if has('win32')
    set guifont=Source_Code_Pro_ExtraLight:h12
    "set guifont=DejaVu\ Sans\ Mono\ For\ Powerline:h11
    let s:ack="f:/utils/ack.bat"
    let s:find=fnamemodify(findfile("find.exe", $GNUWIN."**"), ":p")
    let s:grep=fnamemodify(findfile("grep.exe", $GNUWIN."**"), ":p")
else
    let s:ack="ack"
    let s:find="find"
    let s:grep="grep"
    set guifont=Monospace\ 10,Ubuntu\ Mono\ 11,DejaVu\ Sans\ Mono\ 10
endif
execute "set grepprg=" . eval("s:".s:find_prog)."\\ ".eval("s:".s:find_prog."opts")
fun! Grep_with_args(patt, fileglob)
    let pattern=input("Perl regex: ", a:patt)
    let filepat=input("Find opts : ", a:fileglob)
    let folder=input("Path: ", expand("%:p:h"))
    let filelist=join(split(globpath(folder, "**/".filepat), "\n"), " ")
    let cmd="silent lgrep! '". pattern . "' ". filelist. "| lopen"
    "echom cmd
    execute cmd
endfun

" vim-airline configuration
set lz
let g:airline_enable_fugitive=0
let g:airline_enable_syntastic=1
let g:airline_powerline_fonts=1
" powerline symbols
if (&guifont =~ 'Powerline')
    let g:airline_left_sep = ''
    "let g:airline_left_sep = ''
    "let g:airline_right_sep = ''
    let g:airline_right_sep = ''
    let g:airline_fugitive_prefix = '   '
    let g:airline_readonly_symbol = ''
    let g:airline_linecolumn_prefix = ' '
endif
set t_Co=256
if &term == "xterm" || &term== "screen-256color"
    set term=xterm-256color
endif
set path+=$HOME,.,,~/git,~/code

" avoids messing up folders with *.swp and file~ backups
set backupdir=~/.vim/.vimbackups
set directory=~/.vim/.vimbackups
set switchbuf=usetab
set matchpairs+=<:>
set showmatch
set nowrap
set copyindent
set smarttab
set smartindent
set wildignore+=*.swp,*.bak,*.class,.git/*,.svn/*,.git\*,.svn\*
set visualbell
set noerrorbells
set list
set listchars=tab:▶.,trail:░,extends:➤,nbsp:.
au BufNewFile,BufRead *.aspx set filetype=html
au BufNewFile,BufRead *.cshtml set filetype=html
au BufNewFile,BufRead *.ascx set filetype=html
au BufNewFile,BufRead *.moin setf moin
au BufNewFile,BufRead *.wiki setf moin
au BufNewFile,BufReadPost *.coffee setl foldmethod=indent, nofoldenable
au filetype help :wincmd L

" random stuff..
set foldmethod=syntax
set relativenumber
set nu
let mapleader = " "
let maplocalleader='\'
" Search customizations
" replace all instances in a line.
set gdefault
nnoremap / /\v
nnoremap <leader>h  :noh<cr>
map <leader>f :execute "silent lgrep! \\b" . expand("<cword>") . "\\b *" <Bar>lopen<CR>
map <leader>ff :call Grep_with_args("\\b".expand("<cword>")."\\b", ".*")<cr>
map <leader>fc :lcl <cr>
map <leader>pw :ed ~\.gnupg\passwords.txt.asc <cr>
vnoremap > >gv
vnoremap < <gv


" keybindings
set colorcolumn=120
nnoremap 0 ^
nnoremap ^ 0
noremap <C-s> :w<cr>
nnoremap <leader>p :b#<cr>
nnoremap <leader>sv :ed ~/.vim/_vimrc<cr>
nnoremap <F5> :GundoToggle<CR>
vnoremap <leader>v "0p

" select forward brace block on the line
nnoremap <Leader><Leader> V/{<cr>%
vnoremap <leader><leader>  /{<cr>%

" same as before but do it based on %
nnoremap <Leader>5  V/\v[{(\[\<]<cr>%
vnoremap <leader>5  /\v[{(\[\<]<cr>%


" copy a block and comment it and move to insert mode
vmap <leader>ce  <S-v>ygv<Leader>cc`>pi
inoremap <C-e> <C-o>:call search("\\%" . line(".") . "l[{}() :=\\[\\]\.,\\n]","We")<cr>
inoremap <C-a> <C-o>:call search("\\%" . line(".") . "l[{}() :=\\[\\]\.,]","Web")<cr>
"inoremap <esc> <c-o>:echoe "use jk"<cr>
inoremap jk <esc>

" colors
if has("gui_running")
    set background=light
else
    set background=dark
endif
set background=light
let g:solarized_termcolors=256
colors darkblack
set laststatus=2

" Clipboard integration
set clipboard=unnamed

"Move lines
nnoremap <A-j> :m+<CR>==
nnoremap <A-k> :m-2<CR>==
inoremap <A-j> <Esc>:m+<CR>==gi
inoremap <A-k> <Esc>:m-2<CR>==gi
vnoremap <A-j> :m'>+<CR>gv=gv
vnoremap <A-k> :m-2<CR>gv=gv

"Move by screen lines
nnoremap j gj
nnoremap k gk


let VIMPRESS = [{'username':'rraghur',
            \'password':'',
            \'blog_url':'http://niftybits.wordpress.com'
            \}]
let VIMREPRESS = VIMPRESS

augroup Markdown
    autocmd FileType markdown setl wrap
                \ linebreak
                \ spell spelllang=en_us
augroup END

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

let g:GPGDefaultRecipients=['Raghu Rajagopalan']


" ctrlp configuration and keybindings
let g:ctrlp_match_window_bottom = 0
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_max_height = 10
let g:ctrlp_tabpage_position = 'al'
let g:ctrlp_open_multi = '1t'
let g:ctrlp_extensions = ['tag', 'buffertag', 'quickfix', 'dir']
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_cache_dir = $HOME.'/.ctrlp_cache'
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_working_path_mode = 'ra'
nnoremap <leader>m :CtrlPMixed<cr>
nnoremap <leader>b :CtrlPBuffer<cr>
nnoremap <leader>r :CtrlPMRUFiles<cr>
nnoremap <leader><leader> :CtrlP<cr>


" Session management
set sessionoptions&
set sessionoptions-=options
set sessionoptions+=resize,unix,slash,winpos

let g:session_directory="~/.vim/.vimbackups"
let g:session_command_aliases = 1
let g:session_autosave='yes'
let g:session_autoload='yes'
let g:session_default_to_last=1

set nossl

" Required for yankstack
set winaltkeys=no
call yankstack#setup()
vnoremap % <space>%

" customizations made outside of any plugins
let g:formatprg_javascript="js-beautify"
let g:formatprg_cs=fnamemodify(findfile("astyle.exe", $GNUWIN), ":p")
let g:formatprg_args_cs=" --mode=cs --style=ansi -pcHs4"
let g:formatprg_args_javascript=" -jw 80 -"
let g:formatprg_json="js-beautify"
let g:formatprg_args_json=" -jw 80 -"
fun! FormatFile() 
    let curline=line(".")
    if exists("g:formatprg_". &ft) 
        let cmd ="%!" . eval("g:formatprg_". &ft)
        if exists("g:formatprg_args_". &ft) 
            let cmd=cmd. eval("g:formatprg_args_". &ft)
        endif
        echo cmd
        exec cmd
    else
        exec "normal ". "gg=G"
    endif
    exec "normal ". curline. "G"
endfun
map <F7> :call FormatFile() <cr>

au WinLeave * set nocursorline
au WinEnter * set cursorline
fun! RemoveCtrlM()
    execute("%s/\r$//")
endfun
fun! s:get_visual_selection()
    let l=getline("'<")
    let [line1,col1] = getpos("'<")[1:2]
    let [line2,col2] = getpos("'>")[1:2]
    return l[col1 - 1: col2 - 1]
endfun
nnoremap <expr> <leader>* ":lvimgrep /" . expand("<cword>") . "/j  **/*." .  expand("%:e") . " \|lopen"
vnoremap <script> <leader>* <Esc>:lvimgrep /<C-R><C-R>=<SID>get_visual_selection()<CR>/j **/*.<C-R><C-R>=expand("%:e")<CR>\|lopen
