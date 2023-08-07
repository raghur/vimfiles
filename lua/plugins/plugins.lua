local keymap = vim.keymap.set
local myconfig = require("raghu")
return {
  {
    "MattesGroeger/vim-bookmarks",
    config = myconfig.configurePlugin,
  },
  {
    "raghur/vim-helpnav",
    ft = "help",
  },
  { "tpope/vim-repeat" },
  { "jiangmiao/auto-pairs" },
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
  },
  { "gregsexton/MatchTag" },
  { "tpope/vim-commentary" },

  { "flazz/vim-colorschemes" },
  { "sheerun/vim-polyglot", lazy = true },
  { "vim-scripts/matchit.zip" },
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
  { "tpope/vim-surround" },
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
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    cmd = "Telescope",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
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
    event = "VeryLazy",
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
    config = function()
      require("leap").add_default_mappings()
    end,
  },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

  { "gbprod/yanky.nvim" , config = myconfig.configurePlugin},
}