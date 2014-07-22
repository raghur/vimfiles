" vim: fdm=marker:
" Options {{{
set showmode
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
set history=50      " keep 50 lines of command line history
set ruler       " show the cursor position all the time
set noshowcmd
set nocursorline
set nocursorcolumn     " display incomplete commands
set incsearch       " do incremental searching
set encoding=utf-8
set hidden
set wildchar=<Tab> wildmenu
set wildmode=longest,list
set pastetoggle=<F11>
set ignorecase smartcase
set guioptions-=T
set guioptions-=r
set guioptions+=R
set timeout timeoutlen=500
set ttimeoutlen=50
set undofile
set undodir=~/.vim/.vimbackups/.undo
set undolevels=1000
" required for yankstack
set winaltkeys=no
" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
    set mouse=a
endif

" Backup Options {{{
set backup        " keep a backup file
set backupdir=~/.vim/.vimbackups/.backup " avoids messing up folders with *.swp and file~ backups
set directory=~/.vim/.vimbackups/.swap
"}}}
set switchbuf=usetab
set matchpairs+=<:>
set showmatch
set nowrap
set copyindent
set smarttab
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smartindent
set wildignore+=*.swp,*.bak,*.class,.git/*,.svn/*,.git\*,.svn\*
set visualbell
set noerrorbells
set list
set listchars=tab:».,trail:░,extends:→,nbsp:.

" ConEmu
if !empty($CONEMUBUILD)
    set term=xterm
    set t_Co=256
    let &t_AB="\e[48;5;%dm"
    let &t_AF="\e[38;5;%dm"
endif

" tmux and otherwise
set t_Co=256
if &term =~ '256color'
    " disable Background Color Erase (BCE) so that color schemes
    " render properly when inside 256-color tmux and GNU screen.
    " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
    set t_ut=
endif

set path+=$HOME,.,,~/git,~/code

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

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif

set foldmethod=syntax
set foldopen=block,hor,mark,percent,quickfix,search,tag,undo,jump
set foldnestmax=5
set foldminlines=4
set relativenumber
set nu
map <space> <leader>
" replace all instances in a line.
set gdefault
set colorcolumn=120

" Session management
set sessionoptions&
set sessionoptions-=options
set sessionoptions+=resize,unix,slash,winpos

if has("unix")
    set shell=bash\ -i
    set clipboard=unnamedplus
else
    " Clipboard integration
    set clipboard=unnamed
    " For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
    let &guioptions = substitute(&guioptions, "t", "", "g")
endif

" colors
if has("gui_running")
    set background=light
else
    set background=dark
endif

if has('win32')
    let g:fonts='Ubuntu_Mono_derivative_Powerlin:h13,Source_Code_Pro_Light:h11,Powerline_Consolas:h11,DejaVu Sans Mono For Powerline:h11'
    set guifont=Ubuntu_Mono_derivative_Powerlin:h13
else
    let g:fonts="Meslo\ LG\ S\ for\ Powerline\ 10,Monaco\ for\ Powerline\ 10,Source\ Code\ Pro\ for\ Powerline\ 11,DejaVu\ Sans\ Mono\ for\ Powerline\ 10,Monospace\ 10,Ubuntu\ Mono\ 11"
    set guifont=Meslo\ LG\ S\ for\ Powerline\ 10
    let g:GPGExecutable="gpg2"
    let g:GPGUseAgent = 1
endif

" termcap codes for cursor shape changes on entry and exit to
" /from insert mode
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"
"}}}

" Plugin Bundles and config {{{
filetype off
set rtp^=~/.vim
set rtp+=~/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'kshenoy/vim-signature'
nnoremap <leader>[ :call signature#GotoMark( "prev", "line", "alpha" )<CR>
nnoremap <leader>] :call signature#GotoMark( "next", "line", "alpha" )<CR>
NeoBundle 'wellle/targets.vim'
NeoBundle 'https://git.gitorious.org/vim-gnupg/vim-gnupg.git', {
    \   'lazy': 1,
    \   'autoload': {
    \       'filename_patterns' : ['\.gpg$', '\.asc$']
    \   }}
"If you have git, make sure that path does NOT point to git bash tools
" Path for git win should point to the libexec/git-core folder
" The default GPG should point to cygwin git
" To check: :sh, which gpg
let g:GPGDefaultRecipients=['Raghu Rajagopalan']

NeoBundle 'raghur/vim-helpnav', {
    \   'lazy': 1,
    \   'autoload': {
    \       'filetypes' : ['help']
    \   }}

NeoBundle 'vim-scripts/L9'
" CtrlP{{{
NeoBundle 'kien/ctrlp.vim'
let g:ctrlp_match_window_bottom = 0
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_max_height = 10
let g:ctrlp_tabpage_position = 'al'
let g:ctrlp_open_multi = '1t'
let g:ctrlp_extensions = ['tag', 'buffertag', 'quickfix', 'dir']
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_cache_dir = $HOME.'/.ctrlp_cache'
let g:ctrlp_mruf_exclude = '\(.*\\dev\\shm\\pass\..*\)|\(.*\\.git\COMMIT_EDITMSG\)' " Windows
let g:ctrlp_mruf_case_sensitive = 0
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_working_path_mode = 'ra'
nnoremap <leader>m :CtrlPMixed<cr>
nnoremap <leader>b :CtrlPBuffer<cr>
nnoremap <leader>r :CtrlPMRUFiles<cr>
nnoremap <leader>q :CtrlPQuickfix<cr>
nnoremap <leader><Space> :CtrlP<cr>
"}}}

NeoBundle 'vim-pandoc/vim-pandoc'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-repeat'
"Plugin 'Raimondi/delimitMate'
NeoBundle 'kana/vim-smartinput'

NeoBundle 'nathanaelkane/vim-indent-guides'
let g:indent_guides_guide_size = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']
if has("gui_running")
    let g:indent_guides_enable_on_vim_startup = 1
endif

NeoBundle 'sjl/gundo.vim'
NeoBundle 'gregsexton/MatchTag'
NeoBundle 'scrooloose/nerdcommenter'

"Plugin 'Valloric/YouCompleteMe'
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_auto_stop_csharp_server = 1
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<cr>
"Plugin 'marijnh/tern_for_vim'


NeoBundle 'SirVer/ultisnips'
NeoBundle 'honza/vim-snippets'
let g:UltiSnipsUsePythonVersion=2
let g:UltiSnipsSnippetsDir="~/.vim/Ultisnips"
let g:UltiSnipsExpandTrigger="<c-cr>"
let g:UltiSnipsListSnippets="<c-tab>"

NeoBundle 'scrooloose/syntastic'
let g:syntastic_python_checkers = ['pylama']
let g:syntastic_javascript_checkers = ['jshint']
nnoremap <leader>n :cnext<cr>
nnoremap <leader>p :cprev<cr>
nnoremap <leader><F5> :w\|SyntasticCheck<cr>
let g:syntastic_mode_map = { 'mode': 'passive',
            \ 'active_filetypes': ['python', 'json'],
            \ 'passive_filetypes': ['javascript'] }

NeoBundle 'kchmck/vim-coffee-script'
" colorscheme bundles and repos
NeoBundle 'raghur/vim-colorschemes'
NeoBundle 'sickill/vim-monokai'
NeoBundle 'jaromero/vim-monokai-refined'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'chriskempson/base16-vim'
let base16colorspace=256
let g:solarized_termcolors=256

NeoBundle 'pangloss/vim-javascript', {
    \   'lazy': 1,
    \   'autoload': {
    \       'filetypes' : ['javascript']
    \   }}


NeoBundle 'elzr/vim-json'
let g:vim_json_syntax_conceal = 0

NeoBundle 'jwhitley/vim-matchit.git'
NeoBundle 'tpope/vim-ragtag'

NeoBundle 'kana/vim-textobj-indent'
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'sgur/vim-textobj-parameter'
NeoBundle 'kana/vim-textobj-function'
NeoBundle 'terryma/vim-expand-region'
NeoBundle 'rstacruz/sparkup', {
    \   'lazy': 1,
    \   'rtp' : 'vim',
    \   'autoload': {
    \       'filetypes' : ['html']
    \   }}

" vim-airline and fonts
set lazyredraw
set laststatus=2
NeoBundle 'bling/vim-airline'
" line below has a trailing space.
NeoBundle 'Lokaltog/powerline-fonts'
let g:airline_enable_branch=1
let g:airline_enable_syntastic=1
let g:airline_powerline_fonts=1
let g:airline_detect_modified=1

NeoBundle 'tpope/vim-dispatch'
NeoBundle 'tpope/vim-markdown', {
    \   'lazy': 1,
    \   'autoload': {
    \       'filetypes' : ['markdown']
    \   }}

NeoBundle 'airblade/vim-rooter'

"neocomplete
" run: nmake -f Make_msvc.mak nodebug=1
NeoBundle 'Shougo/vimproc.vim'
if has('lua')
    NeoBundle 'Shougo/neocomplete', {
        \ 'depends' : 'Shougo/context_filetype.vim',
        \ 'disabled' : !has('lua'),
        \ 'vim_version' : '7.3.885'
        \ }
    " Use neocomplete.
    let g:neocomplete#use_vimproc = 1
    let g:neocomplete#enable_at_startup = 1
    so ~/.vim/neocomplete-custom.vim
endif

NeoBundle 'maxbrunsfeld/vim-yankstack'
" make sure this is after vim-yankstack
NeoBundle 'tpope/vim-surround'

" vim sneak; replace f/F with sneak
NeoBundle 'justinmk/vim-sneak'
 "replace 'f' with 1-char Sneak
 nmap f <Plug>Sneak_f
 nmap F <Plug>Sneak_F
 xmap f <Plug>Sneak_f
 xmap F <Plug>Sneak_F
 omap f <Plug>Sneak_f
 omap F <Plug>Sneak_F

NeoBundle 'nvie/vim-flake8', {
    \   'lazy': 1,
    \   'autoload': {
    \       'filetypes' : ['python']
    \   }}

NeoBundle 'nvie/vim-pyunit', {
    \   'lazy': 1,
    \   'autoload': {
    \       'filetypes' : ['python']
    \   }}

NeoBundle 'klen/python-mode', {
    \   'lazy': 1,
    \   'autoload': {
    \       'filetypes' : ['python']
    \   }}

let g:pymode_run_bind = '<leader>pr'
"Plugin 'klen/rope-vim'
NeoBundle 'python-rope/ropevim'
let g:pymode_rope = 0

NeoBundle 'nacitar/terminalkeys.vim'
if &term =~ '^screen'
  " Page keys http://sourceforge.net/p/tmux/tmux-code/ci/master/tree/FAQ
  execute "set t_kP=\e[5;*~"
  execute "set t_kN=\e[6;*~"

  " Arrow keys http://unix.stackexchange.com/a/34723
  execute "set <xUp>=\e[1;*A"
  execute "set <xDown>=\e[1;*B"
  execute "set <xRight>=\e[1;*C"
  execute "set <xLeft>=\e[1;*D"
endif

" Omnisharp {{{
"if has("win32")
    "Plugin 'nosami/Omnisharp'
    "autocmd FileType cs setlocal omnifunc=OmniSharp#Complete
    "nnoremap <leader><F5> :wa!<cr>:OmniSharpBuild<cr>
    "" Builds can run asynchronously with vim-dispatch installed
    "nnoremap <F6> :wa!<cr>:OmniSharpBuildAsync<cr>

    ""The following commands are contextual, based on the current cursor position.
    "nnoremap <F12> :OmniSharpGotoDefinition<cr>
    "nnoremap gd :OmniSharpGotoDefinition<cr>
    "nnoremap <leader>fi :OmniSharpFindImplementations<cr>
    "nnoremap <leader>ft :OmniSharpFindType<cr>
    "nnoremap <leader>fs :OmniSharpFindSymbol<cr>
    "nnoremap <leader>fu :OmniSharpFindUsages<cr>
    "nnoremap <leader>fm :OmniSharpFindMembersInBuffer<cr>
    "nnoremap <leader>tt :OmniSharpTypeLookup<cr>
    ""I find contextual code actions so useful that I have it mapped to the spacebar
    "nnoremap <A-space> :OmniSharpGetCodeActions<cr>

    "" rename with dialog
    "nnoremap <leader>nm :OmniSharpRename<cr>
    "nnoremap <F2> :OmniSharpRename<cr>
    "" rename without dialog - with cursor on the symbol to rename... ':Rename newname'
    "command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")

    "" Force OmniSharp to reload the solution. Useful when switching branches etc.
    "nnoremap <leader>rl :OmniSharpReloadSolution<cr>
    "nnoremap <leader>cf :OmniSharpCodeFormat<cr>
    "" Load the current .cs file to the nearest project
    "nnoremap <leader>tp :OmniSharpAddToProject<cr>
    "" (Experimental - uses vim-dispatch or vimproc plugin) - Start the omnisharp server for the current solution
    "nnoremap <leader>ss :OmniSharpStartServer<cr>
    "nnoremap <leader>sp :OmniSharpStopServer<cr>

    "" Add syntax highlighting for types and interfaces
    "nnoremap <leader>th :OmniSharpHighlightTypes<cr>
"endif
"}}}

" load session only on windows gvim
NeoBundle 'xolox/vim-misc'
NeoBundle 'xolox/vim-session'
if (has('win32unix'))
    let g:session_directory="~/.vim/.vimbackups/.cygsessions"
else
    let g:session_directory="~/.vim/.vimbackups/.sessions"
endif
let g:session_command_aliases = 1
let g:session_autosave='yes'
let g:session_autoload='yes'
let g:session_default_to_last=1

call neobundle#end()
filetype plugin indent on
colors smyck
"}}}

"Non Plugin specific keybindings {{{
" disable arrow keys
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>
nnoremap  <backspace> <C-O>
"inoremap <esc> <c-o>:echoe "use jk"<cr>
inoremap jk <esc>

map [[ ?{<CR>w99[{
map ][ /}<CR>b99]}
map ]] j0[[%/{<CR>
map [] k$][%?}<CR>

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

let maplocalleader='\'
" Search customizations
nnoremap / /\v
nnoremap <leader>h  :noh<cr><c-l>
nnoremap <leader>w  :w<cr>
nnoremap <leader>fc :lcl <cr>
nnoremap <leader>pw :ed ~/.gnupg/passwords.txt.asc <cr>
vnoremap > >gv
vnoremap < <gv
nnoremap 0 ^
nnoremap ^ 0
noremap <C-s> :w<cr>
nnoremap <C-Backspace> :b#<cr>
nnoremap <leader>sv :ed ~/.vim/_vimrc<cr>
nnoremap <F5> :GundoToggle<CR>
vnoremap <leader>v "0p
" copy a block and comment it and move to insert mode
vmap <leader>ce  <S-v>ygv<Leader>cc`>pi
vnoremap % <space>%


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
"}}}

" Autocommands {{{

augroup Markdown
    autocmd FileType markdown setl wrap
                \ linebreak
                "\ spell spelllang=en_us
augroup END
au BufNewFile,BufRead *.aspx setl filetype=html
au BufNewFile,BufRead *.cshtml set filetype=html
au BufNewFile,BufRead *.ascx set filetype=html
au BufNewFile,BufRead *.moin setf moin
au BufNewFile,BufRead *.wiki setf moin
au BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable
                                    \ shiftwidth=2 expandtab
au FileType html setl foldmethod=indent
"}}}

" Custom code/Utils {{{
" Format file {{{
let g:formatprg_javascript="js-beautify"
let g:formatprg_cs="astyle"
let g:formatprg_args_cs=" --mode=cs --style=ansi -pcHs4"
let g:formatprg_args_javascript=" -jw 80 -f -"
let g:formatprg_json="js-beautify"
let g:formatprg_args_json=" -jw 80 -f -"
let g:formatprg_html="tidy"
let g:formatprg_args_html=" -iq --indent-spaces 4"
let g:formatprg_xml="xmllint"
let g:formatprg_args_xml=" --format --recover - 2>/dev/null"

" Windows specific {{{
if (has('win32'))
    let g:formatprg_cs=fnamemodify(findfile(g:formatprg_cs . ".exe", $GNUWIN."/**3"), ":p")
    let g:formatprg_html=fnamemodify(findfile(g:formatprg_html . ".exe", $GNUWIN."/**3"), ":p")
    let g:formatprg_xml=fnamemodify(findfile(g:formatprg_xml . ".exe", $GNUWIN."/**3"), ":p")
endif
"}}}

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
"}}}

" File search {{{
let s:ackopts='\ -a\ --no-group\ -Hi '
let s:grepopts='\ --exclude-dir=packages\ --exclude-dir=.git\ --exclude-dir=.svn\ --exclude-dir=tmp\ --exclude=*.intellisense.js\ --exclude=*-vsdoc.js\ --exclude=*.tmp\ --exclude=*.min.js\ -PHIirn\ $*'
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

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
  let s:grep='ag'
  let s:grepopts='\ --nogroup\ --nocolor'
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
    let l:cmd=":silent grep! "
    let l:post="\"" . a:patt . "\""
    let l:pipe =  "\| copen"
    "let l:cmd = l:cmd .  Get_grep_include_opt(" --include=*.")
    let l:cmd = l:cmd . " " . l:post
    if a:path != ""
        let l:cmd = l:cmd . " " . a:path
    "else
        "let l:cmd = l:cmd . "  *"
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
nnoremap <expr> <leader>* ":silent vimgrep /" . expand("<cword>") . "/j " .  Get_grep_include_opt("**/*.") . " \|copen"
vnoremap <script> <leader>* <Esc>:vimgrep /<C-R><C-R>=<SID>get_visual_selection()<CR>/j <C-R><C-R>=Get_grep_include_opt("**/*.")<CR>\|copen

