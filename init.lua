require("settings")
require("commands")
vim.g.maplocalleader = "\\"
vim.g.mapleader = ' '
local maps = require("mappings")
local utils = require("raghu.utils")
-- or set env var NVIM_LOG=1, 2 etc 0/unset - disabled, 1=INFO, 2=DBG
-- utils.loglvl('DBG')
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

if vim.g.neovide then
  vim.cmd("source ".. vim.fn.stdpath('config').. "/ginit.vim")
  vim.g.neovide_input_macos_alt_is_meta=true
end

maps.mapKeys()
utils.info("sourced init.lua")
