require'nvim-treesitter.configs'.setup {
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["ip"] = {query = "@parameter.inner", desc = "parameter inner"},
        ["ap"] = {query = "@parameter.outer", desc = "parameter outer"},
        ["af"] = {query = "@function.outer", desc = "function outer"},
        ["if"] = { query = "@function.inner", desc = "function inner" },
        ["ac"] = {query = "@conditional.outer", desc = "conditional outer"},
        -- You can optionally set descriptions to the mappings (used in the desc parameter of
        -- nvim_buf_set_keymap) which plugins like which-key display
        ["ic"] = { query = "@conditional.inner", desc = "conditional inner" },
        -- You can also use captures from other query groups like `locals.scm`
        ["as"] = { query = "@scope", query_group = "locals", desc = "scope" },
      },
      selection_modes = {
        ['@parameter.outer'] = 'v', -- charwise
        ['@function.outer'] = 'V', -- linewise
        ['@class.outer'] = 'V', -- blockwise
      },
      -- You can choose the select mode (default is charwise 'v')
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg '@function.inner'
      -- * method: eg 'v' or 'o'
      -- and should return the mode ('v', 'V', or '<c-v>') or a table
      -- mapping query_strings to modes.
      -- selection_modes = {
      --   ['@parameter.outer'] = 'v', -- charwise
      --   ['@function.outer'] = 'V', -- linewise
      --   ['@class.outer'] = '<c-v>', -- blockwise
      -- },
      -- If you set this to `true` (default is `false`) then any textobject is
      -- extended to include preceding or succeeding whitespace. Succeeding
      -- whitespace has priority in order to act similarly to eg the built-in
      -- `ap`.
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg '@function.inner'
      -- * selection_mode: eg 'v'
      -- and should return true of false
      include_surrounding_whitespace = false,
    },
   move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = {query = "@function.outer", desc = "next function"},
        ["]c"] = {query = "@class.outer", desc = "next class"},
        ["]s"] = {query = "@scope", query_group = "locals", desc = "next scope"},
        ["]f"] = {query = "@fold", query_group = "folds", desc = "next fold"},
        --
        -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queires.
        -- ["<leader>sn"] = "@loop.*",
        -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
        --
        -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
        -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
        -- ["<leader>z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
      },
      goto_previous_start = {
        ["[m"] = {query = "@function.outer", desc = "prev function"},
        ["[c"] = {query = "@class.outer", desc = "prev class"},
        ["[s"] = {query = "@scope", query_group = "locals", desc = "prev scope"},
        ["[f"] = {query = "@fold", query_group = "folds", desc = "prev fold"},
      --   ["<leader>k"] = "@function.outer",
      --   ["<leader>cp"] = "@class.outer",
      },
      -- Below will go to either the start or the end, whichever is closer.
      -- Use if you want more granular movements
      -- Make it even more gradual by adding multiple queries and regex.
      -- goto_next = {
      --   ["]m"] = {query = "@function.outer", desc = "next function"},
      --   ["]c"] = {query = "@class.outer", desc = "next class"},
      --   ["]s"] = {query = {"@conditional.outer", "@loop.outer"}, desc = "next block"},
      -- },
      -- goto_previous = {
      --   ["[m"] = {query = "@function.outer", desc = "next function"},
      --   ["[c"] = {query = "@class.outer", desc = "next class"},
      --   ["[s"] = {query = {"@conditional.outer", "@loop.outer"}, desc = "next block"},
      -- }
    },
  },
}
local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

-- Repeat movement with ; and ,
-- ensure ; goes forward and , goes backward regardless of the last direction
vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
