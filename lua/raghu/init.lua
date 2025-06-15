
local utils = require('raghu.utils')
local instance = {}

local default = require('lazy.core.loader')
instance.configurePlugin = function (plugin, opts)
  -- preserve default option setup
  local main = default.get_main(plugin)
  if main and next(opts) then
    Info("running default setup(opts)", vim.inspect(main), plugin.name, vim.inspect(opts))
    require(main).setup(opts)
  end
  local config = require('raghu.'.. string.gsub(plugin.name, '%.', '-'))
  config.config(opts)
  utils.info('configured', plugin.name)
  utils.dbg(vim.inspect(plugin), vim.inspect(opts))
end
return instance
