-- Colorschemes load on demand: lazy.nvim loads the plugin the first time
-- `:colorscheme <name>` is run (e.g. when vim-session restores the last one).
return {
  { 'rebelot/kanagawa.nvim',      lazy = true },
  { 'rose-pine/neovim',           name = 'rose-pine', lazy = true },
  { "sainnhe/sonokai",            lazy = true },
  { 'jacoborus/tender.vim',       lazy = true },
  { "ellisonleao/gruvbox.nvim",   lazy = true,        config = true },
  { "folke/tokyonight.nvim",      lazy = true },
  { "loctvl842/monokai-pro.nvim", lazy = true },
  { "catppuccin/nvim",            name = "catppuccin", lazy = true },
}
