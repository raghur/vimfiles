local myconfig = require("raghu")
return {
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = function()
          vim.cmd("TSUpdate")
        end,
        config = myconfig.configurePlugin,
      },
    },
  },
  {

    'Wansmer/treesj',
    keys = {
      '<space>m',
      '<space>j',
      '<space>s',
    },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('treesj').setup({--[[ your config ]]})
    end,
  }
}


