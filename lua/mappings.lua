vim.cmd([[
" for browsing the input history
cnoremap <c-n> <down>
cnoremap <c-p> <up>

" disable arrow keys
noremap  <Up>    <NOP>
noremap  <Down>  <NOP>
noremap  <Left>  <NOP>
noremap  <Right> <NOP>
inoremap jk      <esc>
vnoremap >       >gv
vnoremap <       <gv
nnoremap 0       ^
nnoremap ^       0

"Move by screen lines
nnoremap j gj
nnoremap k gk

nnoremap <backspace>    <C-o>
nnoremap <tab>    <C-i>

" Don't use Ex mode, use Q for formatting
map Q gq

" open help in a vert split to the right
cabbrev h   vert bo h
cabbrev map verb map<space>

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U>      <C-G>u<C-U>

inoremap <S-Insert> <c-r>+
inoremap <S-Insert> <c-r>+
cnoremap <S-Insert> <c-r>+

" Paste sanity
nnoremap c "_c
nnoremap C "_C

" Search and replace related mappings
nnoremap /         /\v
cnoremap %s/       %s/\v
vnoremap %         <space>%
cabbrev s/         s/\v
vnoremap <silent>* y:let @/=@"<cr>:set hlsearch<cr>n
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
]])

local M = {}
M.mapKeys = function()
  local wk = require("which-key")
  local utils = require("raghu.utils")
  local font = require("raghu.font")
  local tele = require("telescope.builtin")
  local getProjectRoot = function()
    vim.fn.fnamemodify(vim.fn.FindRootDirectory(), ":t")
  end
  local fzflua = require'fzf-lua'
  local mappings = {
    { "<leader>f", group = "+Files"},
    { "<leader>ff",function() fzflua.files({ prompt=getProjectRoot() })end, desc = "Find relative"},
    { "<leader>fp",":FzfLua files cwd=<CR>", desc = "Find files at"},
    { "<leader>fe", ":edit <C-R>=fnamemodify(@%, ':p:h')<CR>/", desc = "edit file" },
    { "<leader>fd", "<cmd>:lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<cr>", desc = "Open directory" },


    { "<leader>r", "<Cmd>FzfLua oldfiles<cr>", desc = "Recents" },
    { "<leader>b", "<Cmd>FzfLua buffers<cr>", desc = "Buffers" },
    { "<leader>g", "<Cmd>FzfLua git_files<CR>", desc = "Git files" },
    { "<leader>/", function() fzflua.live_grep({ rg_opts="--hidden", prompt=getProjectRoot(), resume=true}) end, desc = "Grep" },
    { "<leader><space>",function() fzflua.files({ cwd=getProjectRoot()})end, desc = "Find relative"},
    { "<leader>s", "<cmd>vsp ~/Sync/scratch/scratch.txt<cr>", desc = "Scratchpad" },
  }
  wk.add(mappings)

  mappings = {
    { "<leader>c", "<Cmd>FzfLua colorschemes<CR>", desc = "Colors" },
    { "<leader>:", "<Cmd>FzfLua commands<CR>", desc = "Commands" },
    { "<leader>1", "<cmd>on<cr>", desc = "Close others" },
    { "<leader>a", ":b#<cr>", desc = "Last file" },
    { "<leader>d", ":bd!<cr>", desc = "Close buffer" },
    { "<leader>h", ":noh<cr><c-l>", desc = "no highlight" },
    { "<leader>q", ":qall<cr>", desc = "Quit" },
    { "<leader>w", ":w<cr>", desc = "Write" },
    { "<leader>z", ":call utils#toggleZoom()<cr>", desc = "Zoom" },
  }
  wk.add(mappings)

  mappings = {
    { "<leader>i", group = "+Config" },
    { "<leader>im", function() utils.editConfig("mappings.lua") end, desc = "Mappings" },
    { "<leader>ir", ReloadConfig, desc = "Reload" },
    { "<leader>ii", "<Cmd>ed $MYVIMRC<cr>", desc = "Edit init.lua" },
    { "<leader>is", function() utils.editConfig("settings.lua") end, desc = "Settings" },
    { "<leader>ip", function() utils.editConfig("plugins.lua") end, desc = "Plugins" },
    { "<leader>ic", function() utils.editConfigFolder("raghu") end, desc = "Plugin Config Folder" },
    { "<leader>i,", "<cmd>source %<cr>", desc = "Source file" },
    { "<leader>il", group = "+Logging" },
    { "<leader>ild", function() utils.loglvl("DBG") end, desc = "Log - Debug" },
    { "<leader>ili", function() utils.loglvl("INFO") end, desc = "Log - INFO" },
    { "<leader>ilx", function() utils.loglvl("DISABLE") end, desc = "Log - disable" },
  }
  wk.add(mappings)

  local sourceRange = function()
    local start = vim.fn.getpos("v")[2]
    local fin = vim.fn.line(".")
    local cmd = start .. "," .. fin .. "so"
    print("Sourced: " .. cmd)
    vim.cmd(cmd)
  end
  mappings = {
    { "<leader>i", group = "+Config", mode = "v" },
    { "<leader>i,", sourceRange, desc = "Source lines", mode = "v" },
  }
  wk.add(mappings)

  wk.add({
    { "S", ":<C-U>lua MiniSurround.add('visual')<cr>", desc = "Surround", mode = "xn" },
  })

  mappings = {
    { "<S-insert>", '"0p', desc = "paste", mode = "v"},
    { "p", '"0p', desc = "paste", mode = "v"},
    { "P", '"0P', desc = "paste before", mode = "v"},
    { "<leader>p", '"0p', desc = 'Paste "0' },
    { "<leader>P", '"0P', desc = 'Paste "0 before' },
  }
  wk.add(mappings)

  mappings = {
    { "<F3>", ":redir @a<CR>:g//<CR>:redir END<CR>:new<CR>:put! a<CR>", desc = "Copy last search to buffer" },
    { "<F4>", "<cmd>:lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<cr>", desc = "Open directory" },
    { "<F9>", "<Cmd>YankyRingHistory<cr>", desc = "Yanky" },
    { "<M-=>", function() font.adjust(1) end, desc = "Increase Font" },
    { "<M-->", function() font.adjust(-1) end, desc = "Decrease Font" },
    { "<M-[>", function() font.cycleFont(-1) end, desc = "Previous Font" },
    { "<M-]>", function() font.cycleFont(1) end, desc = "Next Font" },
  }
  wk.add(mappings)

  mappings = {
    { "g", group = "LSP nav" },
    { "g.", "<cmd>Lspsaga code_action<cr>", desc = "code actions" },
    { "g/", tele.lsp_document_symbols, desc = "document symbols" },
    { "g;", tele.lsp_references, desc = "references" },
    { "g=", vim.lsp.buf.format, desc = "format" },
    { "ga", "<cmd>Telescope aerial<cr>", desc = "anything" },
    { "gd", tele.lsp_definitions, desc = "definitions" },
    { "gl", "<cmd>Lspsaga finder<cr>", desc = "lsp finder" },
    { "gr", "<cmd>Lspsaga rename<cr>", desc = "rename" },
    { "gt", tele.lsp_workspace_symbols, desc = "workspace symbols" },
    { "g[", "<cmd>Lspsaga diagnostic_jump_prev<cr>", desc = "prev problem" },
    { "g]", "<cmd>Lspsaga diagnostic_jump_next<cr>", desc = "next problem" },
    { "gw", tele.diagnostics, desc = "diagnostics" },
    { "gk", function() require("refactoring").select_refactor() end, desc = "refactor", mode = { "x", "n" } },
  }
  wk.add(mappings)
  -- keymap("n", "<F2>", "<cmd>Lspsaga rename<CR>", { silent = true })
  vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true, desc = "Hover docs" })
  vim.notify("Mappings loaded", vim.log.levels.INFO)
end
return M
