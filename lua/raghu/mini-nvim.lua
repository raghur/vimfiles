local M = {}
M.config = function()
  require("mini.files").setup()
  require("mini.jump").setup()

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
