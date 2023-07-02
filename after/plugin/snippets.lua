require("luasnip.loaders.from_vscode").lazy_load({paths = {"./luasnips"}})
info('sourced', vim.fn.expand('<sfile>'))
