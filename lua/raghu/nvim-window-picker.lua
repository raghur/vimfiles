local M = {}
M.config = function()
  local plugin = require'window-picker'
  plugin.setup({
    hint = 'floating-big-letter',
    filter_rules = {
      include_current_win = true
    }
  })

  plugin.pickWindow = function()
    local id = require('window-picker').pick_window()
    if id then
      vim.fn.win_gotoid(id)
    end
  end
end
return M
