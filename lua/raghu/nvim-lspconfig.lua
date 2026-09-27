local M = {}
M.config = function()
  -- blink.cmp's plugin/ script already merges its completion capabilities into
  -- vim.lsp.config("*"). Add folding ranges (used by nvim-ufo) for every server.
  vim.lsp.config("*", {
    capabilities = {
      textDocument = {
        foldingRange = {
          dynamicRegistration = false,
          lineFoldingOnly = true,
        },
      },
    },
  })

  vim.lsp.config("yamlls", {
    settings = {
      yaml = {
        schemaStore = {
          enable = false,
          url = nil,
        },
        format = { enable = true },
        completion = true,
        hover = true,
        validate = true,
      },
    },
  })

  -- lazydev.nvim (loaded for lua buffers) supplies the Neovim runtime and plugin
  -- libraries, so don't hard-code workspace.library or extra globals here.
  vim.lsp.config("lua_ls", {
    settings = {
      Lua = {
        workspace = { checkThirdParty = false },
      },
    },
  })

  -- mason.nvim is set up by its own spec (opts = {}); this enables every
  -- mason-installed server via vim.lsp.enable().
  require("mason-lspconfig").setup()
end
return M
