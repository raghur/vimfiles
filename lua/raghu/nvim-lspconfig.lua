local M = {}
M.config = function()

  require('neodev').setup({
    -- You can configure neodev here if needed
    -- e.g., for specific runtime paths or custom types
  })
  local lspconfig = require('lspconfig')
  local masonLspConfig =require("mason-lspconfig")
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  require("mason").setup()

  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
  masonLspConfig.setup()
  lspconfig.lua_ls.setup({
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global and other common Neovim globals
        globals = { 'vim', 'require', 'use', 'packer_plugins', 'P', 'LazyVim', 'Snacks' }, -- Add any other globals from your config/plugins
      },
      workspace = {
        -- Make the server aware of Neovim runtime files for API documentation and definitions
        library = {
          [vim.env.VIMRUNTIME] = true,
          -- Optionally, you can add your Neovim config directory
          -- This helps with recognizing functions/modules in your own config
          [vim.fn.stdpath('config') .. '/lua'] = true,
          -- If you use Lazy.nvim, you might want to add its types for better completion
          [vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true,
          -- If you have a specific directory for your types (e.g., from LazyVim)
          -- [vim.fn.stdpath("data") .. "/lazy/ui/nvchad_types"] = true,
        },
        checkThirdParty = false, -- Set to true if you want strict checking for external libraries
      },
      telemetry = {
        enable = false, -- Disable telemetry if you prefer
      },
    },
  },
  })

  Info("sourced", vim.fn.expand("<sfile>"))
end
  return M
