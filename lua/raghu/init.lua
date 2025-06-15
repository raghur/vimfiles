
local utils = require('raghu.utils')
local instance = {}
local vi = vim.inspect
local default = require('lazy.core.loader')
instance.configurePlugin = function (plugin, opts)
  -- preserve default option setup
  local main = default.get_main(plugin)
  if main and next(opts) then
    utils.info("running default setup(opts)", vi(main), plugin.name, vi(opts))
    require(main).setup(opts)
  end
  local config = require('raghu.'.. string.gsub(plugin.name, '%.', '-'))
  config.config(opts)
  utils.info('configured', plugin.name)
  utils.dbg(vi(plugin), vi(opts))
end
return instance
