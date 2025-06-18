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

" terminal mode esc
tnoremap <Esc> <C-\><C-n>

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
  local snacks = require("snacks")

  local mappings = {
    { "<leader>f", group = "+Files"},
    { "<leader>ff",snacks.picker.files, desc = "Find relative"},
    { "<leader>fp",snacks.picker.zoxide, desc = "Find files at"},
    { "<leader>fe", ":edit <C-R>=fnamemodify(@%, ':p:h')<CR>/", desc = "edit file" },
    { "<leader>r", snacks.picker.recent, desc = "Find recent" },
    { "<leader>b", snacks.picker.buffers, desc = "Buffers" },
    { "<leader>g", snacks.picker.git_files, desc = "Git files" },
    { "<leader>/", snacks.picker.grep, desc = "Grep" },
    { "<leader><space>",function() snacks.picker.smart({ hidden=true
    }) end, desc = "Find relative"},
    { "<leader>e", ":vsp|Neorg index<CR>", desc = "Scratchpad Notes" },
    { "<leader>sk", snacks.picker.keymaps, desc = "Keymaps" },
    { "<leader>sc", snacks.picker.commands, desc = "Commands" },


    -- git
    { "<leader>G", function() snacks.lazygit.open() end, desc = "LazyGit" },
    { "<leader>gb", function() snacks.picker.git_branches() end, desc = "Git Branches" },
    { "<leader>gl", function() snacks.picker.git_log() end, desc = "Git Log" },
    { "<leader>gL", function() snacks.picker.git_log_line() end, desc = "Git Log Line" },
    { "<leader>gs", function() snacks.picker.git_status() end, desc = "Git Status" },
    { "<leader>gS", function() snacks.picker.git_stash() end, desc = "Git Stash" },
    { "<leader>gd", function() snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
    { "<leader>gf", function() snacks.picker.git_log_file() end, desc = "Git Log File" },
    { "<leader>g/", function() snacks.picker.git_grep() end, desc = "Git Log File" },
  }
  wk.add(mappings)

  mappings = {
    { "<leader>c", function() snacks.picker.colorschemes() end, desc = "Colors" },
    { "<leader>:", snacks.picker.commands, desc = "Commands" },
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
    { "<leader>in",  snacks.notifier.show_history , desc = "Notification history" },
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
    { "<F1>", snacks.explorer.reveal, desc = "Reveal in file explorer" },
    { "<leader><F1>", snacks.explorer.open, desc = "Toggle file explorer" },
    { "<F3>", ":redir @a<CR>:g//<CR>:redir END<CR>:new<CR>:put! a<CR>", desc = "Copy last search to buffer" },
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
    { "g=", vim.lsp.buf.format, desc = "format" },
    { "g[", "<cmd>Lspsaga diagnostic_jump_prev<cr>", desc = "prev problem" },
    { "g]", "<cmd>Lspsaga diagnostic_jump_next<cr>", desc = "next problem" },
    -- { "ga", "<cmd>Telescope aerial<cr>", desc = "anything" },
    { "gc", "<cmd>Lspsaga rename<cr>", desc = "rename" },
    { "gd", snacks.picker.lsp_definitions, desc = "definitions" },
    -- { "gk", function() require("refactoring").select_refactor() end, desc = "refactor", mode = { "x", "n" } },
    { "gk", vim.diagnostic.open_float, desc = "show line diagnostic"  },
    { "gl", "<cmd>Lspsaga finder<cr>", desc = "lsp finder" },
    { "gp", snacks.picker.diagnostics, desc = "diagnostics" },
    { "gP", snacks.picker.diagnostics_buffer, desc = "diagnostics" },
    { "gr", snacks.picker.lsp_references, desc = "references" },
    { "gs", snacks.picker.lsp_symbols, desc = "document symbols" },
    { "gt", snacks.picker.lsp_workspace_symbols, desc = "workspace symbols" },
  }
  wk.add(mappings)
  -- keymap("n", "<F2>", "<cmd>Lspsaga rename<CR>", { silent = true })
  vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true, desc = "Hover docs" })
  vim.notify("Mappings loaded", vim.log.levels.INFO)
end
return M
