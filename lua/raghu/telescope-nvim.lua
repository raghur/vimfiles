local M = {}

M.config = function()
  local actions = require('telescope.actions')
  require('telescope').setup {
    extensions = {
      ["ui-select"] = {
        specific_opts = {
          codeactions = false
        }
      }
    },
    pickers = {
      live_grep = {
        additional_args = function(opts)
          return { "--hidden" }
        end
      }
    },
    defaults =  require("telescope.themes").get_dropdown({
      -- layout_strategy = 'cursor',
      file_ignore_patterns = { 'node_modules/', '.git/', '.npm/'},
      mappings = {
        i = {
          ["<esc>"] = actions.close,
          ["<C-h>"] = "which_key"
        }
      }
    })
  }
  require('telescope').load_extension('fzf')
  require('telescope').load_extension('aerial')
  require('telescope').load_extension('ui-select')
  local tele = require('telescope.builtin')
  local wk = require('which-key')
  local mappings = {
    r = {function() require("telescope.builtin").buffers({sort_mru=true, ignore_current_buffer=true}) end, "Buffers"},
    b = {function() require("telescope.builtin").buffers({sort_mru=true, ignore_current_buffer=true}) end, "Buffers"},
    gf = { "<Cmd>Telescope git_files<CR>", "Git files" },
    ['/'] = {"<Cmd>Telescope live_grep<CR>", "Grep" },
    f = {"':Telescope find_files hidden=true no_ignore=true cwd='.FindRootDirectory().'/<cr>'", "find (no ignore)", expr=true},
    [' '] = {"':Telescope find_files hidden=true cwd='.FindRootDirectory().'/<cr>'", "find", expr=true },
    l = {
      name = "+Language Server",
      a = { "<Cmd>Telescope aerial<CR>", 'Anything' },
      w =  {tele.lsp_workspace_symbols, "Workspace Symbols"},
      o =  {tele.lsp_document_symbols, "Document Symbols"},
      d =  {tele.lsp_definitions, "Defintions"},
      r =  {tele.lsp_references, "References"},
      l =  {tele.diagnostics, "Diagnostics"},
      f =  {tele.current_buffer_fuzzy_find, "Fuzzy find"},
    },
    co = { "<Cmd>Telescope colorscheme<CR>", 'Colors' },
    [":"] = {"<Cmd>Telescope commands<CR>", 'Commands'}
  }
  wk.register(mappings, {prefix = "<leader>"})
  Info('sourced', vim.fn.expand('<sfile>'))
end
return M
