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

map_select("ip", "@parameter.inner", nil, "Parameter inner")
map_select("ap", "@parameter.outer", nil, "Parameter outer")
map_select("af", "@function.outer", nil, "Function outer")
map_select("if", "@function.inner", nil, "Function inner")
map_select("ac", "@conditional.outer", nil, "Conditional outer")
map_select("ic", "@conditional.inner", nil, "Conditional inner")
map_select("as", "@local.scope", "locals", "Scope")

local function map_move(lhs, direction, query, query_group, desc)
  vim.keymap.set({ "n", "x", "o" }, lhs, function()
    move[direction](query, query_group or "textobjects")
  end, { desc = desc })
end

map_move("]m", "goto_next_start", "@function.outer", nil, "Next function")
map_move("]c", "goto_next_start", "@class.outer", nil, "Next class")
map_move("]s", "goto_next_start", "@local.scope", "locals", "Next scope")
map_move("]f", "goto_next_start", "@fold", "folds", "Next fold")
map_move("[m", "goto_previous_start", "@function.outer", nil, "Previous function")
map_move("[c", "goto_previous_start", "@class.outer", nil, "Previous class")
map_move("[s", "goto_previous_start", "@local.scope", "locals", "Previous scope")
map_move("[f", "goto_previous_start", "@fold", "folds", "Previous fold")

local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")

vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
