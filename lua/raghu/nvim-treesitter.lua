local M = {}

local parsers = {
  "yaml",
  "json",
  "bash",
  "cpp",
  "c_sharp",
  "dockerfile",
  "dot",
  "gitcommit",
  "gitattributes",
  "graphql",
  "hcl",
  "javascript",
  "lua",
  "markdown",
  "markdown_inline",
  "vim",
  "make",
  "cmake",
  "typescript",
}

M.config = function()
  local treesitter = require("nvim-treesitter")

  treesitter.setup()
  treesitter.install(parsers)

  local group = vim.api.nvim_create_augroup("raghu_treesitter", { clear = true })
  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    callback = function(args)
      if pcall(vim.treesitter.start, args.buf) then
        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end,
  })
end

return M
