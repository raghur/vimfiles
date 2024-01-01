
local M = {}
local editConfig = function(file, type)
  local configHome = vim.fs.dirname(vim.env.MYVIMRC)

  local targetfiles = vim.fs.find(
    {file},
    {limit = 1, type = type, path = configHome}
  )
  print(vim.inspect(targetfiles))
  vim.cmd.edit(targetfiles)
end

M.editConfig = function(file)
    editConfig(file, 'file')
  end
M.editConfigFolder = function(folder)
    editConfig(folder, 'directory')
  end

ReloadConfig = function ()
  Require('mappings').mapKeys()
  Require('settings')
  Require('commands')
  vim.notify('Config reloaded!', vim.log.levels.INFO)
end
-- M.reloadconfig = function()
--   local luacache = (_G.__luacache or {}).cache
--   -- TODO unload commands, mappings + ?symbols?
--   for pkg, _ in pairs(package.loaded) do
--     if pkg:match '^my_.+'
--     then
--       print(pkg)
--       package.loaded[pkg] = nil
--       if luacache then
--         lucache[pkg] = nil
--       end
--     end
--   end
--   dofile(vim.env.MYVIMRC)
--   vim.notify('Config reloaded!', vim.log.levels.INFO)
-- end

M.cycle = function (items, index, dir)
  if dir >= 0 then dir = 1 else dir = -1 end
  index = index + dir
  if index > #items then index = 1 end
  if index < 1 then index = #items end
  return items[index]
end

--  global require
Require = function (name)
  package.loaded[name] = nil
  return require(name)
end
M.mkdir = vim.fn['utils#createIfNotExists']
M.dbg = vim.fn['utils#dbg']
M.info = vim.fn['utils#info']
M.loglvl = vim.fn['utils#loglvl']
return M
