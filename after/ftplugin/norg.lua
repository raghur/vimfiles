
vim.keymap.set("i", "<CR>", "<Plug>(neorg.itero.next-iteration)", {buffer = true})
vim.keymap.set({"i", "n"}, "<Tab>", "<Plug>(neorg.promo.promote)", {buffer = true})
vim.keymap.set({"i", "n"}, "<S-Tab>", "<Plug>(neorg.promo.demote)", {buffer = true})
vim.keymap.set("i", "<Tab>", "<Plug>(neorg.promo.promote.range)", {buffer = true})
vim.keymap.set("v", "<S-Tab>", "<Plug>(neorg.promo.demote.range)", {buffer = true})
vim.keymap.set("v", "<C-Space>", "<Plug>(neorg.qol.todo-items.todo.task-cycle)", {buffer = true} )
