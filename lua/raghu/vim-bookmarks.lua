
local instance = {}
instance.config = function()
  vim.g.bookmarks_auto_save_file = vim.fn.stdpath("state") .. "/.vim-bookmarks"
  vim.g.bookmark_center = 1
  vim.g.bookmark_highlight_lines = 1
  vim.g.bookmark_auto_save = 1
end

return instance
