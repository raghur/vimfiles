" vim: fdm=marker:
" Options {{{
let g:home=expand('<sfile>:p:h')."/"
let g:python3_host_prog="d:/sdks/python3/python.exe"
let g:python_host_prog="c:/python27/python.exe"
let g:ruby_host_prog="C:/tools/ruby23/bin/ruby.EXE"

"force python 3 if available.
" linux only one python can be loaded at a time.
if exists('py2') && has('python')
elseif has('python3')
endif

fun! s:createIfNotExists(dir)
    if !isdirectory(a:dir)
        call mkdir(a:dir, "p")
    endif
endfunction
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
set re=2    " use the new NFA engine
set wildchar=<Tab>
set wildmenu
set wildmode=longest:full
set wildignore+=*.swp,*.bak,*.class,.git/*,.svn/*,.git\*,.svn\*
set pastetoggle=<F11>
set ignorecase smartcase
set guioptions-=T
set guioptions-=t
set guioptions-=r
set guioptions+=R
set timeout timeoutlen=1000 ttimeoutlen=100
set undofile
call s:createIfNotExists(g:home.".vimbackups/.undo")
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
call s:createIfNotExists(g:home.".vimbackups/.backup")
exec("set backupdir=".g:home.".vimbackups/.backup")
call s:createIfNotExists(g:home.".vimbackups/.swap")
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

" ConEmu
if !empty($CONEMUBUILD) && !has('nvim')
    set term=pcansi
    let &t_AB="\e[48;5;%dm"
    let &t_AF="\e[38;5;%dm"
endif

" tmux and otherwise
set t_Co=256
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
set relativenumber
set nu
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

if exists("+guifont")
    if has('win32') || has('win64')
        let g:fonts="Fantasque_Sans_Mono:h13:cANSI,"
                    \ . "Ubuntu_Mono_derivative_Powerlin:h13,"
                    \ . "Source_Code_Pro_Light:h11,"
                    \ . "Powerline_Consolas:h11,"
                    \ . "DejaVu_Sans_Mono_For_Powerline:h11,"
                    \ . "PragmataPro_Mono:h11"
        let g:fonts=split(g:fonts, ",")
    else "unix
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
        let g:GPGUseAgent = 1
    endif
endif

let g:colorschemes="Tomorrow-Night"
            \ . ":monokai"
            \ . ":molokai"
            \ . ":github"
            \ . ":kalisi"
let g:colorschemes = split(g:colorschemes, ":")
colors Tomorrow-Night
"}}}

" Plugin Bundles and config {{{
exec("set rtp^=".g:home)

if empty(glob(g:home . 'autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

call plug#begin(g:home.'bundle')
Plug 'kshenoy/vim-signature'
augroup gpg
    au!
    autocmd BufNewFile,BufRead *.gpg, *.asc setf gpg
augroup END
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

Plug 'vim-scripts/L9'
Plug  'Shougo/neomru.vim'
Plug  'Shougo/neoyank.vim'


Plug  'shougo/unite.vim'
let g:unite_data_directory = g:home.".vimbackups/unite"
let g:unite_source_history_yank_enable=1
let g:unite_source_rec_max_cache_files=5000
let s:unite_ignores = [
            \ '\.git', 'deploy', 'dist',
            \ 'undo', 'tmp', 'backups',
            \ 'generated', 'build', 'images', 'node_modules']

if executable('ag')
    let g:unite_source_grep_command='ag'
    let g:unite_source_grep_default_opts='--nocolor --line-numbers --nogroup -S -C4'
    let g:unite_source_grep_recursive_opt=''
    " Using ag as recursive command.
    let g:unite_source_rec_async_command = ['ag', '--follow', '--nocolor', '--nogroup',
                \  '--hidden', '-g', '']
endif

if executable('sift')
    let g:unite_source_grep_command='sift'
    let g:unite_source_grep_default_opts='--no-color --line-number --no-group -s '
    let g:unite_source_grep_recursive_opt=''
    let g:unite_source_rec_async_command = ['sift', '--follow', '--no-color', '--no-group',
                \ '--git', '--targets']
endif
if executable('rg')
    let g:unite_source_grep_command='rg'
    let g:unite_source_grep_separator=''
    let g:unite_source_grep_default_opts='--vimgrep -g "!*.min.js" -w -e'
    let g:unite_source_grep_recursive_opt=''
    let g:unite_source_rec_async_command = ['rg', '--files']
endif
function! s:unite_settings()
    nmap <buffer> Q <plug>(unite_exit)
    nmap <buffer> <esc> <plug>(unite_exit)
    imap <buffer> <esc> <plug>(unite_exit)
    nmap <buffer> <F5> <plug>(unite_redraw)
    imap <buffer> <F5> <plug>(unite_redraw)
    imap <buffer> jk <Plug>(unite_insert_leave)
    inoremap <silent><buffer><expr> <C-s>     unite#do_action('split')
    inoremap <silent><buffer><expr> <C-v>     unite#do_action('right')
endfunction
augroup unite
    autocmd!
    autocmd FileType unite call s:unite_settings()
augroup END
function! Quitalready()
    if &readonly
        :q
        return
    endif
    :x
endfunction

Plug  'vim-pandoc/vim-pandoc'
Plug  'vim-pandoc/vim-pandoc-syntax'
let g:pandoc#formatting#mode="hA"
" let g:pandoc#formatting#smart_autoformat_on_cursormoved = 1
let g:pandoc#syntax#codeblocks#embeds#langs = ["ruby","python","bash=sh",
            \ "css", "erb=eruby", "javascript",
            \ "js=javascript", "json=javascript", "ruby",
            \ "sass", "xml", "html"]

Plug  'tpope/vim-repeat'
let g:AutoPairsShortcutToggle = '\\'
Plug  'jiangmiao/auto-pairs'
let g:indent_guides_guide_size = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']
if has("gui_running")
    let g:indent_guides_enable_on_vim_startup = 1
endif

Plug  'mbbill/undotree', {
            \ 'on': ['UndotreeToggle']
            \ }
Plug  'gregsexton/MatchTag'
Plug  'tpope/vim-commentary'
Plug  'tyru/open-browser.vim'

if has('python') || has('python3')
    Plug  'SirVer/ultisnips'
    Plug  'honza/vim-snippets'
    let g:UltiSnipsUsePythonVersion=3
    let g:UltiSnipsSnippetsDir=g:home."UltiSnips"
    let g:UltiSnipsExpandTrigger="<c-cr>"
    if !has('nvim') && !has('gui_running')
        let g:UltiSnipsExpandTrigger="<c-space>"
    endif
    let g:UltiSnipsListSnippets="<c-tab>"
endif

Plug  'scrooloose/syntastic'
let g:syntastic_python_checkers = ['pycodestyle']
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_auto_loc_list = 1
let g:syntastic_mode_map = { 'mode': 'passive',
            \ 'active_filetypes': ['python', 'json', 'javascript'],
            \ 'passive_filetypes': [] }

Plug 'NLKNguyen/papercolor-theme'
Plug 'sickill/vim-monokai'
Plug 'altercation/vim-colors-solarized'
Plug 'freeo/vim-kalisi'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'chriskempson/vim-tomorrow-theme'
let g:solarized_termcolors=256

Plug  'pangloss/vim-javascript'
Plug  'elzr/vim-json'
let g:vim_json_syntax_conceal = 0


Plug  'vim-scripts/matchit.zip'
Plug  'tpope/vim-ragtag'


Plug  'wellle/targets.vim'
Plug  'kana/vim-textobj-user'
Plug  'kana/vim-textobj-function'
Plug  'thinca/vim-textobj-function-javascript', {
            \ 'for': 'javascript'
            \ }
" Plug  'kana/vim-textobj-indent'
" Plug  'thinca/vim-textobj-between'
" Plug  'terryma/vim-expand-region'
Plug  'rstacruz/sparkup', { 'rtp': 'vim' }

" vim-airline and fonts
set lazyredraw
set laststatus=2

Plug  'vim-airline/vim-airline'
let g:airline_enable_branch=1
let g:airline_enable_syntastic=1
let g:airline_powerline_fonts=1
let g:airline_detect_modified=1


Plug  'tpope/vim-dispatch'

Plug  'airblade/vim-rooter'
let g:rooter_silent_chdir = 1

Plug  'Shougo/vimproc.vim'
Plug 'Shougo/deoplete.nvim', Cond(has('nvim'))
let g:deoplete#enable_at_startup = 1
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"


"neocomplete
" run: nmake -f Make_msvc.mak nodebug=1
let g:neocomplete#use_vimproc = 1
let g:neocomplete#enable_at_startup = 1
Plug  'Shougo/neocomplete', Cond(!has('nvim') && has('lua'))

let g:yankstack_yank_keys = ['c', 'C', 'd', 'D', 'x', 'X', 'y', 'Y']
Plug  'maxbrunsfeld/vim-yankstack'

" make sure this is after vim-yankstack
Plug  'tpope/vim-surround'

" vim sneak; replace f/F with sneak
Plug  'justinmk/vim-sneak', {
            \ 'on': '<Plug>Sneak'
            \ }
"replace 'f' with 1-char Sneak
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
xmap f <Plug>Sneak_f
xmap F <Plug>Sneak_F
omap f <Plug>Sneak_f
omap F <Plug>Sneak_F
let g:sneak#s_next = 0

let g:stopFirstAndNotifyTimeoutLen = 0
let g:EnhancedJumps_CaptureJumpMessages = 0
Plug 'vim-scripts/ingo-library'
Plug  'vim-scripts/EnhancedJumps'


Plug  'PProvost/vim-ps1'
"Plug  'nvie/vim-pyunit'
Plug  'python-mode/python-mode'
let g:jedi#force_py_version = 3
let g:jedi#goto_command = '<localleader>g'
let g:jedi#rename_command = '<localleader>r'
let g:jedi#usages_command = '<localleader>u'
let g:jedi#show_call_signatures = 2
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
Plug  'davidhalter/jedi-vim'
let g:pymode_run_bind = '<leader>pr'
let g:pymode_rope = 0
let g:pymode_lint = 0

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

Plug  'xolox/vim-misc'
Plug  'xolox/vim-session'
if (has('win32unix'))
    let g:session_directory=g:home.".vimbackups/.cygsessions"
else
    let g:session_directory=g:home.".vimbackups/.sessions"
endif
let g:session_command_aliases = 1
let g:session_autosave='yes'
let g:session_autoload='yes'
let g:session_default_to_last=1

Plug  'kana/vim-submode'
Plug  'Chiel92/vim-autoformat', {
            \ 'on': 'AutoFormat'
            \ }
Plug 'mhinz/vim-grepper'
Plug 'Shougo/denite.nvim'

" for browsing the input history
cnoremap <c-n> <down>
cnoremap <c-p> <up>

nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

nnoremap <leader>g :Grepper -tool git<cr>
nnoremap <leader>rg :Grepper -tool rg<cr>
nnoremap <leader>* :Grepper -tool rg -cword -noprompt<cr>

let g:grepper = {
    \ 'tools':     ['rg', 'git', 'grep'],
    \ 'open':      1,
    \ 'jump':      0,
    \ 'switch':     1,
    \ 'next_tool': '<leader>g',
    \ }

set rtp+=$GOROOT/misc/vim
call plug#end()
if !has('nvim') && !empty(glob(g:home . 'neocomplete-custom.vim'))
    exec "so ".g:home."neocomplete-custom.vim"
endif

" unite settings
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#custom#profile('files', 'filters', 'sorter_rank')
call unite#custom#source('file_rec/neovim,buffer', 'sorters', 'sorter_selecta')
call unite#custom#profile('default', 'context', {
            \ 'start_insert': 1,
            \ 'prompt': " ",
            \ 'prompt-visible': 1
            \ })
if executable('rg')
    call denite#custom#var('file_rec', 'command',
        \ ['rg', '--files', '--glob', '!.git', ''])
elseif executable('sift')
    call denite#custom#var('file_rec', 'command',
        \ ['sift', '--targets' ])
endif
call denite#custom#source(
        \ 'file_rec,buffer', 'sorters', ['sorter_sublime'])
" Change default prompt
call denite#custom#option('default', 'prompt', ' ')
call denite#custom#map('insert', '<Up>', '<denite:move_to_previous_line>')
call denite#custom#map('insert', '<Down>', '<denite:move_to_next_line>')
nnoremap <silent> <C-p> :<C-u>Denite -direction=top -auto-resize file_rec buffer<cr>
nnoremap <silent> <C-b> :<C-u>Denite -direction=top -auto-resize buffer file_mru<cr>
nnoremap <silent> <C-h> :<C-u>Denite -direction=top -auto-resize help<cr>
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

filetype plugin indent on
"}}}

" Autocommands {{{

"'<,'>s/lastmod\s*=\s*".*"/\="lastmod = \"". strftime("%FT%H:%M:%S").strftime("%z")[:2]. ":".strftime("%z")[3:]."\""

augroup AsciiDoc
    au!
    autocmd FileType asciidoc setl wrap
                \ spell spelllang=en_us
    autocmd FileType asciidoc au BufWritePre <buffer>
                \ :silent 1,12s/^lastmod\s*=\s*".*"/\="lastmod = \"". strftime("%FT%H:%M:%S").strftime("%z")[:2]. ":".strftime("%z")[3:]."\""/e
augroup END
augroup Markdown
    au!
    autocmd FileType markdown setl wrap
                \ linebreak
                \ spell spelllang=en_us
    autocmd FileType markdown au BufWritePre <buffer>
                \ :silent 1,12s/^lastmod\s*=\s*".*"/\="lastmod = \"". strftime("%FT%H:%M:%S").strftime("%z")[:2]. ":".strftime("%z")[3:]."\""/e
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
    if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
    endif
    let g:neocomplete#force_omni_input_patterns.python =
                \ '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
    " alternative pattern: '\h\w*\|[^. \t]\.\w*'
augroup END

"}}}

" Custom code/Utils {{{

function! s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction

augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

function! Getfont()
    let font=""
    if exists('*GuiFont')
        redir => font
        GuiFont
        redir END
        return substitute(font, '\r\+\|\n\+', '','')
    else
        return &guifont
    endif
endfunction

function! Setfont(font)
    " echom "Setting font to: ". a:font
    if exists('*GuiFont')
        exec "GuiFont! " . a:font
    elseif exists('+guifont')
        exec "set guifont=".substitute(a:font, " ", "\\\\ ", "g")
    else
        :silent !echom "Running in console - change your console font."
    endif
endfunction


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


fun! CycleColorScheme(dir)
    let c = CycleArray(g:colorschemes, g:colors_name, a:dir)
    let scheme = g:colorschemes[c]
    exec "colors " scheme
    redraw | echom "Setting colorscheme to: ".scheme
endfun
command! ColorsNext call CycleColorScheme(1)
command! ColorsPrev call CycleColorScheme(-1)

fun! CycleFont(dir)
    if !exists("g:fonts")
        return
    endif
    let font = Getfont()
    let c = CycleArray(g:fonts, font, a:dir)
    "let font = substitute(arr[c], " ", '\\ ', "g")
    echom g:fonts[c]
    call Setfont(g:fonts[c])
    redraw | echom "Setting font to: " . g:fonts[c]
endfun
command! FontNext call CycleFont(1)
command! FontPrev call CycleFont(-1)

if exists("g:fonts")
    call Setfont(g:fonts[0])
endif

fun! RemoveCtrlM()
    :update
    :e ++ff=dos
    :%s/\r$//e
endfun

func! ReadExCommandOutput(newbuf, cmd)
    redir => l:message
    silent! execute a:cmd
    redir END
    if a:newbuf | wincmd n | endif
    silent put=l:message
endf

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

function! ToHtml()
    :w
    let file=expand("%:p")
    let outfile=fnamemodify(file, ":r") . ".html"
    let css=fnamemodify(file, ":h") . "pandoc.css"
    exec "silent !pandoc --toc  -c ". css .
                \ " -F mermaid-filter.cmd" .
                \ "  -fmarkdown_github" .
                \ "+footnotes" .
                \ "+implicit_header_references".
                \ "+auto_identifiers".
                \ "+superscript".
                \ "+subscript".
                \ "+fancy_lists".
                \ "+startnum".
                \ "+strikeout -i " . file . " -o " . outfile
    echom "wrote" . " " . outfile
    call openbrowser#open("file:///".substitute(outfile, "\\", "/", "g"))
endfunction

"}}}

"Commands {{{
if has("unix")
    command! W :execute ':silent w !sudo tee % > /dev/null' | :edit!
endif
command! RemoveCtrlM call RemoveCtrlM()
command! EditAsWin call RemoveCtrlM()

command! -nargs=+ -bang -complete=command R call ReadExCommandOutput(<bang>1, <q-args>)
inoremap <c-r>R <c-o>:<up><home>R! <cr>
func! s:systemwrapper(cmd)
    echom a:cmd
    let output=system(a:cmd)
    return output
endfunction
func! BlogSave(file)
    " to debug, replace with
    " exec "!easyblogger file " . a:file
    let output=s:systemwrapper("easyblogger file ". a:file)
    echom output
endfunction
func! Conemu()
    let cmd="\"C:/Program Files/ConEmu/ConEmu64.exe\" -run \"{cmd}\" -dir \"". expand("%:p:h"). "\""
    call s:systemwrapper(cmd)
endfun

command! BlogSave call BlogSave(expand("%:p"))

set foldtext=NeatFoldText()
command! ToHtml call ToHtml()

command! Gitex call s:systemwrapper("gitex browse \"" . expand("%:p:h") . "\"")
command! Wex call s:systemwrapper( "explorer \"" . expand("%:p:h") . "\"")
command! Conemu call Conemu()
"}}}

"Keybindings {{{

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
nnoremap <F2>  :<C-U>call signature#mark#Goto("next", "spot", "pos") <CR> \| zz
nnoremap <S-F2>  :<C-U>call signature#mark#Goto("prev", "spot", "pos") <CR> \| zz
nnoremap <F4> :w\|SyntasticCheck<cr>
nnoremap <F5> :UndotreeToggle<CR>
nnoremap <F6> :lnext<cr>
nnoremap <S-F6> :lprev<cr>
nnoremap <F7> :Autoformat<cr>
nnoremap <F8> :Conemu<cr>
nnoremap <F9> :Gitex<cr>
nnoremap <F10> :Wex<cr>

"unite
nnoremap <silent> <leader><space> :<C-u>Unite -toggle -auto-resize -buffer-name=mixed neomru/file buffer file_rec/async:! <cr><c-u>
nnoremap <silent> <leader>f :<C-u>Unite -toggle -auto-resize -buffer-name=file file_rec/async:! <cr><c-u>
nnoremap <silent> <leader>r :<C-u>Unite -buffer-name=recent neomru/file<cr>
nnoremap <silent> <leader>o :<C-u>UniteWithProjectDir -buffer-name=children file_rec/async:!<cr><c-u>
" nnoremap <silent> <leader>j :<C-u>Unite -buffer-name=jumps jump change<cr>
nnoremap <silent> <leader>l :<C-u>Unite -auto-resize -buffer-name=line line<cr>
nnoremap <silent> <leader>b :<C-u>Unite -auto-resize -buffer-name=buffers buffer file_mru<cr>
" nnoremap <silent> <leader>g :<C-u>UniteWithProjectDir -no-quit -buffer-name=search grep:.<cr>

"leader mappings
nnoremap <leader>bd :bd<cr>
nnoremap <leader>d :bd!<cr>
nnoremap <leader>q :call Quitalready()<cr>
nnoremap <leader>w :w<cr>
nnoremap <leader>1 :on<cr>
nnoremap <leader>. @:
nnoremap <leader>a :b#<cr>
nnoremap <leader>h  :noh<cr><c-l>
nnoremap <leader>w  :w<cr>
nnoremap <leader>fc :lcl <cr>
nnoremap <leader>pw :ed ~/.gnupg/passwords.txt.asc <cr>
nnoremap <leader>sv :ed $MYVIMRC<cr>
vnoremap <leader>v "0p
" copy a block and comment it and move to insert mode
vmap <leader>ce  <S-v>ygv<Leader>cc`>pi

" backspace and tab
nmap <backspace> <Plug>EnhancedJumpsOlder
nmap <C-backspace> <Plug>EnhancedJumpsRemoteOlder
nmap <C-tab> <Plug>EnhancedJumpsRemoteNewer
nnoremap <backspace>    g;
nnoremap <tab>    g,

map [[ ?{<CR>w99[{
map ][ /}<CR>b99]}
map ]] j0[[%/{<CR>
map [] k$][%?}<CR>

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>
nnoremap / /\v
cnoremap %s/ %s/\v
vnoremap % <space>%
vnoremap <silent> * y:let @/=@"<cr>:set hlsearch<cr>n


"Move lines
nnoremap <A-j> :m+<CR>==
nnoremap <A-k> :m-2<CR>==
inoremap <A-j> <Esc>:m+<CR>==gi
inoremap <A-k> <Esc>:m-2<CR>==gi
vnoremap <A-j> :m'>+<CR>gv=gv
vnoremap <A-k> :m-2<CR>gv=gv

"}}}
