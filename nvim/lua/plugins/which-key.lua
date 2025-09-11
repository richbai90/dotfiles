return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    preset = "modern",
    filter = function(mapping)
	    return mapping.desc and mapping.desc ~= "" 
    end,
    spec = {},
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
    scroll_down = "<c-d>",
    scroll_up = "<c-u>",
    -- Add all leap motion keys to the ignore list
    ["<leader>"] = "", -- ignore leader, it has its own trigger
    ["<space>"] = "", -- ignore localleader
    ["'"] = "",
    ["`"] = "",
    ['"'] = "",
    ["c"] = "",
    ["d"] = "",
    ["g"] = "",
    ["s"] = "", -- This is the key causing your issue
    ["t"] = "",
    ["v"] = "",
    ["x"] = "",
    ["y"] = "",
  },
}
