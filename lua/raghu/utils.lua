
local instance = {}
local editConfig = function(file, type)
  local configHome = vim.fs.dirname(vim.env.MYVIMRC)

  local targetfiles = vim.fs.find(
    {file},
    {limit = 1, type = type, path = configHome}
  )
  print(vim.inspect(targetfiles))
  vim.cmd.edit(targetfiles)
end

instance.editConfig = function(file)
    editConfig(file, 'file')
  end
instance.editConfigFolder = function(folder)
    editConfig(folder, 'directory')
  end

instance.cycle = function (items, index, dir)
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
instance.mkdir = vim.fn['utils#createIfNotExists']
instance.dbg = vim.fn['utils#dbg']
instance.info = vim.fn['utils#info']
instance.loglvl = vim.fn['utils#loglvl']
return instance
