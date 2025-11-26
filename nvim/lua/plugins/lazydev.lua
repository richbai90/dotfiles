return {
  "folke/lazydev.nvim",
  ft = "lua", -- only load on lua files
  opts = {
    library = {
      -- See the configuration section for more details
      -- Load luv files from the Neovim runtime, which may not be loaded normally
      "luv",
      "nvim-dap-ui",
    },
  },
}
