return {
  -- The theme you want to use
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000, -- Make sure to load this before all the other start plugins
    config = function()
      -- Load the colorscheme here
      vim.cmd.colorscheme "catppuccin"
    end,
  },

  -- To disable the default tokyonight theme
  { "folke/tokyonight.nvim", lazy = true },
}
