return {
  "kylechui/nvim-surround",
  version = "*",
  -- 1. Define the keys to trigger lazy-loading
  keys = {
    { "s",      "<Plug>(nvim-surround-normal)",          desc = "Add surrounding (motion)",           mode = "n" },
    { "ss",     "<Plug>(nvim-surround-normal-cur)",      desc = "Add surrounding (line)",             mode = "n" },
    { "S",      "<Plug>(nvim-surround-normal-line)",     desc = "Add surrounding (motion, new line)", mode = "n" },
    { "SS",     "<Plug>(nvim-surround-normal-line-cur)", desc = "Add surrounding (line, new line)",   mode = "n" },
    { "sd",     "<Plug>(nvim-surround-delete)",          desc = "Delete surrounding",                 mode = "n" },
    { "sc",     "<Plug>(nvim-surround-change)",          desc = "Change surrounding",                 mode = "n" },
    { "s",      "<Plug>(nvim-surround-visual)",          desc = "Add surrounding (visual)",           mode = "x" },
    { "S",      "<Plug>(nvim-surround-visual-line)",     desc = "Add surrounding (visual line)",      mode = "x" },
    { "<C-g>s", "<Plug>(nvim-surround-insert)",          desc = "Add surrounding (insert)",           mode = "i" },
    { "<C-g>S", "<Plug>(nvim-surround-insert-line)",     desc = "Add surrounding (insert line)",      mode = "i" },
  },
  -- 2. Disable defaults BEFORE the plugin loads
  init = function()
    vim.g.nvim_surround_no_insert_mappings = true
    vim.g.nvim_surround_no_normal_mappings = true
    vim.g.nvim_surround_no_visual_mappings = true
  end,
  -- 3. Required to call the setup function automatically
  opts = {},
}
