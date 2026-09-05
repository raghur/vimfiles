require("settings")
require("commands")
vim.g.matchup_filetype_blacklist = { "markdown" }
vim.g.maplocalleader = "\\"
vim.g.mapleader = ' '
local utils = require("raghu.utils")
-- To enable these use `NVIM_LOG=1/2 nvim` resply
Info, Dbg = utils.info, utils.dbg
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local home = os.getenv("HOME")
local lua_version = "5.1" -- Neovim's LuaJIT version

-- Prepend the Lua source path
package.path = home .. "/.luarocks/share/lua/" .. lua_version .. "/?.lua;"
               .. home .. "/.luarocks/share/lua/" .. lua_version .. "/?/init.lua;"
               .. package.path

-- Prepend the Compiled C module path
package.cpath = home .. "/.luarocks/lib/lua/" .. lua_version .. "/?.so;"
                .. package.cpath
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
  checker = { enabled = true, notify = false}
})
if vim.fn.has("unix") == 1 and vim.v.servername == "" then
  local address = ("/tmp/nvim-%d.sock"):format(vim.uv.os_getpid())
  local started, result = pcall(vim.fn.serverstart, address)
  if started then
    utils.info("Server running at", result)
  else
    utils.dbg("Could not start server at", address, result)
  end
end

require("mappings")
utils.info("sourced init.lua")
