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
set hidden

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1

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
set rtp+=~/.vim
set rtp+=~/.vim/bundle/vundle/
call vundle#rc("$HOME/.vim/bundle")

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'
Bundle 'kshenoy/vim-signature'
Bundle 'https://git.gitorious.org/vim-gnupg/vim-gnupg'
Bundle 'raghur/vim-helpnav'
Bundle 'vim-scripts/L9'
Bundle 'altercation/vim-colors-solarized'
Bundle 'kien/ctrlp.vim'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'vim-pandoc/vim-pandoc'
"Bundle 'Raimondi/delimitMate'
Bundle 'kana/vim-smartinput'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'sjl/gundo.vim'
Bundle 'hallettj/jslint.vim'
Bundle 'gregsexton/MatchTag'
Bundle 'scrooloose/nerdcommenter'
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
Bundle 'rstacruz/sparkup'
" vim-airline and fonts
Bundle 'bling/vim-airline'
Bundle 'Lokaltog/powerline-fonts'
Bundle 'tpope/vim-dispatch'
Bundle 'plasticboy/vim-markdown'
Bundle 'airblade/vim-rooter'
"neocomplete
Bundle 'Shougo/neocomplete.vim'
if has("unix")
    set shell=bash\ -i
    "Bundle 'suan/vim-instant-markdown'
    "let g:instant_markdown_slow = 1
    set clipboard=unnamedplus
else
    Bundle 'nosami/Omnisharp'
    nnoremap <leader><F5> :wa!<cr>:OmniSharpBuild<cr>
    " Builds can run asynchronously with vim-dispatch installed
    nnoremap <F5> :wa!<cr>:OmniSharpBuildAsync<cr>

    "The following commands are contextual, based on the current cursor position.
    nnoremap <F12> :OmniSharpGotoDefinition<cr>
    nnoremap gd :OmniSharpGotoDefinition<cr>
    nnoremap <leader>fi :OmniSharpFindImplementations<cr>
    nnoremap <leader>ft :OmniSharpFindType<cr>
    nnoremap <leader>fs :OmniSharpFindSymbol<cr>
    nnoremap <leader>fu :OmniSharpFindUsages<cr>
    nnoremap <leader>fm :OmniSharpFindMembersInBuffer<cr>
    nnoremap <leader>tt :OmniSharpTypeLookup<cr>
    "I find contextual code actions so useful that I have it mapped to the spacebar
    nnoremap <space> :OmniSharpGetCodeActions<cr>

    " rename with dialog
    nnoremap <leader>nm :OmniSharpRename<cr>
    nnoremap <F2> :OmniSharpRename<cr>
    " rename without dialog - with cursor on the symbol to rename... ':Rename newname'
    command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")

    " Force OmniSharp to reload the solution. Useful when switching branches etc.
    nnoremap <leader>rl :OmniSharpReloadSolution<cr>
    nnoremap <leader>cf :OmniSharpCodeFormat<cr>
    " Load the current .cs file to the nearest project
    nnoremap <leader>tp :OmniSharpAddToProject<cr>
    " (Experimental - uses vim-dispatch or vimproc plugin) - Start the omnisharp server for the current solution
    nnoremap <leader>ss :OmniSharpStartServer<cr>
    nnoremap <leader>sp :OmniSharpStopServer<cr>

    " Add syntax highlighting for types and interfaces
    nnoremap <leader>th :OmniSharpHighlightTypes<cr>
endif
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
set timeout timeoutlen=500
set ttimeoutlen=50
set undofile
set undodir=~/.vim/.vimbackups/.undo
set undolevels=1000

" Required for yankstack
Bundle 'maxbrunsfeld/vim-yankstack'
set winaltkeys=no
call yankstack#setup()

" vim sneak; replace f/F with sneak
Bundle 'justinmk/vim-sneak'
nnoremap f :Sneak!         1<cr>
nnoremap F :SneakBackward! 1<cr>
xnoremap f <esc>:<c-u>SneakV!         1<cr>
xnoremap F <esc>:<c-u>SneakVBackward! 1<cr>
" need this otherwise vim-yankstack takes over the bindings
nmap s <Plug>SneakForward
nmap S <Plug>SneakBackward

" disable arrow keys
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>

