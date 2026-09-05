local M = {}
M.config = function()
  require("mini.comment").setup()
  require("mini.pairs").setup()
  require("mini.align").setup()

  local function copy_visual_mapping(from_lhs, to_lhs)
    local mapping = vim.fn.maparg(from_lhs, "x", false, true)
    local rhs = mapping.callback or mapping.rhs
    assert(rhs, ("Visual mapping %s is unavailable"):format(from_lhs))
    vim.keymap.set("x", to_lhs, rhs, { desc = mapping.desc })
  end

  copy_visual_mapping("an", "<Tab>")
  copy_visual_mapping("in", "<BS>")
  copy_visual_mapping("]N", "<M-j>")
  copy_visual_mapping("[N", "<M-k>")

  require("mini.ai").setup({
    mappings = {
      around_next = "aN",
      inside_next = "iN",
      around_last = "aL",
      inside_last = "iL",
    },
  })
  require("mini.misc").setup({
    make_global = {'setup_auto_root', 'put', 'put_text'}
  })
  require("mini.surround").setup({
    mappings = {
          add = 'sa', -- Add surrounding in Normal and Visual modes
          delete = 'sd', -- Delete surrounding
          find = 'sf', -- Find surrounding (to the right)
          find_left = 'sF', -- Find surrounding (to the left)
          highlight = 'sh', -- Highlight surrounding
          replace = 'sr', -- Change surrounding
          update_n_lines = '', -- Update `n_lines`

          suffix_last = '', -- Suffix to search with ="prev"= method
          suffix_next = '', -- Suffix to search with "next" method
        },
    n_lines = 100,
    search_method = 'cover_or_next'
  })

  local wk = require("which-key")
  wk.add({
    -- Example mapping for mini.surround
    { "sa", desc = "Add surrounding" },
    { "sd", desc = "Delete surrounding" },
    { "sf", desc = "Find surrounding forward" },
    { "sF", desc = "Find surrounding back" },
    { "sr", desc = "Replace surrounding" },
  })

  -- require("mini.indentscope").setup({
  --   symbol = "│",
  --   mappings = {
  --     goto_top = "git",
  --     goto_bottom = "gib",
  --   },
  --   options = {
  --     try_as_border = true,     -- let's you stay on func header and select body as scope
  --   },
  -- })
---@diagnostic disable-next-line: undefined-global
  MiniMisc.setup_auto_root()
  Info('configured mini.nvim')

end
return M
