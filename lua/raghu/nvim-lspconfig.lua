local M = {}
M.config = function()
  require("mason").setup()

  require("mason-lspconfig").setup()

  -- local on_attach = function(client, bufnr)
  --   print('onattach called', client)
  --   local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  --   local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --   buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  --   -- Mappings.
  --   local opts = { noremap=true, silent=true }
  --   buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  --   buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  --   buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  --   buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  --   buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  --   buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  --   buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  --   buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  --   buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  --   buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  --   buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  --   buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  --   buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  --   buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  --   buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  --   -- Set some keybinds conditional on server capabilities
  --   if client.resolved_capabilities.document_formatting then
  --     buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  --   elseif client.resolved_capabilities.document_range_formatting then
  --     buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  --   end

  --   -- Set autocommands conditional on server_capabilities
  --   if client.resolved_capabilities.document_highlight then
  --     vim.api.nvim_exec([[
  --     augroup lsp_document_highlight
  --     autocmd! * <buffer>
  --     autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
  --     autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
  --     augroup END
  --     ]], false)
  --   end
  -- end

  -- local function make_config(server_name)
  -- -- config that activates keymaps and enables snippet support
  --   print ('mak_econfig called', server_name);
  --   local capabilities = vim.lsp.protocol.make_client_capabilities()
  --   capabilities.textDocument.completion.completionItem.snippetSupport = true
  --   capabilities.textDocument.completion.completionItem.resolveSupport = {
  --     properties = {
  --       'documentation',
  --       'detail',
  --       'additionalTextEdits',
  --     }
  --   }
  --   return {
  --     -- enable snippet support
  --     capabilities = capabilities,
  --     -- map buffer local keybindings when the language server attaches
  --     on_attach = on_attach,
  --   }
  -- end

  local handlers = {
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name) -- default handler (optional)
      -- local config = make_config(server_name)
      -- require("lspconfig")[server_name].setup(config)
      require("lspconfig")[server_name].setup({})
    end,
    -- Next, you can provide a dedicated handler for specific servers.
    -- For example, a handler override for the `rust_analyzer`:
    -- ["rust_analyzer"] = function ()
    --     require("rust-tools").setup {}
    -- end
    ["bashls"] = function()
      local settings = {
        bashIde = {
          shellcheckPath = ""
        }
      }
      require('lspconfig').bashls.setup(settings)
    end,
    ["lua_ls"] = function()
      -- Configure lua language server for neovim development
      local lua_settings = {
        on_init = function(client)
          local path = client.workspace_folders[1].name
          if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
            return
          end

          client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
              -- Tell the language server which version of Lua you're using
              -- (most likely LuaJIT in the case of Neovim)
              version = 'LuaJIT'
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME
                -- Depending on the usage, you might want to add additional paths here.
                -- "${3rd}/luv/library"
                -- "${3rd}/busted/library",
              }
              -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
              -- library = vim.api.nvim_get_runtime_file("", true)
            }
          })
        end,
        settings = {
          Lua = {}
        }
      }
      require("lspconfig").lua_ls.setup(lua_settings)
      -- print ('mason-lspconfig:lua_ls',vim.fn.expand('<sfile>'))
    end,
  }
  require("mason-lspconfig").setup_handlers(handlers)

  Info("sourced", vim.fn.expand("<sfile>"))
end
return M
