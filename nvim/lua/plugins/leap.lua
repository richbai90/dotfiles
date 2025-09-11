return {
  'ggandor/leap.nvim',
  config = function()
    local leap = require('leap')
    leap.set_default_mappings()

    -- This makes the built-in f, F, t, and T motions use Leap
    vim.keymap.set({ "n", "x", "o" }, "f", "<Plug>(leap-forward-to)")
    vim.keymap.set({ "n", "x", "o" }, "F", "<Plug>(leap-backward-to)")
    vim.keymap.set({ "n", "x", "o" }, "t", "<Plug>(leap-forward-till)")
    vim.keymap.set({ "n", "x", "o" }, "T", "<Plug>(leap-backward-till)")

    leap.opts.equivalence_classes = { ' \t\r\n', '([{', ')]}', '\'"`' }
    require('leap.user').set_repeat_keys('<enter>', '<backspace>')
  end

}
