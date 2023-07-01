" telescope
nnoremap <leader><space> <Cmd>Telescope find_files<CR>
nnoremap <leader>f <Cmd>Telescope git_files<CR>
nnoremap <leader>gf <Cmd>:Telescope find_files hidden=true no_ignore=true<CR>
nnoremap <leader>/  <Cmd>Telescope live_grep<CR>
nnoremap <leader>r  <Cmd>:lua require("telescope.builtin").buffers({sort_mru=true, ignore_current_buffer=true})<CR>
nnoremap <leader>b  <Cmd>:lua require("telescope.builtin").buffers({sort_mru=true, ignore_current_buffer=true})<CR>
nnoremap <leader>h  <Cmd>Telescope help_tags<CR>
nnoremap <leader>lw <Cmd>:lua require("telescope.builtin").lsp_workspace_symbols()<CR>
nnoremap <leader>lo <Cmd>:lua require("telescope.builtin").lsp_document_symbols()<CR>
nnoremap <leader>ld <Cmd>:lua require("telescope.builtin").lsp_definitions()<CR>
nnoremap <leader>ll <Cmd>:lua require("telescope.builtin").diagnostics()<CR>
nnoremap <leader>lr <Cmd>:lua require("telescope.builtin").lsp_references()<CR>
nnoremap <leader>co <Cmd>Telescope colorscheme<CR>
nnoremap <leader>:  <Cmd>Telescope commands<CR>
lua << EOF
local actions = require('telescope.actions')
local sorters = require('telescope.sorters')
-- Global remapping
------------------------------
require('telescope').setup{
  defaults = {
    -- layout_strategy = 'cursor',
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-h>"] = "which_key"
      }
    }
  }
}
require('telescope').load_extension('fzf')
EOF
