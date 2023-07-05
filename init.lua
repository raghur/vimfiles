
require 'settings'
require 'commands'
require 'mappings'
local utils = require('raghu.utils')
Info, Dbg = utils.info, utils.dbg
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins", {})


-- require('aerial').setup({
--     -- optionally use on_attach to set keymaps when aerial has attached to a buffer
--     on_attach = function(bufnr)
--     -- Jump forwards/backwards with '{' and '}'
--     vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', {buffer = bufnr})
--     vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', {buffer = bufnr})
--     end
-- })

require('orgmode').setup({
    org_agenda_files = {'~/Sync/org/*'},
    org_default_notes_file = '~/Sync/todo.org',
    org_todo_keywords = {'TODO', 'BLOCKED', '|', 'DONE'},
    mappings = {
        prefix = ","
    }
})

Info('sourced init.lua')
