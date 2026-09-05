
local M = {}
M.config = function()

  -- require("mason").setup()

  require("mason-tool-installer").setup({
    ensure_installed = {
      'stylua',
      'isort',
      'black',
      'jq',
      'beautysh',
      'prettierd',
      'lua-language-server',
      'typescript-language-server',
      'vim-language-server',
      -- Opt to list sources here, when available in mason.
    },
    auto_update = false,
    -- Run the installation on startup
    run_on_start = true,
  })
  Info("sourced", vim.fn.expand("<sfile>"))
end
return M
