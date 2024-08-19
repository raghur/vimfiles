require("settings")
require("commands")
vim.g.maplocalleader = "\\"
vim.g.mapleader = ' '
local maps = require("mappings")
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
  if (not vim.v.servername) then
    vim.fn.serverstart(vim.fn.stdpath('run') .. '/nvim.sock')
  end
  -- vim.cmd('echom "server running at '..vim.v.servername .. '"')
  Info('Server running at ', vim.v.servername)
end

maps.mapKeys()
utils.info("sourced init.lua")
