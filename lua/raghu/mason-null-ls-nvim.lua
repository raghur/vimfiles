
local M = {}
M.config = function()

  require("mason").setup()

  require("mason-null-ls").setup({
    ensure_installed = {
      'stylua',
      'jq',
      'beautysh',
      'prettierd',
      'lua-language-server',
      'typescript-language-server',
      'vim-language-server',
      -- Opt to list sources here, when available in mason.
    },
    automatic_installation = false,
    handlers = {},
  })
  require("null-ls").setup()
  Info("sourced", vim.fn.expand("<sfile>"))
end
return M
