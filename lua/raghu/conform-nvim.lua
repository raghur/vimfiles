local M = {}
M.config = function(plugin, opts)
  require("conform").setup({
    formatters_by_ft = {
      lua = { "stylua" },
      -- Conform will run multiple formatters sequentially
      python = { "isort", "black" },
      -- Conform will run the first available formatter
      javascript = { "prettierd", "prettier", stop_after_first = true },
      typescript = { "prettierd", "prettier", stop_after_first = true },
      json = { "jq" },
      sh = { "beautysh" },
    },
    formatters = {
      yamlfix = {
        -- Change where to find the command
        command = "local/path/yamlfix",
        -- Adds environment args to the yamlfix formatter
        env = {
          YAMLFIX_SEQUENCE_STYLE = "block_style",
        },
      },
    },
  })
end
return M
