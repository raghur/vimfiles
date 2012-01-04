" An example for a vimrc file.
"
" Maintainer:   Bram Moolenaar <Bram@vim.org>
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

call pathogen#infect()

set wildchar=<Tab> wildmenu wildmode=full
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set pastetoggle=<F12>
set ignorecase
set guioptions-=T
set guioptions-=r
set guioptions+=R

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
    set guifont=Consolas:h10:cANSI
else 
    set guifont=DejaVu\ Sans\ Mono\ 9
endif
set t_Co=256
set path+=$HOME,.,,~/git,~/code
" slash allows opening files from windows.
set sessionoptions+=unix,slash

" avoids messing up folders with *.swp and file~ backups
set backupdir=~/.vimbackups
set directory=~/.vimbackups
set switchbuf=usetab
set matchpairs+=<:>
set showmatch
set nowrap
set copyindent
set smarttab
set smartindent
set wildignore=*.swp,*.bak,*.class
set visualbell
set noerrorbells
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.

au BufNewFile,BufRead *.aspx set filetype=html
au BufNewFile,BufRead *.ascx set filetype=html
au BufNewFile,BufRead *.moin setf moin
au BufNewFile,BufRead *.wiki setf moin

" completion popup customizations
set completeopt=longest,menuone
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' : '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <M-,> pumvisible() ? '<C-n>' : '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

" random stuff..
set autochdir
set foldmethod=syntax
set relativenumber
let mapleader = "w"

" Search customizations
" replace all instances in a line.
set gdefault
nnoremap / /\v
nnoremap <leader><space>  :noh<cr>

" keybindings
set colorcolumn=+1
nnoremap 0 ^
nnoremap ^ 0
noremap <C-s> :w<cr>
nnoremap <leader>p :b#<cr>
nnoremap <leader>b :buffers<cr>:buffer
vnoremap <leader>h :normal @
" select forward brace block on the line
map <Leader><Leader> $F{%$
" copy a block and comment it and move to insert mode
vmap <leader>ce  <S-v>ygv<Leader>cc`>pi
inoremap <C-e> <C-o>:call search("\\%" . line(".") . "l[{}() :=\\[\\]\.,\\n]","We")<cr>
inoremap <C-a> <C-o>:call search("\\%" . line(".") . "l[{}() :=\\[\\]\.,]","Web")<cr>
imap <leader><leader> <Esc>

" colors
set background=dark
colors peaksea

" status line/mode line
set statusline=%<%F%h%m%r%h%w%y\ %{&ff}\ %{strftime(\"%d/%m/%Y-%H:%M\")}%=\ col:%c%V\ ascii:%b\ pos:%o\ lin:%l\,%L\ %P
set laststatus=2

" Nerd tree customizations
noremap <Leader>f :NERDTreeToggle<cr>

" Clipboard integration
set clipboard=unnamed

"Move lines
nnoremap <A-j> :m+<CR>==
nnoremap <A-k> :m-2<CR>==
inoremap <A-j> <Esc>:m+<CR>==gi
inoremap <A-k> <Esc>:m-2<CR>==gi
vnoremap <A-j> :m'>+<CR>gv=gv
vnoremap <A-k> :m-2<CR>gv=gv

let VIMPRESS = [{'username':'rraghur', 
                \'password':'',
                \'blog_url':'http://niftybits.wordpress.com' 
                \}] 
augroup Markdown
    autocmd FileType markdown set wrap 
                            \ linebreak
                            \ spell spelllang=en_us
augroup END
nmap <leader><leader>q <ESC>:mksession! ~/vimfiles/sessions/Session.vim<CR>:wqa<CR>

function! RestoreSession()
  if argc() == 0 "vim called without arguments
    execute 'source ~/vimfiles/sessions/Session.vim'
  end
endfunction
autocmd VimEnter * call RestoreSession()