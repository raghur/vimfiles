
local key=vim.keymap.set
-- for Browse the input history
key('c', '<c-n>', '<down>', { desc = 'Next command history' })
key('c', '<c-p>', '<up>', { desc = 'Previous command history' })

-- disable arrow keys
key({ 'n', 'i', 'v' }, '<Up>',    '<Nop>', { desc = 'Disable Up arrow key' })
key({ 'n', 'i', 'v' }, '<Down>',  '<Nop>', { desc = 'Disable Down arrow key' })
key({ 'n', 'i', 'v' }, '<Left>',  '<Nop>', { desc = 'Disable Left arrow key' })
key({ 'n', 'i', 'v' }, '<Right>', '<Nop>', { desc = 'Disable Right arrow key' })

key('i', 'jk', '<esc>', { desc = 'Escape with jk' })
key('v', '>',  '>gv',   { desc = 'Re-select after indent' })
key('v', '<',  '<gv',   { desc = 'Re-select after unindent' })
key('n', '0',  '^',     { desc = 'Go to first non-blank character' })
key('n', '^',  '0',     { desc = 'Go to beginning of line' })

-- terminal mode esc (uncomment if you want this mapping)
key('t', '<Esc>', "<C-\\><C-n>", { desc = 'Escape in terminal mode' })

-- -- Move by screen lines
key('n', 'j',           'gj',    { desc = 'Move down by screen line' })
key('n', 'k',           'gk',    { desc = 'Move up by screen line' })

key('n', '<backspace>', '<C-o>', { desc = 'Go back in jump list' })
key('n', '<tab>',       '<C-i>', { desc = 'Go forward in jump list' })

-- open help in a vert split to the right
vim.cmd([[cabbrev h vert bo h]])
vim.cmd([[cabbrev map verb map<space>]])
vim.cmd([[cabbrev s/ s/\v]]) -- For command line abbreviations, vim.cmd is still often used

-- CTRL-U in insert mode deletes a lot. Use CTRL-G u to first break undo,
-- so that you can undo CTRL-U after inserting a line break.
key('i', '<C-U>',      '<C-G>u<C-U>', { desc = 'Break undo before C-U' })

key('i', '<S-Insert>', '<c-r>+',      { desc = 'Paste from system clipboard (insert mode)' })
key('c', '<S-Insert>', '<c-r>+',      { desc = 'Paste from system clipboard (command mode)' })

-- Paste sanity
key('n', 'c',          '"_c',         { desc = 'Change without yanking' })
key('n', 'C',          '"_C',         { desc = 'Change to end of line without yanking' })

-- Search and replace related mappings
key('n', '/',         '/\\v',                              { desc = 'Start search with very magic' })
key('c', '%s/',       '%s/\\v',                            { desc = 'Start substitute with very magic' })
key('v', '%',         '<space>%',                          { desc = 'Visual mode search for current selection' })
key('v', '*', 'y:let @/=@"<cr>:set hlsearch<cr>n', { desc = 'Search for visual selection', silent = true })

-- Center on screen after moving to next/prev match
key('n', 'n',         'nzz',                               { desc = 'Next search result and center' })
key('n', 'N',         'Nzz',                               { desc = 'Previous search result and center' })

-- -- Move lines
-- key('n', '<A-j>',     ':m+<CR>==',                         { desc = 'Move line down (Normal)' })
-- key('n', '<A-k>',     ':m-2<CR>==',                        { desc = 'Move line up (Normal)' })
-- key('i', '<A-j>',     '<Esc>:m+<CR>==gi',                  { desc = 'Move line down (Insert)' })
-- key('i', '<A-k>',     '<Esc>:m-2<CR>==gi',                 { desc = 'Move line up (Insert)' })
-- key('v', '<A-j>',     ':m\'>+<CR>gv=gv',                   { desc = 'Move selected lines down (Visual)' })
-- key('v', '<A-k>',     ':m-2<CR>gv=gv',                     { desc = 'Move selected lines up (Visual)' })

local wk = require("which-key")
local utils = require("raghu.utils")
local font = require("raghu.font")
local snacks = require("snacks")