" vimgrep - fast but external
" project root
nnoremap <expr><leader>f Grep_with_args("\\b".expand("<cword>")."\\b", "")
vnoremap <script><leader>f <Esc>:silent grep
                            \ "<C-R><C-R>=<SID>get_visual_selection()<CR>"
                            \ * \|copen
                             "\ <C-R><C-R>=Get_grep_include_opt(" --include=*.")<CR>
" down current folder
nnoremap <expr><leader>fd Grep_with_args("\\b".expand("<cword>")."\\b", expand("%:p:h"))
vnoremap <script><leader>fd <Esc>:silent grep
                            \ "<C-R><C-R>=<SID>get_visual_selection()<CR>"
                            \ <C-R><C-R>=expand("%:p:h")<CR>\* \|copen
                             "\ <C-R><C-R>=Get_grep_include_opt(" --include=*.")<CR>
"}}}

" Cycle colors
fun! CycleArray(arr, value, dir)
    let c = index(a:arr, a:value) + a:dir
    if (a:dir > 0)
        if (c >= len(a:arr))
            let c = 0
        endif
    else
        if (c < 0)
            let c = len(a:arr) - 1
        endif
    endif
    return c
endfunction

let g:colorschemes="smyck:base16-default:Monokai-Refined:monokai:molokai"
fun! CycleColorScheme(dir)
    let arr = split(g:colorschemes, ":")
    let c = CycleArray(arr, g:colors_name, a:dir)
    let scheme = arr[c]
    exec "colors " scheme
    echom "Setting colorscheme to: " scheme
