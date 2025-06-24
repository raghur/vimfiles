
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
  local config = require('raghu.'.. string.gsub(plugin.name, '%.', '-'))
  config.config(opts)
  utils.dbg(plugin, opts)
end
return instance
