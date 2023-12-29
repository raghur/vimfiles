local keymap = vim.keymap.set
local myconfig = require("raghu")
return {
  {
    "raghur/vim-helpnav",
    ft = "help",
  },
  { "tpope/vim-repeat" },
  { "andymass/vim-matchup",
  },
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
  },
  {
    'crusj/bookmarks.nvim',
    keys = {
      { "<tab><tab>", mode = { "n" } },
    },
    branch = 'main',
    dependencies = { 'nvim-web-devicons' },
    config = function()
      require("bookmarks").setup({
        keymap = {
          add = '<F2>'
        }
      })
      require("telescope").load_extension("bookmarks")
    end
  },
  { "flazz/vim-colorschemes" },
  { "sheerun/vim-polyglot", lazy = true },
  { "tpope/vim-ragtag" },
  { "wellle/targets.vim" },
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
  { "rstacruz/sparkup", rtp = "vim", enabled = false },

  {
    "airblade/vim-rooter",
    config = function(plugin, opts)
      vim.g.rooter_silent_chdir = 1
    end,
  },
  {
    "xolox/vim-session",
    config = myconfig.configurePlugin,
    dependencies = {
      { "xolox/vim-misc" },
    },
    -- cmd = {'OpenSession', 'SaveSession'}
  },
  {
    "alvan/vim-closetag",
    config = function(plugin, opts)
      vim.g.closetag_filenames = "*.html,*.xhtml,*.xml,*.htm,*.vue,*.jsx"
      vim.g.closetag_xhtml_filenames = "*.xhtml,*.jsx,*.vue"
    end,
  },
  {
    "raghur/vim-ghost",
    build = function()
      vim.cmd("GhostInstall")
    end,
    config = function()
      vim.g.ghost_autostart = 1
    end,
  },
  {
    "t9md/vim-choosewin",
    keys = "-",
    config = function()
      keymap("n", "-", "<Plug>(choosewin)", { noremap = true })
      vim.g.choosewin_overlay_enable = 1
    end,
  },

  {
    "nvim-telescope/telescope-ui-select.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        tag = "0.1.5",
      }
    }
  },
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    tag = "0.1.5",
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
  },
  {
    "nvim-orgmode/orgmode",
    ft = "org",
    config = myconfig.configurePlugin
  },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  {
    "hrsh7th/nvim-cmp",
    event = {
      "InsertEnter",
      "CmdlineEnter"
    },
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-emoji" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-cmdline" },
      {
        "saadparwaiz1/cmp_luasnip",
        dependencies = {
          {
            "L3MON4D3/LuaSnip",
            -- follow latest release and install jsregexp.
            version = "v1.*",
            build = "make install_jsregexp",
            config = function ()
              require("luasnip.loaders.from_vscode").lazy_load({paths = {vim.fn.stdpath('config') .. "./luasnips"}})
            end
          },
        },
      },
    },
    config = myconfig.configurePlugin,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = true,
  },
  { "folke/tokyonight.nvim", lazy = true },
  {
    "echasnovski/mini.nvim",
    version='*',
    config = myconfig.configurePlugin,
  },
  { "neovim/nvim-lspconfig",
    config = myconfig.configurePlugin},
  { "nvim-tree/nvim-web-devicons", lazy = true },
  {
    "nvimdev/lspsaga.nvim",
    dependencies = {
      { "onsails/lspkind-nvim" },
    },
    branch = "main",
    config = myconfig.configurePlugin
  },
  {
    "ggandor/leap.nvim",
    keys= {
      { "f", '<Plug>(leap-forward-to)', "nxo", desc='Leap forward'},
      { "F", '<Plug>(leap-backward-to)', "nxo", desc='Leap backward'}
    },
    config = function()
    end,
  },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

  { "gbprod/yanky.nvim" , config = myconfig.configurePlugin},
}