endfun
command! ColorsNext call CycleColorScheme(1)
command! ColorsPrev call CycleColorScheme(-1)

fun! CycleFont(dir)
    let arr = split(g:fonts, ",")
    let c = CycleArray(arr, &guifont, a:dir)
    let font = substitute(arr[c], " ", '\\ ', "g")
    exec("set guifont=".font)
    echom "Setting font to: " &guifont
endfun
command! FontNext call CycleFont(1)
command! FontPrev call CycleFont(-1)
"}}}

" Commands {{{
if has("unix")
    command! W :execute ':silent w !sudo tee % > /dev/null' | :edit!
endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
                \ | wincmd p | diffthis
endif
fun! RemoveCtrlM()
    :update
    :e ++ff=dos
    :%s/\r$//e
endfun
command! RemoveCtrlM call RemoveCtrlM()
command! EditAsWin call RemoveCtrlM()

fun! SanitizeSpaces()
    retab
    :%s/\s\+$//e
    :w
endfun
command! Fixspaces call SanitizeSpaces()

fun! SanitizeBlogEntry()
    call SanitizeSpaces()
    :%s/\r$//e
    :%s/\\$//e
endfun

fun! BlogSave()
    call SanitizeBlogEntry()
    :! easyblogger file %
endfun
command! BlogSave call BlogSave()
function! NeatFoldText() "{{{
    let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
    let lines_count = v:foldend - v:foldstart + 1
    let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
    let foldchar = matchstr(&fillchars, 'fold:\zs.')
    let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
    let foldtextend = lines_count_text . repeat(foldchar, 8)
    let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
    return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction
set foldtext=NeatFoldText()
" }}}

function! ToHtml()
    :w
    let file=expand("%:p")
    let outfile=fnamemodify(file, ":r") . ".html"
    exec "!pandoc -i " . file . " -o " . outfile
    echom "wrote" . " " . outfile
endfunction
command! ToHtml call ToHtml()

" use :redir @+ to copy output of command to clipboard
:redir!>$HOME/.vim/.vimbackups/000messages
function! ShowMessageBuffer()
    :botright sp ~/.vim/.vimbackups/000messages
    normal G
endfun
command! Messages  call ShowMessageBuffer()
NeoBundleCheck
"}}}

