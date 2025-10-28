local config = require("raghu").configurePlugin
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
      require("luasnip.loaders.from_snipmate").load({
        paths="./snippets"
      })
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
      vim.o.matchpairs = "(:),{:},[:]"
    end,
  },
  {
    "xolox/vim-session",
    config = config,
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
    config = config,
  },
  {
    'kevinhwang91/nvim-ufo',
    dependencies = {
      {"kevinhwang91/promise-async"},
      { "nvim-treesitter/nvim-treesitter"}
    },
    config = config,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = true,
  },
  {
    "echasnovski/mini.nvim",
    version='*',
    config = config,
  },
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },
  {
    "gbprod/yanky.nvim",
    opts = { },
    dependencies = { "folke/snacks.nvim" },
    keys = {
      { "<C-y>", function() Snacks.picker.yanky() end, mode = { "n", "x", "i" }, desc = "Open Yank History", },
    }
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
      explorer = {
        enabled = true,
        replace_netrw = true,
      },
      picker = {
        win = {
          input = {
            keys = {
              ["<Esc>"] = { "close", mode = { "n", "i" } },
              ["<c-l>"] = { "toggle_focus", mode = { "n", "i" } },
            }
          }
        },
        enabled = true
      },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      zen = { enabled = true},
    },
    config = config,
  },
  { 'nanotee/zoxide.vim' },
  {
    'stevearc/conform.nvim',
    opts = {},
    config = config,
  },
  {
    "nvim-neorg/neorg",
    lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    version = "*", -- Pin Neorg to the latest stable release
    config = true,
    dependencies = {
      "hrsh7th/nvim-cmp",
      -- "benlubas/neorg-interim-ls",
    },
    opts = {
      load = {
        ["core.defaults"] = {},
        ["core.esupports.indent"] = {
          config = {
            format_on_enter = false
          }
        },
        ["core.concealer"] = {},
        ["core.esupports.hop"] = {},
        ["core.itero"] = {},
--         ["external.interim-ls"] = {
-- config = { engine = { cmp_nvim_lsp = "external.lsp-completion" } },
--         },
        ["core.completion"] = {
          config = {
            engine = "nvim-cmp"
          }
        },
        ["core.keybinds"] = {},
        ["core.dirman"] = {
          config = {
            workspaces = {
              notes = "~/Sync/scratch/",
            },
            default_workspace = "notes"
          },
        },
      },
    }
  },
}
