local instance = {}
local utils = require('raghu.utils')
instance.config = function()
  vim.g.session_directory = vim.fn.stdpath("state") .. "/sessions"
  utils.mkdir(vim.g.session_directory)
  vim.g.session_command_aliases = 1
  vim.g.session_autosave = "yes"
  vim.g.session_lock_enabled = 0
  vim.g.session_autoload = "yes"
  vim.g.session_persist_colors = 1
  vim.g.session_default_to_last = 1
  vim.g.session_persist_globals = { "&guifont", "&background" }
end
return instance
