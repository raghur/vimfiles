
require 'settings'
require 'commands'
require 'mappings'
dbg, info=vim.fn['utils#dbg'], vim.fn['utils#info']
Dbg, Info = dbg, info
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

require('mini.files').setup()
require('mini.jump').setup()
require('orgmode').setup_ts_grammar()
require('null-ls').setup()
require('lualine').setup()
require('leap').add_default_mappings()
require('mini.indentscope').setup({
    symbol = '│',
    mappings = {
        goto_top='git',
        goto_bottom='gib'
    },
    options = {
        try_as_border = true -- let's you stay on func header and select body as scope
    }

})
    -- Treesitter configuration
require('nvim-treesitter.configs').setup {
    ensure_installed = {'org', 'yaml', 'json', 'bash', 'cpp', 'c_sharp',
        'dockerfile', 'dot',  'gitcommit', 'gitattributes',
        'gitcommit', 'graphql', 'hcl', 'javascript', 'lua', 'markdown', 'vim', 'make', 'cmake',
        'typescript'
    },
    -- Or run :TSUpdate org
    -- If TS highlights are not enabled at all, or disabled via `disable` prop,
    -- highlighting will fallback to default Vim syntax highlighting
    highlight = {
        enable = true,
        -- Required for spellcheck, some LaTex highlights and
        -- code block highlights that do not have ts grammar
        additional_vim_regex_highlighting = {'org'},
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "g<CR>",
            node_incremental = "q",
            scope_incremental = "<CR>",
            node_decremental = "<BS>",
        },
    },
    indent = {
        enable = true
    }
}

require('aerial').setup({
    -- optionally use on_attach to set keymaps when aerial has attached to a buffer
    on_attach = function(bufnr)
    -- Jump forwards/backwards with '{' and '}'
    vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', {buffer = bufnr})
    vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', {buffer = bufnr})
    end
})

require('orgmode').setup({
    org_agenda_files = {'~/Sync/org/*'},
    org_default_notes_file = '~/Sync/todo.org',
    org_todo_keywords = {'TODO', 'BLOCKED', '|', 'DONE'},
    mappings = {
        prefix = ","
    }
})

info('sourced init.lua')
