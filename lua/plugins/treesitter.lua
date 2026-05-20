local myconfig = require("raghu")
return {
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter",
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


