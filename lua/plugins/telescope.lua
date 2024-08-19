local myconfig = require("raghu")
return {

  {
    "smartpde/telescope-recent-files",
    dependencies = {
      {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
      }
    }
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
      }
    }
  },
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    cmd = "Telescope",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make"
      },
      { "reaz1995/telescope-vim-bookmarks.nvim" },
      { "stevearc/aerial.nvim", config = myconfig.configurePlugin },
      { "nvim-lua/plenary.nvim" },
    },
    config = myconfig.configurePlugin
  }
}