local mappings = {
  { "<leader>f",       group = "+Files" },
  { "<leader>ff",      snacks.picker.files,                                   desc = "Find relative" },
  { "<leader>fe",      ":edit <C-R>=fnamemodify(@%, ':p:h')<CR>/",            desc = "edit file" },
  { "<leader>r",       snacks.picker.recent,                                  desc = "Find recent" },
  { "<leader>b",       snacks.picker.buffers,                                 desc = "Buffers" },
  { "<leader>/",       snacks.picker.grep,                                    desc = "Grep" },
  { "<leader>k",       snacks.picker.keymaps,                                 desc = "Keymaps" },
  { "<leader><space>", function() snacks.picker.smart({ hidden = true }) end, desc = "Find relative" },
  { "<leader>e",       ":vsp|Neorg index<CR>",                                desc = "Scratchpad Notes" },

  -- terminal apps
  { "t",       group = "Terminal apps" },
  { "tg",      function() snacks.lazygit.open() end,                  desc = "LazyGit" },
  { "tt", function() snacks.terminal.toggle(nil, {
        win = {
          style = "terminal",
          position = "right",
        }
      })
    end,
    desc = "Open terminal" },

  -- git
  { "<leader>g",  group = "Git" },
  { "<leader>gg", snacks.picker.git_files,                     desc = "Git files" },
  { "<leader>gb", function() snacks.picker.git_branches() end, desc = "Git Branches" },
  { "<leader>gl", function() snacks.picker.git_log() end,      desc = "Git Log" },
  { "<leader>gL", function() snacks.picker.git_log_line() end, desc = "Git Log Line" },
  { "<leader>gs", function() snacks.picker.git_status() end,   desc = "Git Status" },
  { "<leader>gS", function() snacks.picker.git_stash() end,    desc = "Git Stash" },
  { "<leader>gd", function() snacks.picker.git_diff() end,     desc = "Git Diff (Hunks)" },
  { "<leader>gf", function() snacks.picker.git_log_file() end, desc = "Git Log File" },
  { "<leader>g/", function() snacks.picker.git_grep() end,     desc = "Git Log File" },
}
wk.add(mappings)
local preferredColors = function()
    local items = {}
    for idx,name in ipairs(vim.g.colors) do
        local it = {
            name,
            idx = idx,
            text = name
        }
        items[idx] = it
    end

  return Snacks.picker({
    items = items,
    format = function(item)
      local ret = {}
      ret[1] = {item.text, 'SnacksPickerLabel'}
      ret[2] = {item.text, 'SnacksPickerComment'}
      return ret
        end,
    confirm = function(picker, item)
      picker:close()
      vim.cmd('colors '.. item.text)
    end
  })
end
mappings = {
  { "<leader>c", preferredColors,   desc = "Colors" },
  { "<leader>:", snacks.picker.commands,                        desc = "Commands" },
  { "<leader>1", "<cmd>on<cr>",                                 desc = "Close others" },
  { "<leader>a", ":b#<cr>",                                     desc = "Last file" },
  { "<leader>d", ":bd!<cr>",                                    desc = "Close buffer" },
  { "<leader>h", ":noh<cr><c-l>",                               desc = "no highlight" },
  { "<leader>q", ":qall<cr>",                                   desc = "Quit" },
  { "<leader>w", ":w<cr>",                                      desc = "Write" },
  { "<leader>z", ":call utils#toggleZoom()<cr>",                desc = "Zoom" },
  { 'zR',        function() require('ufo').openAllFolds() end,  desc = "Open all folds" },
  { 'zM',        function() require('ufo').closeAllFolds() end, desc = "Close all folds" }
}
wk.add(mappings)

mappings = {
  { "<leader>i",   group = "+Config" },
  { "<leader>im",  function() utils.editConfig("mappings.lua") end, desc = "Mappings" },
  { "<leader>ir",  utils.reload,                                    desc = "Reload settings and mappings" },
  { "<leader>ii",  "<Cmd>ed $MYVIMRC<cr>",                          desc = "Edit init.lua" },
  { "<leader>is",  function() utils.editConfig("settings.lua") end, desc = "Settings" },
  { "<leader>ip",  function() utils.editConfig("plugins.lua") end,  desc = "Plugins" },
  { "<leader>ic",  function() utils.editConfigFolder("raghu") end,  desc = "Plugin Config Folder" },
  { "<leader>i,",  "<cmd>source %<cr>",                             desc = "Source file" },
  { "<leader>il",  group = "+Logging" },
  { "<leader>ild", function() utils.loglvl("DBG") end,              desc = "Log - Debug" },
  { "<leader>ili", function() utils.loglvl("INFO") end,             desc = "Log - INFO" },
  { "<leader>ilx", function() utils.loglvl("DISABLE") end,          desc = "Log - disable" },
  { "<leader>in",  snacks.notifier.show_history,                    desc = "Notification history" },
  {
    "<leader>iv",
    function()
      -- This helper captures the visual selection text
      local _, ls, cs = unpack(vim.fn.getpos("v"))
      local _, le, ce = unpack(vim.fn.getpos("."))
      local lines = vim.api.nvim_buf_get_text(0, ls - 1, cs - 1, le - 1, ce, {})
      local expr = table.concat(lines, "\n")

      local chunk, compile_error = loadstring("return " .. expr)
      if not chunk then
        vim.notify(compile_error, vim.log.levels.ERROR)
        return
      end

      local success, result = pcall(chunk)
      if success then
        vim.print(result)
      else
        vim.notify(result, vim.log.levels.ERROR)
      end
    end,
    mode = "v",
    desc = "Inspect Selection (Visual)",
  },
}
wk.add(mappings)

