local M = {}

function M.setup()
  -- This function now uses the modern vim.lsp.config() API as requested.
  -- It sets up LSP servers and defines keymaps correctly using an on_attach function.

  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  -- on_attach: This remains the best practice for defining keymaps.
  -- The function is called for each buffer when a language server attaches.
  local on_attach = function(client, bufnr)
    -- Buffer-local keymaps. These are only active in this buffer and when an LSP is running.
    -- This is the key to preventing the quickfix list from opening and ensuring direct navigation.
    vim.keymap.set('n', '<localleader>d', vim.diagnostic.open_float, { buffer = bufnr, desc = "Show line diagnostics" })
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = "Show hover information" })
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr, desc = "Go to declaration" })
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to definition" })
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = bufnr, desc = "Go to implementation" })
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = bufnr, desc = "Show references" })
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename" })
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code action" })
  end
  
  -- Default settings for all servers
  vim.lsp.config('*', {
    on_attach = on_attach,
    capabilities = capabilities,
  })

  -- Server-specific settings
  vim.lsp.config('matlab_ls', {
    settings = {
      matlab = {
        installPath = '/opt/MATLAB/R2024b',
        telemetry = false,
      },
    },
  })

  -- Define and enable your manually-installed server (ccls)
  -- Because ccls is not in Mason, we have to provide the full
  -- default configuration ourselves, then enable it.
  vim.lsp.config('ccls', {
    -- The default config for ccls from nvim-lspconfig's source
    cmd = { 'ccls' },
    filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
    root_markers = { 'compile_commands.json', '.ccls', '.git' },
    offset_encoding = 'utf-32',

    -- Now, merge our shared settings and custom options
    on_attach = on_attach,
    capabilities = capabilities,
    init_options = {
      index = {
        threads = 8,
      },
      cache = {
        directory = vim.fn.stdpath('cache') .. '/ccls',
      },
    },
  })

  -- CRITICAL: Manually enable the server
  vim.lsp.enable('ccls')
end

return M
