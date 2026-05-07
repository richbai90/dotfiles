return {
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {
    modes = {
      char = {
        enabled = true,
        -- This is the specific setting you need for labels
        jump_labels = true,
        -- Optional: automatically jump to the first match
        autohide = false,
        multi_line = false,
      },
    }
  },
  keys = {
    -- Use Space + s to jump anywhere
    { "<space>s", mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash Jump" },

    -- Use Space + S for Treesitter selection
    { "<space>S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },

    -- Use Space + r for Remote operations (The "Count" killer)
    { "<space>r", mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },

    -- Use Space + R for Treesitter Search
    { "<space>R", mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
  },
}
