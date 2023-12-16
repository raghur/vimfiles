local M = {}
M.config = function()
  require("mini.files").setup()
  -- require("mini.jump").setup()
  require("mini.comment").setup()
  require("mini.pairs").setup()
  require("mini.surround").setup({
    mappings = {
          add = 'sa', -- Add surrounding in Normal and Visual modes
          delete = 'sd', -- Delete surrounding
          find = 'sf', -- Find surrounding (to the right)
          find_left = 'sF', -- Find surrounding (to the left)
          highlight = 'sh', -- Highlight surrounding
          replace = 'sr', -- Replace surrounding
          update_n_lines = 'sn', -- Update `n_lines`

          suffix_last = 'l', -- Suffix to search with "prev" method
          suffix_next = 'n', -- Suffix to search with "next" method
        },
  })

  require("mini.indentscope").setup({
    symbol = "│",
    mappings = {
      goto_top = "git",
      goto_bottom = "gib",
    },
    options = {
      try_as_border = true,     -- let's you stay on func header and select body as scope
    },
  })
  Info('configured mini.nvim')
end
return M
