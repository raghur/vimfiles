" telescope
nnoremap <leader><space> <Cmd>Telescope find_files<CR>
nnoremap <leader>f <Cmd>Telescope git_files<CR>
nnoremap <leader>af <Cmd>:Telescope find_files hidden=true no_ignore=true<CR>
nnoremap <leader>*  <Cmd>Telescope live_grep<CR>
nnoremap <leader>r  :lua require("telescope.builtin").buffers({sort_mru=true, ignore_current_buffer=true})<CR>
nnoremap <leader>h  <Cmd>Telescope help_tags<CR>
nnoremap <leader>gw  :lua require("telescope.builtin").lsp_workspace_symbols()<CR>
nnoremap <leader>go  :lua require("telescope.builtin").lsp_document_symbols()<CR>
nnoremap <leader>gd  :lua require("telescope.builtin").lsp_definitions()<CR>
nnoremap <leader>gr  :lua require("telescope.builtin").lsp_references()<CR>
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
