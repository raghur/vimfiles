local M = {}
M.config = function()
  require("mini.comment").setup()
  require("mini.pairs").setup()
  require("mini.align").setup()
  require("mini.ai").setup()
  require("mini.misc").setup({
    make_global = {'setup_auto_root', 'put', 'put_text'}
  })
  require("mini.surround").setup({
    mappings = {
          add = 'ys', -- Add surrounding in Normal and Visual modes
          delete = 'ds', -- Delete surrounding
          find = '', -- Find surrounding (to the right)
          find_left = '', -- Find surrounding (to the left)
          highlight = 'hs', -- Highlight surrounding
          replace = 'cs', -- Change surrounding
          update_n_lines = '', -- Update `n_lines`

          suffix_last = '', -- Suffix to search with "prev" method
          suffix_next = '', -- Suffix to search with "next" method
        },
    n_lines = 100,
    search_method = 'cover_or_next'
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
---@diagnostic disable-next-line: undefined-global
  MiniMisc.setup_auto_root()
  Info('configured mini.nvim')

end
return M
