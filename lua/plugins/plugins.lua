local myconfig = require("raghu")
return {
  { "tpope/vim-repeat" },
  {
    "mbbill/undotree",
    keys = {
      {"<F5>", "<cmd>UndotreeToggle<cr>", desc = 'Undotree'},
    },
    cmd = "UndotreeToggle",
  },
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release and install jsregexp.
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "v2.*",
    build = "make install_jsregexp",
    config = function ()
      require("luasnip.loaders.from_vscode").lazy_load()
    end
  },
  {
    "sindrets/diffview.nvim",
    keys = {
      {"<leader>gdo", "<cmd>DiffviewOpen<cr>", desc = "Diff - Open"},
      {"<leader>gdd", "<cmd>DiffviewClose<cr>", desc = "Diff - Close"},
      {"<leader>gdh", "<cmd>DiffviewOpen develop..HEAD<cr>", desc = "Diff with base"}
    }

  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter"
  },
  {
    "andymass/vim-matchup",
    event = "BufReadPost",
    init = function()
      vim.g.matchup_matchparen_offscreen = { method = "status" }
      vim.g.matchup_surround_enabled = 1
    end,
  },
  { "rstacruz/sparkup", rtp = "vim", enabled = false },

  {
    "airblade/vim-rooter",
    config = function()
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
    config = function()
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
    's1n7ax/nvim-window-picker',
    keys = {
      {"-", function() require('window-picker').pickWindow() end, desc = "Pick Pane"}
    },
    version = '2.*',
    config = myconfig.configurePlugin,
  },
  {
    'kevinhwang91/nvim-ufo',
    dependencies = {
      {"kevinhwang91/promise-async"},
      { "nvim-treesitter/nvim-treesitter"}
    },
    config = function ()
      vim.o.foldcolumn = 'auto:9'
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep:│,foldclose:]]
      require('ufo').setup({
        provider_selector = function()
          return {'treesitter', 'indent'}
        end
      })
    end
  },
  {
    "nvim-orgmode/orgmode",
    ft = "org",
    config = myconfig.configurePlugin
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = true,
  },
  {
    "echasnovski/mini.nvim",
    version='*',
    config = myconfig.configurePlugin,
  },
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
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
  {
    "gbprod/yanky.nvim",
    config = myconfig.configurePlugin,
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      explorer = {enabled = true},
      picker = {
        win = {
          input = {
            keys = {
              ["<Esc>"] = { "close", mode = { "n", "i" } },
            }
          }
        },
        enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      zen = { enabled = true},
    },
  },
  {
    'nanotee/zoxide.vim'
  },
  {
    "loctvl842/monokai-pro.nvim"
  }
}
