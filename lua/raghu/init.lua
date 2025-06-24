
local utils = require('raghu.utils')
local instance = {}
local default = require('lazy.core.loader')
instance.configurePlugin = function (plugin, opts)
  -- preserve default option setup
  utils.info('configurePlugin', plugin.name)
  local main = default.get_main(plugin)
  if main and next(opts) then
    utils.info("running default setup(opts)", main, plugin.name, opts)
    require(main).setup(opts)
  end
  local module = 'raghu.'.. string.gsub(plugin.name, '%.', '-')
  local configModule = require(module)
  utils.info("Calling additional config from", module, plugin.name)
  configModule.config(opts)
end
return instance
