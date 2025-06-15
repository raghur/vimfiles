local M = {}
M.config = function ()
  local explorer = require("snacks.explorer")
  local origReveal = explorer.reveal
  -- redefining reveal
  -- Without this, if you're on the selected buffer, reveal() does not switch to the explorer window
  explorer.reveal = function(opts)
    local explorer_win = nil
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_loaded(bufnr) and
          vim.api.nvim_buf_get_option(bufnr, "filetype") == "snacks_picker_list" then
        -- You might also want to check the buffer name if snacks.nvim gives it a consistent name.
        -- However, 'snacks_picker_list' as filetype is generally reliable for the explorer.
        explorer_win = vim.fn.bufwinid(bufnr)
        Dbg("got explorer bufnr", explorer_win)
        break
      end
    end
    if explorer_win  then
      Dbg("switching explorer bufnr", explorer_win)
      vim.api.nvim_set_current_win(explorer_win)
    else
      -- If the explorer buffer is not open, run the command to open it
      origReveal(opts)
    end

  end

end
return M
