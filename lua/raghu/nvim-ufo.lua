local M = {}
M.config = function ()
  vim.o.foldcolumn = '1'
  vim.o.foldlevel = 99
  vim.o.foldlevelstart = 99
  vim.o.foldenable = true
  vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep:│,foldclose:]]
  require('ufo').setup()

end
return M
