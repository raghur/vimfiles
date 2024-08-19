local M = {}

M.config = function()
  local actions = require('telescope.actions')
  require('telescope').setup {
    extensions = {
      ["ui-select"] = {
        require("telescope.themes").get_dropdown { -- even more opts
        }
      }
    },
    pickers = {
      live_grep = {
        additional_args = function(opts)
          return { "--hidden" }
        end
      }
    },
    defaults =  require("telescope.themes").get_dropdown({
      -- layout_strategy = 'cursor',
      file_ignore_patterns = { 'node_modules/', '.git/', '.npm/'},
      mappings = {
        i = {
          ["<esc>"] = actions.close,
          ["<C-h>"] = "which_key"
        }
      }
    })
  }
  require('telescope').load_extension('fzf')
  require('telescope').load_extension('recent_files')
  require('telescope').load_extension('aerial')
  require('telescope').load_extension('ui-select')
  Info('sourced', vim.fn.expand('<sfile>'))
end
return M
