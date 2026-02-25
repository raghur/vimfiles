require("settings")
require("commands")
vim.g.maplocalleader = "\\"
vim.g.mapleader = ' '
local utils = require("raghu.utils")
-- To enable these use `NVIM_LOG=1/2 nvim` resply
Info, Dbg = utils.info, utils.dbg
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins", {
  checker = { enabled = true}
})
if (vim.fn.has('linux') > 0 or vim.fn.has('mac')) then
  if (not vim.v.servername) then
    vim.fn.serverstart()
  end
  -- vim.fn.writefile({vim.v.servername}, "/tmp/"..vim.env.USER.."-server.nvim")
  -- vim.cmd('echom "server running at '..vim.v.servername .. '"')
  Info('Server running at ', vim.v.servername)
end

require("mappings")
utils.info("sourced init.lua")
