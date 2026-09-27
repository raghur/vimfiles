require("nvim-treesitter-textobjects").setup({
  select = {
    lookahead = true,
    selection_modes = {
      ["@parameter.outer"] = "v",
      ["@function.outer"] = "V",
      ["@class.outer"] = "V",
    },
    include_surrounding_whitespace = false,
  },
  move = {
    set_jumps = true,
  },
})

local select = require("nvim-treesitter-textobjects.select")
local move = require("nvim-treesitter-textobjects.move")

local function map_select(lhs, query, query_group, desc)
  vim.keymap.set({ "x", "o" }, lhs, function()
    select.select_textobject(query, query_group or "textobjects")
  end, { desc = desc })
end

-- `ia`/`aa` (argument) instead of `ip`/`ap`, which would shadow paragraphs.
map_select("ia", "@parameter.inner", nil, "Parameter inner")
map_select("aa", "@parameter.outer", nil, "Parameter outer")
map_select("af", "@function.outer", nil, "Function outer")
map_select("if", "@function.inner", nil, "Function inner")
map_select("ac", "@conditional.outer", nil, "Conditional outer")
map_select("ic", "@conditional.inner", nil, "Conditional inner")
-- `aS` instead of `as`, which would shadow sentences.
map_select("aS", "@local.scope", "locals", "Scope")

local function map_move(lhs, direction, query, query_group, desc)
  vim.keymap.set({ "n", "x", "o" }, lhs, function()
    move[direction](query, query_group or "textobjects")
  end, { desc = desc })
end

map_move("]m", "goto_next_start", "@function.outer", nil, "Next function")
-- `]C`/`]o` instead of `]c`/`]s`, which are diff-hunk and spelling motions.
map_move("]C", "goto_next_start", "@class.outer", nil, "Next class")
map_move("]o", "goto_next_start", "@local.scope", "locals", "Next scope")
map_move("]f", "goto_next_start", "@fold", "folds", "Next fold")
map_move("[m", "goto_previous_start", "@function.outer", nil, "Previous function")
map_move("[C", "goto_previous_start", "@class.outer", nil, "Previous class")
map_move("[o", "goto_previous_start", "@local.scope", "locals", "Previous scope")
map_move("[f", "goto_previous_start", "@fold", "folds", "Previous fold")

local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")

vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next, { desc = "Repeat last move" })
vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous, { desc = "Repeat last move backwards" })

-- Register the builtin f/F/t/T motions so `;` and `,` keep repeating them.
vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
