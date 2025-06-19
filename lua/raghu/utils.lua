
local function logit(level, levelName, ...)
  local enabledLevel = tonumber(vim.env.NVIM_LOG)
  if enabledLevel == 0 or enabledLevel == nil then return end
  if level >= enabledLevel then
    local processed = {levelName }
    local argsTable = {...}
    for i = 1, select('#',...) do
      if type(argsTable[i]) == 'table' then
        processed[i+1] = vim.inspect(argsTable[i])
      else
        processed[i+1] = argsTable[i]
      end
    end
    vim.print(table.concat(processed, " "))
  end
end

local M = {}

--  global require
M.requireUncached = function (name)
  package.loaded[name] = nil
  return require(name)
end

M.reload = function ()
  M.requireUncached('mappings')
  M.requireUncached('settings')
  M.requireUncached('commands')
  vim.notify('Config reloaded!', vim.log.levels.INFO)
end

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


M.cycle = function (items, index, dir)
  if dir >= 0 then dir = 1 else dir = -1 end
  index = index + dir
  if index > #items then index = 1 end
  if index < 1 then index = #items end
  return items[index]
end


M.mkdir = vim.fn['utils#createIfNotExists']

M.dbg = function(...)
  logit(1, "DEBG",...)
end
M.info = function(...)
  logit(2, "INFO",...)
end
M.loglvl = vim.fn['utils#loglvl']
return M
