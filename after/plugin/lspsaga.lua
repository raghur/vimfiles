local keymap = vim.keymap.set
local lspsaga = require 'lspsaga'

-- use default config
lspsaga.setup({
  rename_action_quit = "<C-c>",
  rename_in_select = false,
  finder_action_keys = {
    open = "<CR>",
    vsplit = "s",
    split = "i",
    tabe = "t",
    quit = "q",
    scroll_down = "<C-f>",
    scroll_up = "<C-b>", -- quit can be a table
  },
  code_action_keys = {
    quit = "<C-c>",
    exec = "<CR>",
  },
})
keymap("n", "gd", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })
keymap("n", "<space>.", "<cmd>Lspsaga code_action<CR>", { silent = true })
keymap("n", "<F2>", "<cmd>Lspsaga rename<CR>", { silent = true })
keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
keymap("n", "g<space>", "<cmd>Lspsaga peek_definition<CR>", { silent = true })
keymap("n","go", "<cmd>Lspsaga outline<CR>",{ silent = true })
-- Show buffer diagnostics
keymap("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>")
keymap("n", "<leader>sw", "<cmd>Lspsaga show_workspace_diagnostics<CR>")
keymap("n", "<leader>]", "<cmd>Lspsaga diagnostic_jump_next<CR>")
keymap("n", "<leader>[", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
-- -- change the lsp symbol kind
-- local kind = require('lspsaga.lspkind')
-- kind[type_number][2] = icon -- see lua/lspsaga/lspkind.lua

---- Options with default value
---- "single" | "double" | "rounded" | "bold" | "plus"
--border_style = "single",
----the range of 0 for fully opaque window (disabled) to 100 for fully
----transparent background. Values between 0-30 are typically most useful.
--saga_winblend = 0,
---- when cursor in saga window you config these to move
--move_in_saga = { prev = '<C-p>',next = '<C-n>'},
---- Error, Warn, Info, Hint
---- use emoji like
---- { "🙀", "😿", "😾", "😺" }
---- or
---- { "😡", "😥", "😤", "😐" }
---- and diagnostic_header can be a function type
---- must return a string and when diagnostic_header
---- is function type it will have a param `entry`
---- entry is a table type has these filed
---- { bufnr, code, col, end_col, end_lnum, lnum, message, severity, source }
--diagnostic_header = { " ", " ", " ", "ﴞ " },
---- show diagnostic source
--show_diagnostic_source = true,
---- add bracket or something with diagnostic source, just have 2 elements
--diagnostic_source_bracket = {},
---- preview lines of lsp_finder and definition preview
--max_preview_lines = 10,
---- use emoji lightbulb in default
--code_action_icon = "💡",
---- if true can press number to execute the codeaction in codeaction window
--code_action_num_shortcut = true,
---- same as nvim-lightbulb but async
--code_action_lightbulb = {
--    enable = true,
--    sign = true,
--    enable_in_insert = true,
--    sign_priority = 20,
--    virtual_text = true,
--},
---- finder icons
--finder_icons = {
--  def = '  ',
--  ref = '諭 ',
--  link = '  ',
--},
---- finder do lsp request timeout
---- if your project big enough or your server very slow
---- you may need to increase this value
--finder_request_timeout = 1500,
--finder_action_keys = {
--    open = "o",
--    vsplit = "s",
--    split = "i",
--    tabe = "t",
--    quit = "q",
--    scroll_down = "<C-f>",
--    scroll_up = "<C-b>", -- quit can be a table
--},
--code_action_keys = {
--    quit = "q",
--    exec = "<CR>",
--},
--rename_action_quit = "<C-c>",
--rename_in_select = true,
--definition_preview_icon = "  ",
---- show symbols in winbar must nightly
--symbol_in_winbar = {
--    in_custom = false,
--    enable = false,
--    separator = ' ',
--    show_file = true,
--    click_support = false,
--},
---- show outline
--show_outline = {
--  win_position = 'right',
--  --set special filetype win that outline window split.like NvimTree neotree
--  -- defx, db_ui
--  win_with = '',
--  win_width = 30,
--  auto_enter = true,
--  auto_preview = true,
--  virt_text = '┃',
--  jump_key = 'o',
--  -- auto refresh when change buffer
--  auto_refresh = true,
--},
---- if you don't use nvim-lspconfig you must pass your server name and
---- the related filetypes into this table
---- like server_filetype_map = { metals = { "sbt", "scala" } }
--server_filetype_map = {},
if vim.env.NVIM_DBG then
  print('sourced ', vim.fn.expand('<sfile>'))
end