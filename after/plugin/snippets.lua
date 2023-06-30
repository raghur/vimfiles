require("luasnip.loaders.from_vscode").lazy_load()
if vim.env.NVIM_DBG then
  print('sourced ', vim.fn.expand('<sfile>'))
end
