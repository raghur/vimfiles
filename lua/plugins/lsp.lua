
local config = require("raghu").configurePlugin
return {
  { "sheerun/vim-polyglot", lazy = true },
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      {"mason-org/mason.nvim", opts = {}},
      "nvimtools/none-ls.nvim",
    },
    config = config
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      { "mason-org/mason.nvim", opts = {}},
      { "neovim/nvim-lspconfig" },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {'saghen/blink.cmp'},
      {'folke/neodev.nvim'},
    },
    config = config
  },
  {
    "nvimdev/lspsaga.nvim",
    dependencies = {
      { "onsails/lspkind-nvim" },
      { "nvim-treesitter/nvim-treesitter" },
    },
    config = config
  },
}
