local M = {}
M.config = function ()
  vim.o.foldcolumn = '1'
  vim.o.foldlevel = 99
  vim.o.foldlevelstart = 99
  vim.o.foldenable = true
  vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep:│,foldclose:]]
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
  }
  local language_servers = vim.lsp.get_clients() -- or list servers manually like {'gopls', 'clangd'}
  for _, ls in ipairs(language_servers) do
    require('lspconfig')[ls].setup({
      capabilities = capabilities
      -- you can add other fields for setting up lsp server in this table
    })
  end
  require('ufo').setup()

end
return M
