return {
  "nvim-treesitter/nvim-treesitter",
  -- The build command is essential for Tree-sitter to work
  build = ":TSUpdate",
  dependencies = {
    -- Optional, but recommended for more powerful text objects
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  -- Replaced 'config = function()' with the 'opts' table
  opts = {
    -- A list of parser names, or "all"
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "javascript", "typescript", "rust" },

    -- Install parsers synchronously (blocks UI until installed)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    auto_install = true,

    -- The main feature of Tree-sitter. Without this, it does nothing.
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },

    -- Optional: Configuration for other Tree-sitter modules
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["aa"] = "@parameter.outer",
          ["ia"] = "@parameter.inner",
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
    },
  },
  -- Note: If custom execution logic requires a config function, use the following syntax to pass the merged opts:
  -- config = function(_, opts)
  --   require("nvim-treesitter.configs").setup(opts)
  -- end,
}
