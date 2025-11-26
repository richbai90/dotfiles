local builtin = require('telescope.builtin')
-- vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
-- vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
-- vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
-- vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    { '<leader>ff', builtin.find_files,          desc = 'Telescope find files' },
    { '<leader>fg', builtin.live_grep,           desc = 'Telescope live grep' },
    { '<leader>fb', builtin.buffers,             desc = 'Telescope buffers' },
    { '<leader>fh', builtin.help_tags,           desc = 'Telescope help tags' },
    { '<leader>fc', builtin.current_buffer_tags, desc = 'Telescope find ctags in open buffer' },
    { '<leader>fC', builtin.tags,                desc = 'Telescope find ctags' },
  }
}
