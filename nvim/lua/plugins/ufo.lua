return {
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    event = "BufReadPost", -- Load when opening a file
    opts = {
      provider_selector = function(bufnr, filetype, buftype)
        -- Forces TreeSitter for all filetypes, falling back to indent
        return { "treesitter", "indent" }
      end,
    },
    keys = {
      -- Fold / Unfold (Toggle)
      { "<leader>zz", "za", desc = "Fold Toggle (Current)", remap = true },

      -- Fold All
      {
        "<leader>zf",
        function() require("ufo").closeAllFolds() end,
        desc = "Fold All"
      },

      -- Unfold All
      {
        "<leader>zu",
        function() require("ufo").openAllFolds() end,
        desc = "Unfold All (Open)"
      },

      -- Preview Fold (Optional but very useful)
      {
        "<leader>zp",
        function()
          local winid = require('ufo').peekFoldedLinesUnderCursor()
          if not winid then
            vim.lsp.buf.hover()
          end
        end,
        desc = "Peek Fold",
      },
    },
    init = function()
      -- These settings are required for UFO to function correctly
      vim.o.foldcolumn = "1" -- Show fold indicators in the gutter
      vim.o.foldlevel = 99   -- Start with all folds open
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
    end,
    config = function(_, opts)
      require("ufo").setup(opts)
    end,
  },
}
