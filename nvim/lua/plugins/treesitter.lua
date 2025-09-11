return {
  "nvim-treesitter/nvim-treesitter",
  -- The build command is essential for Tree-sitter to work
  build = ":TSUpdate",
  dependencies = {
    -- Optional, but recommended for more powerful text objects
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  config = function()
    -- This is the standard setup function for nvim-treesitter
    require("nvim-treesitter.configs").setup({
      -- A list of parser names, or "all"
      -- :TSInstallInfo will show you all available parsers
      ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "javascript", "typescript", "rust" },

      -- Install parsers synchronously (blocks UI until installed)
      sync_install = false,

      -- Automatically install missing parsers when entering buffer
      -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
      auto_install = true,

      -- The main feature of Tree-sitter. Without this, it does nothing.
      highlight = {
        enable = true,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
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
    })
  end,
}
