return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'hrsh7th/cmp-nvim-lsp',
  },
  config = function()
    -- Set up mason so it can manage LSP servers
    require('mason').setup()
    require('mason-lspconfig').setup({
      -- A list of servers to automatically install if they're not already installed
      ensure_installed = { 'lua_ls', 'rust_analyzer' }
    })

    -- Call the setup function from your servers file
    require('lsp.servers').setup()
  end
}
