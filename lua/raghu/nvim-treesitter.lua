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
      if not pcall(vim.treesitter.start, args.buf) then
        return
      end

      local filetype = vim.bo[args.buf].filetype
      local language = vim.treesitter.language.get_lang(filetype)
      local ok, indent_query = pcall(vim.treesitter.query.get, language, "indents")
      if ok and indent_query then
        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end,
  })
end

return M
