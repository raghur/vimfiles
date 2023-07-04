
local keymap = vim.keymap.set
return {
    'MattesGroeger/vim-bookmarks',
    {'raghur/vim-helpnav', ft='help' },
    {  'tpope/vim-repeat'},
    { 'jiangmiao/auto-pairs'},
    {  'mbbill/undotree', cmd="UndotreeToggle"},
    {  'gregsexton/MatchTag'},
    {'tpope/vim-commentary'},

    { 'flazz/vim-colorschemes'},
    { 'sheerun/vim-polyglot'},
    {  'vim-scripts/matchit.zip'},
    {  'tpope/vim-ragtag'},
    {  'wellle/targets.vim'},
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        dependencies = {
            {
                'nvim-treesitter/nvim-treesitter',
                build = function ()
                    vim.cmd("TSUpdate")
                end
            }
        }

    },
    { 'rstacruz/sparkup',  rtp= 'vim', enabled = false  },

    { 'airblade/vim-rooter',
        config = function (plugin, opts)
            vim.g.rooter_silent_chdir = 1
        end
    },
    { 'tpope/vim-surround' },
    { 'xolox/vim-session',
        config = function(plugin, opts)
            vim.g.session_directory=vim.fn.stdpath('state') .. '/.vimbackups/.sessions'
            print(vim.g.session_directory)
            vim.g.session_command_aliases = 1
            vim.g.session_autosave='yes'
            vim.g.session_lock_enabled = 0
            vim.g.session_autoload='yes'
            vim.g.session_default_to_last=1
            vim.g.session_persist_globals = {'&guifont', 'g:colors_name', '&background'}
        end,
        dependencies = {
            { 'xolox/vim-misc'}
        }
    },
    {
        'alvan/vim-closetag',
        config = function (plugin, opts)
            vim.g.closetag_filenames = "*.html,*.xhtml,*.xml,*.htm,*.vue,*.jsx"
            vim.g.closetag_xhtml_filenames = "*.xhtml,*.jsx,*.vue"
        end
    },
    {
        'raghur/vim-ghost',
        build = function ()
            vim.cmd("GhostInstall")
        end,
        config = function ()
            vim.g.ghost_autostart=1
        end
    },
    {
        't9md/vim-choosewin',
        keys = '-',
        config = function ()
            keymap('n', '-', '<Plug>(choosewin)', { noremap=true })
            vim.g.choosewin_overlay_enable=1
        end,
    },

    {
        'nvim-telescope/telescope.nvim',
        branch= '0.1.x',
        dependencies = {
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
            },
            { 'nvim-lua/plenary.nvim' },
        config = function ()
                require('telescope').setup{
                    pickers = {
                        live_grep = {
                            additional_args = function(opts)
                                return { "--hidden" }
                            end
                        }
                    },
                    defaults = {
                        -- layout_strategy = 'cursor',
                        file_ignore_patterns = {'node_modules/', '.git/'},
                        mappings = {
                            i = {
                                ["<esc>"] = actions.close,
                                ["<C-h>"] = "which_key"
                            }
                        }
                    }
                }
        end
    }
    },
    { 'nvim-orgmode/orgmode' },
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'jose-elias-alvarez/null-ls.nvim' },
    { 'jay-babu/mason-null-ls.nvim' },
    { 'onsails/lspkind-nvim' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-emoji' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-cmdline' },
    -- follow latest release and install jsregexp.
    { 'L3MON4D3/LuaSnip',
        version = 'v1.*',
        build =  'make install_jsregexp'
    },
    { 'saadparwaiz1/cmp_luasnip' },
    -- DO NOT lazy load - won't work
    { 'hrsh7th/nvim-cmp' },
    { 'stevearc/aerial.nvim' },
    { 'nvim-lualine/lualine.nvim' },
    { 'folke/tokyonight.nvim' },
    { 'echasnovski/mini.nvim' },

    { 'neovim/nvim-lspconfig' },
    { 'nvim-tree/nvim-web-devicons', lazy = true},
    { 'nvimdev/lspsaga.nvim',
        branch = 'main' },
    { 'ggandor/leap.nvim' },
    { 'catppuccin/nvim',  name = 'catppuccin', priority = 1000  },

    { 'gbprod/yanky.nvim' },
}
