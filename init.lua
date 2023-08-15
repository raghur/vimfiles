require("settings")
require("commands")
require("mappings")
local utils = require("raghu.utils")
Info, Dbg = utils.info, utils.dbg
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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
require("lazy").setup("plugins", {})
if (vim.fn.has('linux') > 0 or vim.fn.has('mac')) then
  vim.fn.serverstart('/var/tmp/nvim.'.. vim.env.USER .. '.sock')
end

Info("sourced init.lua")
