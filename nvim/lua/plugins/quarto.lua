return {
  {
    "quarto-dev/quarto-nvim",
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
      "jpalardy/vim-slime",
    },
    opts = {
      lspFeatures = {
        enabled = true,
        languages = { 'python', 'r', 'julia', 'bash', 'matlab' }, -- Added matlab
        chunks = "curly",                                         -- This matches the ```{lang} syntax
        diagnostics = {
          enabled = true,
          triggers = { "BufWritePost" },
        },
        completion = {
          enabled = true,
        },
      },
      codeRunner = {
        enabled = true,
        default_method = 'slime', -- Or 'molten' if you want in-nvim outputs
      },
    },
    keys = {
      { '<leader>qp', ':QuartoPreview<CR>',                               desc = 'Quarto Preview', mode = 'n' },
      { '<leader>qr', ':QuartoRender<CR>',                                desc = 'Quarto Render',  mode = 'n' },
      { "<leader>rc", function() require("quarto.runner").run_cell() end, desc = "Run Cell" },
      { "<leader>ra", function() require("quarto.runner").run_all() end,  desc = "Run All Cells" },
      { "<leader>rl", function() require("quarto.runner").run_line() end, desc = "Run Line" },
    },
    config = function(_, opts)
      local quarto = require("quarto")
      quarto.setup(opts)

      -- Automatically activate otter when opening a quarto file
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "quarto",
        callback = function()
          require("otter").activate({ "python", "r", "matlab", "bash" }, true, true, nil)
        end,
      })
    end,
  },
  {
    "jpalardy/vim-slime",
    init = function()
      -- These must be set before the plugin loads
      vim.g.slime_target = "tmux"
      vim.g.slime_bracketed_paste = 1
      vim.g.slime_no_mappings = 1 -- We'll use quarto's runner instead
      -- This makes slime work without asking you for the pane every time
      vim.g.slime_default_config = {
        socket_name = "default",
        target_pane = "{last}"
      }
      vim.g.slime_dont_ask_default = 1
    end,
    config = function()
      -- Optional: manually define a "Send to Slime" if you want to use it outside Quarto
      vim.keymap.set('x', '<leader>s', '<Plug>SlimeRegionSend', { desc = 'Slime Send' })
    end,
  },
  {
    'jmbuhr/otter.nvim',
    opts = {},
  }
}
