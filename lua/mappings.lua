

vim.cmd([[

let maplocalleader='\'
let mapleader = '<space>'
map <space> <leader>

nnoremap <silent> <leader>z  :call utils#toggleZoom()<cr>

" file explorer
nnoremap <silent> <leader>ex  <cmd>:lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<cr>


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
nmap <F2> mm
nnoremap <F4> :Console<cr>
nnoremap <F5> :UndotreeToggle<CR>
nnoremap <F6> :lnext<cr>
nnoremap <F7> :Neoformat<cr>
nnoremap <F8> :Gitex<cr>
nnoremap <S-F4> :Wex<cr>
nnoremap <S-F6> :lprev<cr>
nnoremap <F14>  :<C-U>call signature#mark#Goto("prev", "spot", "pos") <CR> \| zz
nnoremap <F16> :Wex<cr>
nnoremap <F18> :lprev<cr>

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
nnoremap <leader>w  :w<cr>
nnoremap <leader>= :lua vim.lsp.buf.format()<cr>
" copy a block and comment it and move to insert mode


vmap <leader>ce  <S-v>ygv<Leader>cc`>pi

nnoremap <backspace>    <C-o>
nnoremap <tab>    <C-i>

" Don't use Ex mode, use Q for formatting
map Q gq
nnoremap <silent> <F3> :redir @a<CR>:g//<CR>:redir END<CR>:new<CR>:put! a<CR>

" open help in a vert split to the right
cabbrev h vert bo h

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

inoremap <S-Insert> <c-r>+
inoremap <S-Insert> <c-r>+
cnoremap <S-Insert> <c-r>+

" Paste sanity
vnoremap <S-Insert> "0p
vnoremap p "0p
vnoremap P "0P
nnoremap c "_c
nnoremap C "_C

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

" more leader mappings for editing vim and lua config
nnoremap <leader>ii :ed $MYVIMRC<cr>
nnoremap <leader>im <Cmd>lua require('raghu.utils').editConfig('mappings.lua')<cr>
nnoremap <leader>is <Cmd>lua require('raghu.utils').editConfig('settings.lua')<cr>
nnoremap <leader>ip <Cmd>lua require('raghu.utils').editConfig('plugins.lua')<cr>
nnoremap <leader>ic <Cmd>lua require('raghu.utils').editConfigFolder('raghu')<cr>

nmap <leader>vs :source %<CR>
" source a visual range
vmap <leader>vs y:@"<CR>
]])

