return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    -- oil.nvim options here
  },
  keys = {
    { "-", "<cmd>Oil --float<cr>", desc = "Open Parent Directory", mode = "n" }
  },
  lazy = false,
}
