local M = {}

function M.setup()
  -- Move the require calls inside the setup function
  local lspconfig = require('lspconfig')
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  -- Keymaps for LSP actions
  vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = "Show line diagnostics" })
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "Show hover information" })
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = "Go to declaration" })
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to definition" })
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = "Go to implementation" })
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = "Show references" })
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = "Rename" })
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = "Code action" })

  -- A list of the LSP servers to set up
  local servers = {
    lua_ls = {},
    pyright = {},
    rust_analyzer = {},
    matlab_ls = {
      settings = {
        MATLAB = {
          installPath = '/opt/MATLAB/R2025a/bin/matlab'
        }
      }
    }
  }

  local defaults = {
    capabilities = capabilities,
  }

  -- Loop through the servers table and set them up
  for server_name, server_settings in pairs(servers) do
    -- Merge default settings with server-specific settings
    local final_settings = vim.tbl_deep_extend('force', defaults, server_settings)

    -- Set up the server
    lspconfig[server_name].setup(final_settings)
  end

  -- Manual Setup for servers that aren't built-in
end

return M
