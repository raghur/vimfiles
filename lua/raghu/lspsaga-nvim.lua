local M = {}
local lspsaga = require 'lspsaga'

M.config = function()
  -- use default config
  lspsaga.setup({
    --- config reference here - no other readme seems to be available
    --- https://github.com/nvimdev/lspsaga.nvim/issues/647#issuecomment-1381916623
    rename = {
      keys = {
        quit = "<Esc>"
      }
    },

    finder = {
      default = "def+ref+imp+tyd",
      methods = {
        tyd = "textDocument/typeDefinition"
      },
      keys = {
        toggle_or_open = "<CR>",
        vsplit = "v",
        split = "s",
        tabe = "t",
        quit = "<Esc>",
        scroll_down = "<C-f>",
        scroll_up = "<C-b>", -- quit can be a table
      }
    },
    code_action = {
      num_shortcut = true,
      keys =  {
        quit = "<Esc>",
        exec = "<CR>",
      }
    },
  })
end
return M
