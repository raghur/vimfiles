" vim: fdm=marker:
" Clone this repo to vimfiles under windows and .vim under linux and you're
" good to go. See https://www.reddit.com/r/vim/comments/3gdycs/problem_with_syncing_vimrc_between_windows_and/ctxc32m/
" For neovim (windows), link Appdata/local/nvim --> vimfiles
" For neovim (linux), link ~/.config/nvim --> ~/.vim
"
" Font ligatures
" Test ligatures: -> != == === >= <= =>
"
" Options {{{


" temporary to avoid 'hit enter' messages
let g:home=expand('<sfile>:p:h')."/"
call utils#os_script()

"force python 3 if available.
" linux only one python can be loaded at a time.
if exists('py2') && has('python')
elseif has('python3')
endif
if exists("+pyxversion")
    set pyxversion=3
endif

set completeopt=menu,menuone,noselect
set guioptions^=c
set guioptions-=T
set guioptions-=t
set guioptions-=r
set guioptions+=R
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
set wildignorecase
set pastetoggle=<F11>
set ignorecase smartcase
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

call utils#SetColors("Tomorrow-Night", "Monokai", "molokai", "github", "kalisi,dark", "gruvbox,dark")
call utils#SetFonts("FantasqueSansMono NF",
            \ "Iosevka Curly",
            \ "Courier New",
            \ "Cousine",
            \ "DejaVu Sans Mono",
            \ "Envy Code R",
            \ "Inconsolata",
            \ "Iosevka Term",
            \ "Liberation Mono",
            \ "mononoki",
            \ "Nimbus Mono L",
            \ "Noto Mono",
            \ "Noto Sans Mono",
            \ "PT Mono",
            \ "Ubuntu Mono",
            \ "Hack")
"}}}

" Plugin Bundles and config {{{

