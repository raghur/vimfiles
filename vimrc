" vim: fdm=marker:
" Clone this repo to vimfiles under windows and .vim under linux and you're
" good to go. See https://www.reddit.com/r/vim/comments/3gdycs/problem_with_syncing_vimrc_between_windows_and/ctxc32m/
" For neovim (windows), link Appdata/local/nvim --> vimfiles
" For neovim (linux), link ~/.config/nvim --> ~/.vim
"
" Font ligatures
" Test ligatures: -> != == === >= <= =>
" Options {{{
let g:home=expand('<sfile>:p:h')."/"

exec("set rtp^=".g:home)
call utils#os_script(g:home)

"force python 3 if available.
" linux only one python can be loaded at a time.
if exists('py2') && has('python')
elseif has('python3')
endif
if exists("+pyxversion")
    set pyxversion=3
endif

set updatetime=2000
set showmode
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
set history=50      " keep 50 lines of command line history
set ruler       " show the cursor position all the time
set nocursorline
set nocursorcolumn     " display incomplete commands
set incsearch       " do incremental searching
set encoding=utf-8
set hidden
let maplocalleader='\'
let mapleader = "<space>"
map <space> <leader>
set wildchar=<Tab>
set wildmenu
set wildmode=longest:full,full
set wildignore+=*.swp,*.bak,*.class,.git/*,.svn/*
set pastetoggle=<F11>
set ignorecase smartcase
set guioptions-=T
set guioptions-=t
set guioptions-=r
set guioptions+=R
set timeout timeoutlen=1000 ttimeoutlen=100
set undofile
call utils#createIfNotExists(g:home.".vimbackups/.undo")
exec("set undodir=".g:home.".vimbackups/.undo")
set undolevels=1000
" required for yankstack
set winaltkeys=no
" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
    set mouse=a
endif
" Backup Options {{{
set backup        " keep a backup file
call utils#createIfNotExists(g:home.".vimbackups/.backup")
exec("set backupdir=".g:home.".vimbackups/.backup")
call utils#createIfNotExists(g:home.".vimbackups/.swap")
exec("set directory=".g:home.".vimbackups/.swap")
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
set visualbell
set noerrorbells
set list
set listchars=tab:».,trail:░,extends:→,nbsp:.
if has('nvim')
    set inccommand=split
endif
" ConEmu
if !empty($CONEMUBUILD) && !has('nvim')
    set term=pcansi
    let &t_AB="\e[48;5;%dm"
    let &t_AF="\e[38;5;%dm"
endif

" tmux and otherwise
set t_Co=256

if &term =~ '256color'
    set t_ut=
endif

if &term =~ '^screen'
    " Page keys http://sourceforge.net/p/tmux/tmux-code/ci/master/tree/FAQ
    set t_kP=\e[5;*~
    set t_kN=\e[6;*~

    " Arrow keys http://unix.stackexchange.com/a/34723
    set <xUp>=\e[1;*A
    set <xDown>=\e[1;*B
    set <xRight>=\e[1;*C
    set <xLeft>=\e[1;*D
endif
if !has("nvim") && exists('+term') && !has('gui_running')
    set term=xterm-256color
endif
" If you have vim >=8.0 or Neovim >= 0.1.5
if (has("termguicolors"))
 set termguicolors
endif

set path=.,,**,$HOME

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

syntax sync minlines=256
set synmaxcol=300
set foldmethod=indent
set foldopen=block,hor,mark,percent,quickfix,search,tag,undo,jump
set foldnestmax=5
set foldminlines=2
" set rnu nu
" replace all instances in a line.
set gdefault
set colorcolumn=120

" Session management
set sessionoptions&
set sessionoptions-=options
set sessionoptions+=resize,unix,slash,winpos

set clipboard=unnamed
if has('unnamedplus')
    set clipboard=unnamedplus
endif

if has('directx')
    set renderoptions=type:directx,gamma:1.0,contrast:0.2,level:1.0,geom:1,renmode:5,taamode:1
endif

let g:colorschemes="Tomorrow-Night"
            \ . ":monokai"
            \ . ":molokai"
            \ . ":github"
            \ . ":kalisi"
let g:colorschemes = split(g:colorschemes, ":")
"}}}

" Plugin Bundles and config {{{

if empty(glob(g:home . 'autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

let g:deferredPlugins = []

function! DeferPluginLoad(name, ...)
    " echo a:000
    if !has("vim_starting")
        return
    endif
    let opts = get(a:000, 0, {})
    let cond = 1
    if has_key(opts, 'cond')
        let cond = opts['cond']
    endif
    let opts = extend(opts, { 'on': [], 'for': [] })
    Plug a:name, opts
    if cond
        let g:deferredPlugins = g:deferredPlugins + split(a:name, '/')[1:]
    endif
endfunction

command! -nargs=* DeferPlug call DeferPluginLoad(<args>)

call plug#begin(g:home.'bundle')
Plug 'MattesGroeger/vim-bookmarks'
highlight link BookmarkSign PreProc

Plug 'jamessan/vim-gnupg', {
            \ 'for': ['gpg']
            \ }
"If you have git, make sure that path does NOT point to git bash tools
" Path for git win should point to the libexec/git-core folder
" The default GPG should point to cygwin git
" To check: :sh, which gpg
let g:GPGDefaultRecipients=['Raghu Rajagopalan']

Plug 'raghur/vim-helpnav', {
            \ 'for' : ['help']
            \ }

Plug  'tpope/vim-repeat'
let g:AutoPairsShortcutToggle = '\\'
DeferPlug 'jiangmiao/auto-pairs'

Plug  'mbbill/undotree', {
            \ 'on': ['UndotreeToggle']
            \ }
Plug  'gregsexton/MatchTag'
Plug  'tpope/vim-commentary'

DeferPlug  'SirVer/ultisnips', {'cond': has('python3')}
DeferPlug  'honza/vim-snippets', {'cond': has('python3')}
let g:UltiSnipsUsePythonVersion=3
let g:UltiSnipsSnippetsDir=g:home."UltiSnips"
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsListSnippets="<c-tab>"

let g:ale_sign_column_always = 1
let g:ale_linters = {'typescript': ['tsserver']}
" let g:ale_linters = {'typescript': ['tsserver'], 'go': ['gometalinter']}
let g:ale_go_metalinter_options = '--disable-all'
DeferPlug  'w0rp/ale'
nmap <leader>p  <Plug>(ale_previous_wrap)
nmap <leader>n  <Plug>(ale_next_wrap)

Plug 'flazz/vim-colorschemes'
Plug 'sheerun/vim-polyglot'
let base16colorspace=256
let g:solarized_termcolors=256

let g:vim_json_syntax_conceal = 0


Plug  'vim-scripts/matchit.zip'
Plug  'tpope/vim-ragtag'

DeferPlug  'wellle/targets.vim'
Plug  'kana/vim-textobj-line'
Plug  'kana/vim-textobj-user'
Plug  'kana/vim-textobj-function'
Plug  'thinca/vim-textobj-function-javascript', {
            \ 'for': 'javascript'
            \ }
Plug  'rstacruz/sparkup', { 'rtp': 'vim' }

" vim-airline and fonts
set lazyredraw
set laststatus=2

DeferPlug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_enable_branch=1
let g:airline_powerline_fonts=1
let g:airline_detect_modified=1
let g:airline_theme="papercolor"

Plug 'airblade/vim-rooter'
let g:rooter_silent_chdir = 1

set signcolumn=yes
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

DeferPlug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
imap <C-l> <Plug>(coc-snippets-expand)
vmap <C-j> <Plug>(coc-snippets-select)

nmap <leader>jd <Plug>(coc-definition)
nmap <leader>jc <Plug>(coc-declaration)
nmap <leader>ji <Plug>(coc-implementation)
nmap <leader>jt <Plug>(coc-type-definition)
nmap <leader>jr <Plug>(coc-references)
nmap <leader>pf <Plug>(coc-format)
nmap <leader>pn <Plug>(coc-rename)
vmap <leader>pf <Plug>(coc-format-selected)
vmap <leader>pc <Plug>(coc-codeaction)

let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_prev = '<c-k>'
let g:coc_global_extensions=["coc-json", "coc-python", "coc-marketplace", "coc-ultisnips", "coc-tag"]
augroup GOFMT
    autocmd!
    autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')
augroup END

Plug 'roxma/nvim-yarp', v:version >= 800 && !has('nvim') ? {} : { 'on': [], 'for': [] }
Plug 'roxma/vim-hug-neovim-rpc',  v:version >= 800 && !has('nvim') ? {} : { 'on': [], 'for': [] }
let g:deoplete#enable_at_startup = 1
Plug 'tpope/vim-surround'

Plug 'rhysd/clever-f.vim'
let g:clever_f_ignore_case=1
map ; <Plug>(clever-f-repeat-forward)
map , <Plug>(clever-f-repeat-back)

" let g:jedi#force_py_version = 3
" let g:jedi#goto_command = '<localleader>g'
" let g:jedi#rename_command = '<localleader>r'
" let g:jedi#usages_command = '<localleader>u'
" let g:jedi#show_call_signatures = 2
" let g:jedi#completions_enabled = 0
" let g:jedi#auto_vim_configuration = 0
" Plug 'davidhalter/jedi-vim'

Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
if (has('win32unix'))
    let g:session_directory=g:home.".vimbackups/.cygsessions"
else
    let g:session_directory=g:home.".vimbackups/.sessions"
endif
let g:session_command_aliases = 1
let g:session_autosave='yes'
let g:session_lock_enabled = 0
let g:session_autoload='yes'
let g:session_default_to_last=1
let g:session_persist_globals = ['&guifont', 'g:colors_name', '&background']

Plug 'kana/vim-submode'
Plug 'sbdchd/NeoFormat', {
            \ 'on': 'Neoformat'
            \ }
Plug 'Shougo/denite.nvim'
Plug 'yyotti/denite-marks'

Plug 'Shougo/neoyank.vim'
Plug 'Shougo/neomru.vim'
let g:neomru#file_mru_limit=100

Plug 'othree/eregex.vim'

Plug 'fatih/vim-go'
let g:go_metalinter_autosave = 1
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']

let g:go_fmt_command = "goimports"
let g:go_highlight_types = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
" let coc handle code completions
" let g:go_code_completion_enabled = 0
" let g:go_fmt_autosave= 0

Plug 'alvan/vim-closetag'
" filenames like *.xml, *.html, *.xhtml, ...
let g:closetag_filenames = "*.html,*.xhtml,*.xml,*.htm,*.vue,*.jsx"
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.vue'

let g:ghost_autostart=1
DeferPlug 'raghur/vim-ghost', {'do': ':GhostInstall'}

" For development, uncomment following line
" Delete registration from rplugin.vim and restart and run UpdateRemotePlugins
"
" For logging, start with
" NVIM_PYTHON_LOG_FILE=~/pylog NVIM_GHOSTPY_LOG_LEVEL=DEBUG nvim
"
" set rtp+=~/code/vim-ghost
" set rtp+=d:/code/vim-ghost

nmap - <Plug>(choosewin)
let g:choosewin_overlay_enable=1
Plug 't9md/vim-choosewin'
" let g:gutentags_define_advanced_commands=1
" let g:gutentags_disabled=1
" let g:gutentags_file_list_command = {
"             \ 'markers': {
"             \ '.git': 'git ls-files',
"             \ '.hg': 'hg files',
"             \ },
"             \ }
" Plug 'ludovicchabant/vim-gutentags', {'cond': executable('ctags')}
Plug 'raghur/fruzzy', { 'do': { -> fruzzy#install()} }
let g:fruzzy#usenative = 1
let g:fruzzy#sortonempty = 0

Plug 'junegunn/fzf', {'cond': has('unix')}
Plug 'junegunn/fzf.vim'
call plug#end()

if executable('rg')
    call denite#custom#var('file/rec', 'command',
                \ ['rg', '--hidden', '--files', '--glob', '!.git'])

    " Ripgrep command on grep source
    call denite#custom#var('grep', 'command', ['rg'])
    call denite#custom#var('grep', 'default_opts',
            \ ['--vimgrep', '--no-heading', '-PS'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'final_opts', [])
endif

" default options
call denite#custom#source('_', 'matchers', ['matcher/fruzzy'])
call denite#custom#option('_', 'input', '')
call denite#custom#option('_', 'prompt', '▶ ')
call denite#custom#option('_', 'start_filter', v:true)
call denite#custom#option('_', 'auto_resize', v:true)
call denite#custom#option('_', 'split', 'floating')
call denite#custom#option('_', 'winminheight', 1)

" highlights
call denite#custom#option('_', 'highlight_mode_insert', 'CursorLine')
call denite#custom#option('_', 'highlight_mode_insert', 'CursorLine')
call denite#custom#option('_', 'highlight_matched_range', 'Tag')
call denite#custom#option('_', 'highlight_matched_char', 'Tag')

augroup denite_custom
  " call funcs to set options for denite list and filter windows
  autocmd!
  autocmd FileType denite-filter call s:denite_filter_settings()
  autocmd FileType denite call s:denite_settings()
augroup END

function! s:denite_settings() abort
  nnoremap <silent><buffer><expr> <CR>      denite#do_map('do_action')
  nnoremap <silent><buffer><expr> p         denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> v         denite#do_map('do_action', 'vsplit')
  nnoremap <silent><buffer><expr> q         denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc>     denite#do_map('quit')
  nnoremap <silent><buffer><expr> i         denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer> <Down>          j
  nnoremap <silent><buffer> <Up>            k
endfunction

function! s:denite_filter_settings() abort
  inoremap <silent><buffer><C-c>    <Esc>:bd<cr>
  inoremap <silent><buffer><expr><Esc>  denite#do_map('quit')
  inoremap <silent><buffer><expr><CR>   denite#do_map('do_action')
  inoremap <silent><buffer><expr><C-p>  denite#do_map('choose_action')
  inoremap <silent><buffer><expr><C-v>  denite#do_map('do_action', 'vsplit')
  inoremap <silent><buffer> <C-j>
              \ <Esc><C-w>p:call cursor(line('.')+1,0)<CR><C-w>pA
  inoremap <silent><buffer> <C-k>
              \ <Esc><C-w>p:call cursor(line('.')-1,0)<CR><C-w>pA
  inoremap <silent><buffer> <Down>
              \ <Esc><C-w>p:call cursor(line('.')+1,0)<CR><C-w>pA
  inoremap <silent><buffer> <Up>
              \ <Esc><C-w>p:call cursor(line('.')-1,0)<CR><C-w>pA
endfunction

nnoremap <silent> <leader><space> :<C-u>Denite file/rec buffer<cr>
nnoremap <silent> <leader>r :<C-u>Denite file_mru<cr>
nnoremap <silent> <c-tab> :<C-u>Denite  file_mru<cr>
nnoremap <silent> <leader>o :<C-u>DeniteProjectDir file/rec<cr>
nnoremap <silent> <leader>t :<C-u>DeniteProjectDir tag<cr>
nnoremap <silent> <leader>, :<C-u>DeniteBufferDir file/rec<cr>
nnoremap <silent> <leader>c :<C-u>Denite change<cr>
nnoremap <silent> <leader>l :<C-u>Denite line<cr>
nnoremap <silent> <leader>co :<C-u>Denite colorscheme<cr>
nnoremap <silent> <leader>: :<C-u>Denite command<cr>
" nnoremap <silent> <leader>j :<C-u>Denite jump<cr>
nnoremap <silent> <leader>m :<C-u>Denite marks<cr>
nnoremap <silent> <leader>* :<C-u>Denite grep:::`expand('<cword>')`<cr>
nnoremap <silent> <leader>y :<C-u>Denite neoyank<cr>
" interactive grep mode
nnoremap <silent> <leader>g :<C-u>Denite -split=bottom grep:::!<cr>


" submode
" A message will appear in the message line when you're in a submode
" and stay there until the mode has existed.
let g:submode_always_show_submode = 1
let g:submode_timeout = 0

" We're taking over the default <C-w> setting. Don't worry we'll do
" our best to put back the default functionality.
call submode#enter_with('window', 'n', '', '<leader><C-w>')

" Note: <C-c> will also get you out to the mode without this mapping.
" Note: <C-[> also behaves as <ESC>
call submode#leave_with('window', 'n', '', '<ESC>')

" Go through every letter
for key in ['a','b','c','d','e','f','g','h','i','j','k','l','m',
            \           'n','o','p','q','r','s','t','u','v','w','x','y','z']
    " maps lowercase, uppercase and <C-key>
    call submode#map('window', 'n', '', key, '<C-w>' . key)
    call submode#map('window', 'n', '', toupper(key), '<C-w>' . toupper(key))
    call submode#map('window', 'n', '', '<C-' . key . '>', '<C-w>' . '<C-'.key . '>')
endfor
" Go through symbols. Sadly, '|', not supported in submode plugin.
for key in ['=','_','+','-','<','>']
    call submode#map('window', 'n', '', key, '<C-w>' . key)
endfor
let g:lastwh =0
let g:lastww =0

"}}}

" Autocommands {{{

augroup sparkup_types
  " Remove ALL autocommands of the current group.
  autocmd!
  " Add sparkup to new filetypes
  autocmd FileType vue,php,htmldjango runtime! ftplugin/html/sparkup.vim
augroup END
augroup vim-ghost
    autocmd!
    autocmd User vim-ghost :call utils#GhostStart()
    autocmd BufNewFile,BufRead *stackexchange.com* set filetype=markdown
    autocmd BufNewFile,BufRead *stackoverflow.com* set filetype=markdown
    autocmd BufNewFile,BufRead *github.com* set filetype=markdown
    autocmd BufNewFile,BufRead *reddit.com* set filetype=markdown
augroup END

augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call utils#MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

augroup DeferredLoadOnIdle
    au!
    autocmd CursorHold,CursorHoldI * call plug#load(g:deferredPlugins)
                \ | silent! echom "deferred load completed for ". len(g:deferredPlugins) . " plugins"
                \ | autocmd! DeferredLoadOnIdle
augroup END

augroup PluginInitialization
    au!
    au User vim-airline call LoadVimAirline()
augroup END

augroup gpg
    au!
    autocmd BufNewFile,BufRead *.gpg, *.asc setf gpg
augroup END

augroup AsciiDoc
    au!
    autocmd FileType asciidoc setl wrap
                \ spell spelllang=en_us
augroup END
augroup Markdown
    au!
    autocmd FileType markdown setl wrap
                \ linebreak
                \ spell spelllang=en_us
augroup END
augroup Html
    au!
    au BufNewFile,BufRead *.aspx setl filetype=html
    au BufNewFile,BufRead *.cshtml set filetype=html
    au BufNewFile,BufRead *.ascx set filetype=html
    au FileType html setl foldmethod=indent
augroup END

augroup Moin
    au!
    au BufNewFile,BufRead *.moin setf moin
    au BufNewFile,BufRead *.wiki setf moin
augroup END

augroup filecleanup
    au!
    autocmd BufWritePre *.pl,*.js,*.ps1,*.cs,*.md,*.html :%s/\s\+$//e
augroup END

augroup pyjedi
    autocmd!
    autocmd FileType python setlocal omnifunc=jedi#completions
                                    \ textwidth=79
                                    \ completeopt-=preview
                                    \ formatoptions+=c
                                    \ formatprg=autopep8\ -
augroup END

augroup watchers
    au!
    au BufDelete * call utils#CleanupWatcher()
augroup END
"}}}

" Custom code/Utils {{{
function! LoadVimAirline()
    call airline#parts#define_function('ALE', 'ALEGetStatusLine')
    call airline#parts#define_condition('ALE', 'exists("*ALEGetStatusLine")')
    let g:airline_section_error = airline#section#create_right(['ALE'])
    AirlineRefresh
    silent! echom "loaded vim-airline"
endfunction


function! NeatFoldText()
    let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
    let lines_count = v:foldend - v:foldstart + 1
    let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
    let foldchar = matchstr(&fillchars, 'fold:\zs.')
    let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
    let foldtextend = lines_count_text . repeat(foldchar, 8)
    let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
    return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction

"}}}

"Commands {{{
"
command! ColorsNext call utils#CycleColorScheme(1)
command! ColorsPrev call utils#CycleColorScheme(-1)

command! RemoveCtrlM call utils#RemoveCtrlM()
command! EditAsWin call utils#RemoveCtrlM()

command! -nargs=+ -bang -complete=command R call utils#ReadExCommandOutput(<bang>1, <q-args>)
inoremap <c-r>R <c-o>:<up><home>R! <cr>

command! BlogSave call utils#BlogSave(expand("%:p"))

set foldtext=NeatFoldText()
command! ToHtml call utils#ToHtml()

command! Gitex call utils#GitBrowser()
command! Wex call utils#Filemanager()
command! Console call utils#Console()
command! -nargs=* WatchAndExec  call utils#StartWatcher("<args>")
"}}}

"Keybindings {{{

nnoremap <silent> <leader>z  :call utils#ZoomWindow()<cr>
nnoremap <silent> <leader>=  <C-w>=
nnoremap <silent> `<space>  `I \| z.


" for browsing the input history
cnoremap <c-n> <down>
cnoremap <c-p> <up>

" disable arrow keys
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>
nnoremap   <c-space> :bd<cr>
"inoremap <esc> <c-o>:echoe "use jk"<cr>
inoremap jk <esc>
vnoremap > >gv
vnoremap < <gv
nnoremap 0 ^
nnoremap ^ 0
noremap <C-s> :w<cr>
"Move by screen lines
nnoremap j gj
nnoremap k gk

" Function keys
" https://github.com/neovim/neovim/issues/4862#issuecomment-282988543
nnoremap <F14>  :<C-U>call signature#mark#Goto("prev", "spot", "pos") <CR> \| zz

nnoremap <F5> :UndotreeToggle<CR>
nnoremap <F6> :lnext<cr>
nnoremap <S-F6> :lprev<cr>
nnoremap <F18> :lprev<cr>

nnoremap <F7> :Neoformat<cr>
nnoremap <F8> :Gitex<cr>

nnoremap <F4> :Console<cr>
nnoremap <S-F4> :Wex<cr>
nnoremap <F16> :Wex<cr>

"leader mappings
nnoremap <leader>bd :bd<cr>
nnoremap <leader>d :bd!<cr>
nnoremap <leader>q :qall<cr>
nnoremap <leader>1 :on<cr>
nnoremap <leader>. @:
nnoremap <leader>p "0p
nnoremap <leader>P "0P
vnoremap <leader>p "0p
vnoremap <leader>P "0P
nnoremap <leader>a :b#<cr>
nnoremap <leader>h  :noh<cr><c-l>
nnoremap <leader>w  :w<cr>
nnoremap <leader>fc :lcl <cr>
nnoremap <leader>pw :ed ~/.gnupg/passwords.txt.asc <cr>
nnoremap <leader>sv :ed $MYVIMRC<cr>
nnoremap <leader>e :edit <C-R>=fnamemodify(@%, ':p:h')<CR>/
" copy a block and comment it and move to insert mode
vmap <leader>ce  <S-v>ygv<Leader>cc`>pi

nnoremap <backspace>    <C-o>
nnoremap <tab>    <C-i>

map [[ ?{<CR>w99[{
map ][ /}<CR>b99]}
map ]] j0[[%/{<CR>
map [] k$][%?}<CR>

" Don't use Ex mode, use Q for formatting
map Q gq


"Open splits to the right by default
set splitright
" open help in a vert split to the right
cabbrev h vert bo h

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Search and replace related mappings
nnoremap / /\v
cnoremap %s/ %s/\v
vnoremap % <space>%
vnoremap <silent> * y:let @/=@"<cr>:set hlsearch<cr>n
" Center on screen after moving to next/prev match
nnoremap n nzz
nnoremap N Nzz


"Move lines
nnoremap <A-j> :m+<CR>==
nnoremap <A-k> :m-2<CR>==
inoremap <A-j> <Esc>:m+<CR>==gi
inoremap <A-k> <Esc>:m-2<CR>==gi
vnoremap <A-j> :m'>+<CR>gv=gv
vnoremap <A-k> :m-2<CR>gv=gv

"}}}
"
function! s:SetupGhostBuffer()
    if match(expand("%:a"), '\v/ghost-(github|reddit)\.com-')
        set ft=markdown
    endif
endfunction

augroup vim-ghost
    au!
    au User vim-ghost#connected call s:SetupGhostBuffer()
augroup END
