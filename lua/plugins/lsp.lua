
local myconfig = require("raghu")
return {
  { "sheerun/vim-polyglot", lazy = true },
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    config = myconfig.configurePlugin
  },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  {
    "neovim/nvim-lspconfig",
    config = myconfig.configurePlugin
  },
  {
    "nvimdev/lspsaga.nvim",
    dependencies = {
      { "onsails/lspkind-nvim" },
      { "nvim-treesitter/nvim-treesitter" },
    },
    config = myconfig.configurePlugin
  },
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("refactoring").setup()
    end,
  },
}
