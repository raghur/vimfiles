
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

local dbg, info=vim.fn['utils#dbg'], vim.fn['utils#info']
instance.dbg = dbg
instance.info = info
return instance
