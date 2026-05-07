local builtin = require('telescope.builtin')

return {
  'nvim-telescope/telescope.nvim',
  branch = 'master',
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-ui-select.nvim' },
  keys = {
    { '<leader>ff', builtin.find_files,          desc = 'Telescope find files' },
    { '<leader>fg', builtin.live_grep,           desc = 'Telescope live grep' },
    { '<leader>fb', builtin.buffers,             desc = 'Telescope buffers' },
    { '<leader>fh', builtin.help_tags,           desc = 'Telescope help tags' },
    { '<leader>fc', builtin.current_buffer_tags, desc = 'Telescope find ctags in open buffer' },
    { '<leader>fC', builtin.tags,                desc = 'Telescope find ctags' },
  },

  opts = {
    extensions = {
      ["ui-select"] = {
        require("telescope.themes").get_dropdown {

        }
      }
    }
  },

  config = function()
    require("telescope").load_extension("ui-select")
  end
}
