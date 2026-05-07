return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern",
    filter = function(mapping)
      return mapping.desc and mapping.desc ~= ""
    end,
    
    -- 
    -- THIS IS THE FIX:
    --
    spec = {
      -- Tell 'g' to include buffer-local maps
      { "g", group = "Go", mode = "n" },
      { "<LocalLeader>", group = "Local Bindings", mode = "n" },
    },
    
    -- Use "auto" to find ALL prefixes (g, ,, and ;)
    
    keys = {
      scroll_down = "<c-d>",
      scroll_up = "<c-u>",
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
