
local actions = require('telescope.actions')
require('telescope').setup{
  pickers = {
    live_grep = {
        additional_args = function(opts)
        return { "--hidden" }
        end
    }
  },
  defaults = {
    -- layout_strategy = 'cursor',
    file_ignore_patterns = {'node_modules/', '.git/'},
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-h>"] = "which_key"
      }
    }
  }
}
require('telescope').load_extension('fzf')

vim.cmd([[
nnoremap <expr><leader><space> ':Telescope find_files hidden=true cwd='.FindRootDirectory().'/<cr>'
nnoremap <expr><leader>f ':Telescope find_files hidden=true no_ignore=true cwd='.FindRootDirectory().'/<cr>'
nnoremap <leader>gf <Cmd>Telescope git_files<CR>
nnoremap <leader>/  <Cmd>Telescope live_grep<CR>
nnoremap <leader>r  <Cmd>:lua require("telescope.builtin").buffers({sort_mru=true, ignore_current_buffer=true})<CR>
nnoremap <leader>b  <Cmd>:lua require("telescope.builtin").buffers({sort_mru=true, ignore_current_buffer=true})<CR>
nnoremap <leader>gh  <Cmd>Telescope help_tags<CR>
nnoremap <leader>lw <Cmd>:lua require("telescope.builtin").lsp_workspace_symbols()<CR>
nnoremap <leader>lo <Cmd>:lua require("telescope.builtin").lsp_document_symbols()<CR>
nnoremap <leader>ld <Cmd>:lua require("telescope.builtin").lsp_definitions() <cr>:normal('zz')<CR>
nnoremap <leader>ll <Cmd>:lua require("telescope.builtin").diagnostics()<CR>
nnoremap <leader>lr <Cmd>:lua require("telescope.builtin").lsp_references()<CR>
nnoremap <leader>lp <Cmd>:lua require("telescope.builtin").loclist()<CR>
nnoremap <leader>co <Cmd>Telescope colorscheme<CR>
nnoremap <leader>:  <Cmd>Telescope commands<CR>
]])

info('sourced', vim.fn.expand('<sfile>'))