if empty(glob(g:home . 'autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

let g:deferredPlugins = []

function! UnloadPlug(name, ...)
    let name = split(a:name, '/')[1]
    let idx = index(g:deferredPlugins, name)
    if idx != -1 
        call remove(g:deferredPlugins, idx)
    endif

    if has_key(g:plugs, name)
        let r = remove(g:plugs, name)
    endif
endfunction

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
command! -nargs=* Unplug call UnloadPlug(<args>)
" command! -nargs=* UndeferPlug call echo args

call plug#begin(g:home.'bundle')
Plug 'MattesGroeger/vim-bookmarks'
highlight link BookmarkSign PreProc
" Plug 'nvim-neorg/neorg' | Plug 'nvim-lua/plenary.nvim'

Plug 'raghur/vim-helpnav', {
            \ 'for' : ['help']
            \ }

Plug  'tpope/vim-repeat'
let g:AutoPairsShortcutToggle = '\\'
Plug 'jiangmiao/auto-pairs'

Plug  'mbbill/undotree', {
            \ 'on': ['UndotreeToggle']
            \ }
Plug  'gregsexton/MatchTag'
Plug  'tpope/vim-commentary'

Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'rafamadriz/friendly-snippets'

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
" inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

Plug 'roxma/nvim-yarp', v:version >= 800 && !has('nvim') ? {} : { 'on': [], 'for': [] }
Plug 'roxma/vim-hug-neovim-rpc',  v:version >= 800 && !has('nvim') ? {} : { 'on': [], 'for': [] }
" let g:deoplete#enable_at_startup = 1
Plug 'tpope/vim-surround'

Plug 'rhysd/clever-f.vim'
let g:clever_f_ignore_case=1
map ; <Plug>(clever-f-repeat-forward)
map , <Plug>(clever-f-repeat-back)

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

" DeferPlug 'kana/vim-submode'
Plug 'sbdchd/NeoFormat', {
            \ 'on': 'Neoformat'
            \ }

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
Plug 'raghur/vim-ghost', {'do': ':GhostInstall'}

function! s:SetupGhostBuffer()
    if match(expand("%:a"), '\v/ghost-(github|reddit|stackexchange|stackoverflow)\.com-')
        set ft=markdown
    endif
endfunction

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
" Plug 'raghur/fruzzy', { 'do': { -> fruzzy#install()} }
" let g:fruzzy#usenative = 1
" let g:fruzzy#sortonempty = 0

" let g:fzf_buffers_jump = 1
" let g:fzf_preview_window=''
DeferPlug 'junegunn/fzf', {'on': 'VimEnter', 'do': { -> fzf#install() }}
DeferPlug 'junegunn/fzf.vim', {'on': 'VimEnter'}

if has("nvim")
    Plug 'nvim-treesitter/nvim-treesitter'
    Plug 'nvim-treesitter/playground'
    Plug 'nvim-orgmode/orgmode'
    " very ordering sensitive here
    Plug 'williamboman/mason.nvim'
    Plug 'williamboman/mason-lspconfig.nvim'
    Plug 'onsails/lspkind-nvim'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-emoji'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/cmp-vsnip'
    Plug 'hrsh7th/vim-vsnip'
    " DO NOT lazy load - won't work
    Plug 'hrsh7th/nvim-cmp'

    Plug 'neovim/nvim-lspconfig'
    Plug 'nvimdev/lspsaga.nvim', {'branch': 'main'}

    Plug 'gbprod/yanky.nvim'
endif

call plug#end()

lua << EOF
 -- Load custom treesitter grammar for org filetype
 require('orgmode').setup_ts_grammar()

 -- Treesitter configuration
 require('nvim-treesitter.configs').setup {
   ensure_installed = {'org', 'yaml', 'json', 'bash', 'cpp', 'c_sharp', 
   'dockerfile', 'dot',  'gitcommit', 'gitattributes',
   'gitcommit', 'graphql', 'hcl', 'javascript', 'lua', 'markdown', 'vim', 'make', 'cmake'
   }, -- Or run :TSUpdate org
   -- If TS highlights are not enabled at all, or disabled via `disable` prop,
   -- highlighting will fallback to default Vim syntax highlighting
   highlight = {
     enable = true,
     -- Required for spellcheck, some LaTex highlights and
     -- code block highlights that do not have ts grammar
     additional_vim_regex_highlighting = {'org'},
   },
 }

 require('orgmode').setup({
   org_agenda_files = {'~/Sync/org/*'},
   org_default_notes_file = '~/Sync/todo.org',
   org_todo_keywords = {'TODO', 'BLOCKED', '|', 'DONE'},
   mappings = {
       prefix = ","
       }
 })
EOF

command! VimEnter :echo "firing VimEnter"
augroup floating_windows
    autocmd!
    autocmd FileType nofile setlocal nofoldenable
augroup END

augroup Plugins
    autocmd!
    " autocmd User nvim-lspconfig :call utils#configurePlugin("lspconfig")
    " autocmd User nvim-lspconfig :call utils#configurePlugin("lspconfig")
    "                                 \ | :call utils#configurePlugin("nvim-cmp")
    "                                 \ | :call utils#configurePlugin("lspsaga")
    "                                 \ | :call utils#configurePlugin("yanky")
    autocmd User vim-airline call LoadVimAirline()
    " fzf
    autocmd User fzf :call utils#configurePlugin("fzf")
    autocmd! FileType fzf set laststatus=0 noshowmode noruler
      \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
    autocmd VimEnter * VimEnter
    autocmd VimEnter * :call utils#configurePlugin("lspconfig")
                        \ | :call utils#configurePlugin("nvim-cmp")
                        \ | :call utils#configurePlugin("lspsaga")
                        \ | :call utils#configurePlugin("yanky")

augroup END

let g:vsnip_snippet_dir=g:home . ".vsnip"
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
    " autocmd User vim-ghost :call utils#GhostStart() | echom "ghost start called"
    autocmd User vim-ghost echom "ghost start called"
    au User vim-ghost#connected call s:SetupGhostBuffer()
augroup END

augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call utils#MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

augroup DeferredLoadOnIdle
    au!
    autocmd CursorHold,CursorHoldI * call plug#load(g:deferredPlugins)
                \ | echom "deferred load completed for " g:deferredPlugins
                \ | autocmd! DeferredLoadOnIdle
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

augroup filecleanup
    au!
    autocmd BufWritePre *.pl,*.js,*.ps1,*.cs,*.md,*.html :%s/\s\+$//e
augroup END

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank("IncSearch", 1000)
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

command! -bar W exe 'w !sudo tee >/dev/null %:p:S' | setl nomod
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
nnoremap <leader>. @:
nnoremap <leader>1 :on<cr>
nnoremap <leader>a :b#<cr>
nnoremap <leader>bd :bd<cr>
nnoremap <leader>c :call utils#CycleColorScheme(1)<cr>
nnoremap <leader>d :bd!<cr>
nnoremap <leader>e :edit <C-R>=fnamemodify(@%, ':p:h')<CR>/
nnoremap <leader>fc :lcl <cr>
nnoremap <leader>h  :noh<cr><c-l>
nnoremap <leader>pw :ed ~/.gnupg/passwords.txt.asc <cr>
nnoremap <leader>q :qall<cr>
nnoremap <leader>sv :ed $MYVIMRC<cr>
nnoremap <leader>w  :w<cr>
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
nnoremap <silent> <F3> :redir @a<CR>:g//<CR>:redir END<CR>:new<CR>:put! a<CR>

"Open splits to the right by default
set splitright
" open help in a vert split to the right
cabbrev h vert bo h

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" make shift insert work in modes
inoremap <S-Insert> <c-r>+
vnoremap <S-Insert> "0p
cnoremap <S-Insert> <c-r>+

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

" if ($WAYLAND_DISPLAY != "")
"     let g:clipboard = {
"                 \   'name': 'wl-clipboard-override',
"                 \   'copy': {
"                 \      '+': ['xclip'],
"                 \      '*': ['xclip'],
"                 \    },
"                 \   'paste': {
"                 \      '+': ['xclip', '-o'],
"                 \      '*': ['xclip', '-o'],
"                 \   },
"                 \   'cache_enabled': 1,
"                 \ }
" endif
