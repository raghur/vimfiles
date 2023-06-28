" telescope
nnoremap <leader><space> <Cmd>Telescope find_files<CR>
nnoremap <leader>*  <Cmd>Telescope live_grep<CR>
nnoremap <leader>b  <Cmd>Telescope buffers<CR>
nnoremap <leader>h  <Cmd>Telescope help_tags<CR>
nnoremap <leader>r  <Cmd>Telescope oldfiles<CR>
nnoremap <leader>t  <Cmd>Telescope tags<CR>
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
      }
    }
  }
}
require('telescope').load_extension('fzf')
EOF
