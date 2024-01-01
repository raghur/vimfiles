local M = {}

M.config = function ()
  -- Treesitter configuration
  require('nvim-treesitter.configs').setup ({
    sync_install = false,
    auto_install = true,
    ignore_install = {},
    ensure_installed = {
      'org',
      'yaml',
      'json',
      'bash',
      'cpp',
      'c_sharp',
      'dockerfile',
      'dot',
      'gitcommit',
      'gitattributes',
      'gitcommit',
      'graphql',
      'hcl',
      'javascript',
      'lua',
      'markdown',
      'vim',
      'make',
      'cmake',
      'typescript',
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
        node_incremental = "<tab>",
        node_decremental = "<BS>",
        scope_incremental = "<CR>",
      },
    },
    indent = { enable = true }
  })
end

return M
