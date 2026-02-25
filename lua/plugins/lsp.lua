
local config = require("raghu").configurePlugin
return {
  { "sheerun/vim-polyglot", event = "BufReadPost" },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      { "mason-org/mason.nvim", opts = {}},
      { "WhoIsSethDaniel/mason-tool-installer.nvim"},
      { "neovim/nvim-lspconfig" },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {'saghen/blink.cmp'},
      {'folke/lazydev.nvim'},
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
