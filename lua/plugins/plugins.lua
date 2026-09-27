local config = require("raghu").configurePlugin
return {
  {
    'Bekaboo/dropbar.nvim',
    config = function()
      local dropbar_api = require('dropbar.api')
      vim.keymap.set('n', '<Leader>;', dropbar_api.pick, { desc = 'Pick symbols in winbar' })
      vim.keymap.set('n', '[;', dropbar_api.goto_context_start, { desc = 'Go to start of current context' })
      vim.keymap.set('n', '];', dropbar_api.select_next_context, { desc = 'Select next context' })
    end
  },
  { "tpope/vim-repeat" },
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release and install jsregexp.
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "v2.*",
    lazy = true, -- loaded by blink.cmp
    build = "make install_jsregexp",
    config = function ()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_snipmate").load({
        paths = vim.fn.stdpath("config") .. "/snippets",
      })
    end
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
    ft = { "html", "xhtml", "xml", "vue", "javascriptreact", "typescriptreact" },
    -- must be set before the plugin loads; it reads these when defining its autocmds
    init = function()
      vim.g.closetag_filenames = "*.html,*.xhtml,*.xml,*.htm,*.vue,*.jsx,*.tsx"
      vim.g.closetag_xhtml_filenames = "*.xhtml,*.jsx,*.tsx,*.vue"
      vim.g.closetag_filetypes = "html,xhtml,xml,vue,javascriptreact,typescriptreact"
      vim.g.closetag_xhtml_filetypes = "xhtml,javascriptreact,typescriptreact,vue"
    end,
  },
  {
    "raghur/vim-ghost",
    build = function()
      vim.cmd("GhostInstall")
    end,
    init = function()
      vim.g.ghost_autostart = 0
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
    event = "BufReadPost",
    -- fold options must be in place before the first buffer is displayed
    init = function()
      vim.o.foldcolumn = '1'
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep:│,foldclose:]]
    end,
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
      { "<leader>y", function() Snacks.picker.yanky() end, mode = { "n", "x", "i" }, desc = "Open Yank History", },
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
      -- notifier = { enabled = true },
      quickfile = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      zen = { enabled = true},
    },
    config = config,
  },
  {
    'stevearc/conform.nvim',
    cmd = "ConformInfo", -- otherwise loaded on require() by the format mapping
    opts = {},
    config = config,
  },
  {
    "nvim-neorg/neorg",
    -- lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    ft = "norg",
    cmd = "Neorg",
    config = true,
    dependencies = {
      {
        "nvim-neorg/tree-sitter-norg",
        opts = {
          hererocks = true
        },
        init = function ()
          -- Enable treesitter automatically for some filetypes.
          vim.api.nvim_create_autocmd("FileType", {
            pattern = {
              "norg",
            },
            callback = function() vim.treesitter.start() end
          })
        end,
        config = function ()
        end
      }
    },
    opts = {
      load = {
        ["core.defaults"] = {},
        ["core.esupports.indent"] = {
          config = {
            format_on_enter = false
          }
        },
        ["core.concealer"] = {
          config = {
            icon_preset = "diamond", -- or "basic"
          },
        },
        ["core.esupports.hop"] = {},
        ["core.itero"] = {},
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
