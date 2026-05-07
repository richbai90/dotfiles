return {
  "dccsillag/magma-nvim",
  run = "UpdateRemotePlugins",
  lazy= false,
  keys = { 
        { "<leader>j", group = "Jupyter" },
        { "<leader>je", group = "Evaluate" },
        { "<leader>jec", "<cmd>MagmaEvaluateOperator<CR>", desc = "Code (to cursor)" },
        { "<leader>jel", "<cmd>MagmaEvaluateLine<CR>", desc = "Line" },
        { "<leader>jev", ":MagmaEvaluateVisual<CR>", desc = "Visual Selection" },
        { "<leader>ji", "<cmd>MagmaInit python3<CR>", desc = "Initialize Kernel" },
        { "<leader>jr", "<cmd>MagmaRestart<CR>", desc = "Restart Kernel" },
        { "<leader>js", "<cmd>MagmaStop<CR>", desc = "Stop Kernel" },
  },
}