map [[ ?{<CR>w99[{
map ][ /}<CR>b99]}
map ]] j0[[%/{<CR>
map [] k$][%?}<CR>

if has('win32')
    set guifont=
                \Powerline_Consolas:h11,
                \Source_Code_Pro_Light:h12,
                \DejaVu\ Sans\ Mono\ For\ Powerline:h11
else
    set guifont=
                \Meslo\ LG\ S\ for\ Powerline\ 10,
                \Monaco\ for\ Powerline\ 10,
                \Source\ Code\ Pro\ for\ Powerline\ 11,
                \DejaVu\ Sans\ Mono\ for\ Powerline\ 10,
                \Monospace\ 10,
                \Ubuntu\ Mono\ 11
    let g:GPGExecutable="gpg2"
    let g:GPGUseAgent = 1
endif

" syntastic
let g:syntastic_python_checkers = ['pylama']

" vim-json
let g:vim_json_syntax_conceal = 0

" vim-airline configuration
set lz
let g:airline_enable_branch=1
let g:airline_enable_syntastic=1
let g:airline_powerline_fonts=1
let g:airline_detect_modified=1
" powerline symbols
if (&guifont =~ 'Powerline')
    let g:airline_left_sep = ''
    "let g:airline_left_sep = ''
    "let g:airline_right_sep = ''
    let g:airline_right_sep = ''
    let g:airline_branch_prefix = '   '
    let g:airline_readonly_symbol = ''
    let g:airline_linecolumn_prefix = ' '
endif
set t_Co=256
if &term == "xterm" || &term== "screen-256color"
    set term=xterm-256color
endif
set path+=$HOME,.,,~/git,~/code

" avoids messing up folders with *.swp and file~ backups
set backupdir=~/.vim/.vimbackups/.backup
set directory=~/.vim/.vimbackups/.swap
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
if has("gui")
    set listchars=tab:».,trail:░,extends:→,nbsp:.
    au WinLeave * set nocursorline
    au WinEnter * set cursorline
endif
au BufNewFile,BufRead *.aspx set filetype=html
au BufNewFile,BufRead *.cshtml set filetype=html
au BufNewFile,BufRead *.ascx set filetype=html
au BufNewFile,BufRead *.moin setf moin
au BufNewFile,BufRead *.wiki setf moin
au BufNewFile,BufReadPost *.coffee setl foldmethod=indent, nofoldenable

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
nnoremap <leader>h  :noh<cr><c-l>
nnoremap <leader>fc :lcl <cr>
nnoremap <leader>pw :ed ~/.gnupg/passwords.txt.asc <cr>
vnoremap > >gv
vnoremap < <gv


" keybindings
set colorcolumn=120
nnoremap 0 ^
nnoremap ^ 0
noremap <C-s> :w<cr>
nnoremap <C-Backspace> :b#<cr>
nnoremap <leader>sv :ed ~/.vim/_vimrc<cr>
nnoremap <F5> :GundoToggle<CR>
vnoremap <leader>v "0p

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
colors molokai
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

augroup Markdown
    autocmd FileType markdown setl wrap
                \ linebreak
                "\ spell spelllang=en_us
augroup END

let g:UltiSnipsExpandTrigger="<C-CR>"
let g:UltiSnipsJumpForwardTrigger="<C-tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

"If you have git, make sure that path does NOT point to git bash tools
" Path for git win should point to the libexec/git-core folder
" The default GPG should point to cygwin git
" To check: :sh, which gpg
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
let g:ctrlp_mruf_exclude = '.*\\dev\\shm\\pass\..*' " Windows
let g:ctrlp_mruf_case_sensitive = 0
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

let g:session_directory="~/.vim/.vimbackups/.sessions"
let g:session_command_aliases = 1
let g:session_autosave='yes'
let g:session_autoload='yes'
let g:session_default_to_last=1


vnoremap % <space>%

" customizations made outside of any plugins
let g:formatprg_javascript="js-beautify"
let g:formatprg_cs="astyle"
let g:formatprg_args_cs=" --mode=cs --style=ansi -pcHs4"
let g:formatprg_args_javascript=" -jw 80 -"
let g:formatprg_json="js-beautify"
let g:formatprg_args_json=" -jw 80 -"
let g:formatprg_html="tidy"
let g:formatprg_args_html=" -iq --indent-spaces 4"
let g:formatprg_xml="tidy"
let g:formatprg_args_xml=" -iq -asxml --indent-spaces 4"

if (has('win32'))
    let g:formatprg_cs=fnamemodify(findfile(g:formatprg_cs . ".exe", $GNUWIN), ":p")
    let g:formatprg_html=fnamemodify(findfile(g:formatprg_html . ".exe", $GNUWIN), ":p")
    let g:formatprg_xml=fnamemodify(findfile(g:formatprg_xml . ".exe", $GNUWIN), ":p")
endif

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

fun! RemoveCtrlM()
    execute("%s/\r$//")
endfun
fun! SanitizeBlogEntry()
    execute("%s/\r$//")
    execute("%s/\\$//")
endfun

let s:grepopts='\ --exclude-dir=packages\ --exclude-dir=.git\ --exclude-dir=.svn\ --exclude-dir=tmp\ --exclude=*.intellisense.js\ --exclude=*-vsdoc.js\ --exclude=*.tmp\ --exclude=*.min.js\ -PHIirn\ $*'
let s:ackopts='\ -a\ --no-group\ -Hi '
if has('win32')
    set nossl
    let s:ack="f:/utils/ack.bat"
    let s:find=fnamemodify(findfile("find.exe", $GNUWIN."**"), ":p")
    let s:grep=fnamemodify(findfile("grep.exe", $GNUWIN."**"), ":p")
else
    let s:ack="ack"
    let s:find="find"
    let s:grep="grep"
endif

execute "set grepprg=" . s:grep ."\\ ".s:grepopts

fun! Get_grep_include_opt(prefix)
    let l:cmd = ""
    if (expand("%:e") != "")
        "let l:cmd =  " --include=*.". expand("%:e") . " "
        let l:cmd = a:prefix . expand("%:e") . " "
    endif
    return l:cmd
endfun
fun! Grep_with_args(patt, path)
    let l:cmd=":silent lgrep! "
    let l:post="\"" . a:patt . "\""
    let l:pipe =  "\| lopen"
    let l:cmd = l:cmd .  Get_grep_include_opt(" --include=*.")
    let l:cmd = l:cmd . " " . l:post
    if a:path != ""
        let l:cmd = l:cmd . " " . a:path
    else
        let l:cmd = l:cmd . "  *"
    endif
    let l:cmd = l:cmd . " " . l:pipe
    return l:cmd
endfun

fun! s:get_visual_selection()
    let l=getline("'<")
    let [line1,col1] = getpos("'<")[1:2]
    let [line2,col2] = getpos("'>")[1:2]
    return l[col1 - 1: col2 - 1]
endfun

" lvimgrep - internal - slow
nnoremap <expr> <leader>* ":silent lvimgrep /" . expand("<cword>") . "/j " .  Get_grep_include_opt("**/*.") . " \|lopen"
vnoremap <script> <leader>* <Esc>:lvimgrep /<C-R><C-R>=<SID>get_visual_selection()<CR>/j <C-R><C-R>=Get_grep_include_opt("**/*.")<CR>\|lopen

" vimgrep - fast but external
" project root
nnoremap <expr><leader>f Grep_with_args("\\b".expand("<cword>")."\\b", "")
vnoremap <script><leader>f <Esc>:silent lgrep
                            \ <C-R><C-R>=Get_grep_include_opt(" --include=*.")<CR>
                            \ "<C-R><C-R>=<SID>get_visual_selection()<CR>"
                            \ * \|lopen
" down current folder
nnoremap <expr><leader>fd Grep_with_args("\\b".expand("<cword>")."\\b", expand("%:p:h"))
vnoremap <script><leader>fd <Esc>:silent lgrep
                            \ <C-R><C-R>=Get_grep_include_opt(" --include=*.")<CR>
                            \ "<C-R><C-R>=<SID>get_visual_selection()<CR>"
                            \ <C-R><C-R>=expand("%:p:h")<CR>\* \|lopen

execute(":redir! > ~/.vim/.vimbackups/000messages")
so ~/.vim/neocomplete-custom.vim
if has("unix")
    command! W :execute ':silent w !sudo tee % > /dev/null' | :edit!
endif

