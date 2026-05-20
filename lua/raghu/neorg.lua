local M = {}

M.config = function ()
  require("luarocks-nvim").setup({
    rocks = { "dkjson" }, -- This ensures the plugin knows to look for it
})
end
return M
