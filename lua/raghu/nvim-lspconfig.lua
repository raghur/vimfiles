local M = {}
M.config = function()
  require("mason").setup()

  local masonLspConfig =require("mason-lspconfig")
  masonLspConfig.setup()

  Info("sourced", vim.fn.expand("<sfile>"))
end
return M
