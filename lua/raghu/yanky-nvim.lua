local M = {}

M.config = function()
  require("yanky").setup({
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  })
  require("telescope").load_extension("yank_history")
  vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
  vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
  vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
  vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")
  vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleForward)")
  vim.keymap.set("n", "<c-p>", "<Plug>(YankyCycleBackward)")
  vim.keymap.set("n", "<leader>P", ":Telescope yank_history<cr>")
  Info('sourced', vim.fn.expand('<sfile>'))
end
return M
