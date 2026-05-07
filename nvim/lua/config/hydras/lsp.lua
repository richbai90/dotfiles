local Hydra = require("hydra")
Hydra({
   name = 'Block Navigation',
   hint = [[
 ^ ^      Jumps
 _j_: Next Function   _k_: Prev Function
 _J_: Next Class      _K_: Prev Class
 ^ ^      _<Esc>_ : Exit
]],
   config = {
      color = 'pink',
      invoke_on_body = true,
   },
   mode = 'n',
   body = '<leader>b',
   heads = {
      -- Requires nvim-treesitter-textobjects
      { 'j', function() require("nvim-treesitter.textobjects.move").goto_next_start("@function.outer") end },
      { 'k', function() require("nvim-treesitter.textobjects.move").goto_previous_start("@function.outer") end },
      { 'J', function() require("nvim-treesitter.textobjects.move").goto_next_start("@class.outer") end },
      { 'K', function() require("nvim-treesitter.textobjects.move").goto_previous_start("@class.outer") end },
      { '<Esc>', nil, { exit = true } },
   }
})
