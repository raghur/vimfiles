
local config = require("raghu").configurePlugin
return {
  {
      "rachartier/tiny-inline-diagnostic.nvim",
      event = "VeryLazy",
      priority = 1000,
      opts = {},
  },
  {
    "mason-org/mason-lspconfig.nvim",
    lazy = true, -- loaded by nvim-lspconfig
    dependencies = {
      { "mason-org/mason.nvim", cmd = "Mason", opts = {}},
      { "WhoIsSethDaniel/mason-tool-installer.nvim", config = config },
    },
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "snacks.nvim", words = { "Snacks" } },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      -- load blink first so its capabilities are registered before servers start
      {'saghen/blink.cmp'},
      {'mason-org/mason-lspconfig.nvim'},
    },
    config = config
  },
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    cmd = "Lspsaga",
    dependencies = {
      { "onsails/lspkind-nvim" },
      { "nvim-treesitter/nvim-treesitter" },
    },
    config = config
  },
}
