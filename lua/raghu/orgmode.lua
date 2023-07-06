local M = {}

M.config = function()
  local orgmode = require('orgmode')
  orgmode.setup_ts_grammar()

  orgmode.setup({
    org_agenda_files = { '~/Sync/org/*' },
    org_default_notes_file = '~/Sync/todo.org',
    org_todo_keywords = { 'TODO', 'BLOCKED', '|', 'DONE' },
    mappings = {
      prefix = ","
    }
  })
end
return M
