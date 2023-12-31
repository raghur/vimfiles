local M = {}
vim.keymap.set('v', '<leader>=', vim.lsp.buf.format)
vim.cmd([[

let maplocalleader='\'
let mapleader = ' '
" map <space> <leader>

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
inoremap jk <esc>
vnoremap > >gv
vnoremap < <gv
nnoremap 0 ^
nnoremap ^ 0

"Move by screen lines
nnoremap j gj
nnoremap k gk

" Function keys
" https://github.com/neovim/neovim/issues/4862#issuecomment-282988543
nnoremap <F5> :UndotreeToggle<CR>
nnoremap <F7> :Neoformat<cr>
nnoremap <S-F4> :Wex<cr>

"leader mappings
nnoremap <leader>1 :on<cr>
nnoremap <leader>a :b#<cr>
nnoremap <leader>d :bd!<cr>
nnoremap <leader>e :edit <C-R>=fnamemodify(@%, ':p:h')<CR>/
nnoremap <leader>h :noh<cr><c-l>
nnoremap <leader>q :qall<cr>
nnoremap <leader>w :w<cr>
nnoremap <leader>= <cmd>lua vim.lsp.lsp.buf.formatting({async=true})<cr>
" copy a block and comment it and move to insert mode


vmap <leader>ce  <S-v>ygv<Leader>cc`>pi

nnoremap <backspace>    <C-o>
nnoremap <tab>    <C-i>

" Don't use Ex mode, use Q for formatting
map Q gq
nnoremap <silent> <F3> :redir @a<CR>:g//<CR>:redir END<CR>:new<CR>:put! a<CR>

" open help in a vert split to the right
cabbrev h vert bo h
cabbrev map verb map<space>

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

" vnoremap <leader>vs :'<,'>so<CR>
" source a visual range
]])
M.mapKeys = function()
  local wk = require('which-key')
  local utils = require('raghu.utils')
  local font = require('raghu.font')
  local mappings = {
    i = {
      name = '+Config',
      m = { function () utils.editConfig('mappings.lua') end, 'Mappings'},
      i = { "<Cmd>ed $MYVIMRC<cr>", 'init.lua'},
      s = { function () utils.editConfig('settings.lua') end, 'Settings'},
      p = { function () utils.editConfig('plugins.lua') end, 'Plugins'},
      c = { function () utils.editConfigFolder('raghu') end, 'Plugin Config Folder'},
      [","] = { "<cmd>source %<cr>", 'Source file'},
    }
  }
  wk.register(mappings, {prefix = "<leader>"})

  local vMappings = {
    i = {
      name="+Config",
      [","] = {function ()
        local start  = vim.fn.getpos("v")[2]
        local fin = vim.fn.line(".")
        local cmd =start..","..fin.."so"
        print("Sourced: "..cmd)
        vim.cmd(cmd)
      end, 'Source lines'}
    }
  }
  wk.register(vMappings, {mode = 'v', prefix = "<leader>"})

  mappings = {
      name = "Guifont",
      ["<M-=>"] = {function() font.adjust(1) end, 'Increase Font'},
      ["<M-->"] = {function() font.adjust(-1) end, 'Decrease Font'}
  }
  wk.register(mappings, {})
end
return M
