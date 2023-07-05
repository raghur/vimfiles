
local utils = require('raghu.utils')
local instance = {}

instance.configurePlugin = function (plugin, opts)
  local config = require('raghu.'.. string.gsub(plugin.name, '%.', '-'))
  config.config()
  utils.info('configured', plugin.name)
end
return instance
