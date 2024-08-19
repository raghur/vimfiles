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
    'crusj/bookmarks.nvim',
    keys = {
      { "<tab><tab>", mode = { "n" }, desc = "Bookmarks" },
    },
    branch = 'main',
    dependencies = { 'nvim-web-devicons' },
    config = function()
      require("bookmarks").setup({
        keymap = {
          add = '<F2>',
          close = '<Esc>'
        }
      })
      require("telescope").load_extension("bookmarks")
    end
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
  { "wellle/targets.vim" },
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
    "t9md/vim-choosewin",
    keys = {
      {"-", "<Plug>(choosewin)", desc = "Choose Window", mode="n"}
    },
    config = function()
      vim.g.choosewin_overlay_enable = 1
    end,
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
}
