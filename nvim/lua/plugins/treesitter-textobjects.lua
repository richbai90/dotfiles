return {
  -- 1. Inject textobjects configuration into the primary nvim-treesitter opts
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.textobjects = opts.textobjects or {}
      opts.textobjects.move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          ["]]"] = "@conditional.outer",
          ["}}"] = "@function.outer",
        },
        goto_next_end = {
          ["]["] = "@conditional.outer",
          ["}{"] = "@function.outer",
        },
        goto_previous_start = {
          ["[["] = "@conditional.outer",
          ["{{"] = "@function.outer",
        },
        goto_previous_end = {
          ["[]"] = "@conditional.outer",
          ["{}"] = "@function.outer",
        },
      }
    end,
  },

  -- 2. Define textobjects plugin and handle Which-Key bindings
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    dependencies = { "nvim-treesitter/nvim-treesitter", "folke/which-key.nvim" },
    init = function()
      -- Disable built-in ftplugin mappings to prevent conflict with [[ and ]]
      vim.g.no_plugin_maps = true
    end,
    config = function()
      -- Register with Which-Key for full visibility
      local wk = require("which-key")
      wk.add({
        -- Next Jumps
        { "]]", desc = "Next Conditional Start" },
        { "][", desc = "Next Conditional End" },
        { "}}", desc = "Next Function Start" },
        { "}{", desc = "Next Function End" },
        -- Previous Jumps
        { "[[", desc = "Prev Conditional Start" },
        { "[]", desc = "Prev Conditional End" },
        { "{{", desc = "Prev Function Start" },
        { "{}", desc = "Prev Function End" },
      })
    end,
  }
}