local sourceRange = function()
    local visual_line = vim.fn.getpos("v")[2]
    local cursor_line = vim.fn.line(".")
    local start = math.min(visual_line, cursor_line)
    local fin = math.max(visual_line, cursor_line)
    local cmd = start .. "," .. fin .. "so"
    print("Sourced: " .. cmd)
    vim.cmd(cmd)
end
mappings = {
  { "<leader>i",  group = "+Config", mode = "v" },
  { "<leader>i,", sourceRange,       desc = "Source lines", mode = "v" },
}
wk.add(mappings)

wk.add({
  { "S", ":<C-U>lua MiniSurround.add('visual')<cr>", desc = "Surround", mode = "xn" },
})

mappings = {
  { "<S-insert>", '"0p', desc = "paste",          mode = "v" },
  { "p",          '"0p', desc = "paste",          mode = "v" },
  { "P",          '"0P', desc = "paste before",   mode = "v" },
  { "<leader>p",  '"0p', desc = 'Paste "0' },
  { "<leader>P",  '"0P', desc = 'Paste "0 before' },
}
wk.add(mappings)
mappings = {
  { "<F1>",         snacks.explorer.reveal,                                   desc = "Reveal in file explorer" },
  { "<leader><F1>", snacks.explorer.open,                                     desc = "Toggle file explorer" },
  { "<F3>",         ":redir @a<CR>:g//<CR>:redir END<CR>:new<CR>:put! a<CR>", desc = "Copy last search to buffer" },
  { "<M-=>",        function() font.adjust(1) end,                            desc = "Increase Font" },
  { "<M-->",        function() font.adjust(-1) end,                           desc = "Decrease Font" },
  { "<M-[>",        function() font.cycleFont(-1) end,                        desc = "Previous Font" },
  { "<M-]>",        function() font.cycleFont(1) end,                         desc = "Next Font" },
}
wk.add(mappings)
local function format()
  require("conform").format({
    async = true,
    lsp_format = "fallback",
  })
end

mappings = {
  { "g",  group = "LSP nav" },
  { "g.", "<cmd>Lspsaga code_action<cr>",          desc = "code actions" },
  { "gq", format,                                 desc = "format" },
  { "g[", "<cmd>Lspsaga diagnostic_jump_prev<cr>", desc = "prev problem" },
  { "g]e", function() require"lspsaga.diagnostic":goto_next({severity = vim.diagnostic.severity.ERROR}) end, desc = "next error" },
  { "g]", "<cmd>Lspsaga diagnostic_jump_next<cr>", desc = "next problem" },
  { "gc", "<cmd>Lspsaga rename<cr>",               desc = "rename" },
  { "gd", snacks.picker.lsp_definitions,           desc = "definitions" },
  -- { "gk", function() require("refactoring").select_refactor() end, desc = "refactor", mode = { "x", "n" } },
  { "gk", vim.diagnostic.open_float,               desc = "show line diagnostic" },
  { "gl", "<cmd>Lspsaga finder<cr>",               desc = "lsp finder" },
  { "go", "<cmd>Lspsaga outline<cr>",              desc = "outline" },
  { "gpd", snacks.picker.diagnostics,               desc = "Diagnostics" },
  { "gpp", snacks.picker.zoxide,                    desc = "Find files at" },
  { "gph", snacks.picker.help,               desc = "Help topics" },
  { "gpc", snacks.picker.commands,               desc = "Commands" },
  { "gpC", snacks.picker.colorschemes,               desc = "Colorschemes" },
  { "gpk", snacks.picker.keymaps,               desc = "Commands" },
  { "<C-p>", snacks.picker.pickers,                   desc = "Select picker" },
  { "gr", snacks.picker.lsp_references,            desc = "references" },
  { "gs", snacks.picker.lsp_symbols,               desc = "document symbols" },
  { "gt", snacks.picker.lsp_workspace_symbols,     desc = "workspace symbols" },
}
wk.add(mappings)
-- keymap("n", "<F2>", "<cmd>Lspsaga rename<CR>", { silent = true })
vim.keymap.set("n", "K", vim.lsp.buf.signature_help, { silent = true, desc = "Signature help" })
vim.keymap.set("i", "<C-K>",  vim.lsp.buf.signature_help, { silent = true, desc = "Hover docs" })
vim.notify("Mappings loaded", vim.log.levels.INFO)
