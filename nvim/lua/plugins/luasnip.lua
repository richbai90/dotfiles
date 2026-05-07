return {
	"L3MON4D3/LuaSnip",
	-- follow latest release.
	version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	-- install jsregexp (optional!).
	build = "make install_jsregexp",
  keys = {
        {
      '<Tab>',
      function()
        if require('luasnip').expand_or_jumpable() then
          require('luasnip').expand_or_jump()
        else
          -- If not in a snippet, you can customize what <Tab> does.
          -- For example, just insert a literal tab.
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Tab>', true, true, true), 'n', true)
        end
      end,
      mode = 'i',
      silent = true,
      expr = true,
      desc = "Expand or jump in a snippet",
    },
    {
      '<S-Tab>',
      function()
        require('luasnip').jump(-1)
      end,
      mode = { 'i', 's' },
      silent = true,
      desc = "Jump backwards in a snippet",
    },
    {
      '<C-E>',
      function()
        if require('luasnip').choice_active() then
          require('luasnip').change_choice(1)
        else
          -- Optional: Fallback behavior for <C-E>
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-E>', true, true, true), 'n', true)
        end
      end,
      mode = 'i',
      silent = true,
      expr = true,
      desc = "Change to the next choice",
    },
    {
      '<C-E>',
      function()
        if require('luasnip').choice_active() then
          require('luasnip').change_choice(1)
        else
          -- Optional: Fallback behavior for <C-E> in select mode
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-E>', true, true, true), 'n', true)
        end
      end,
      mode = 's',
      silent = true,
      expr = true,
      desc = "Change to the next choice (select mode)",
    },
  },
  config = function(_, opts)
    -- This first line is important: it calls setup with the options from `opts`
    require("luasnip").setup(opts)

    -- ADD YOUR SNIPPET LOADING LOGIC HERE
    -- 1. Load VS Code snippets
    require("luasnip.loaders.from_vscode").lazy_load({
      paths = { vim.fn.expand("~/.vscode/extensions/nvim-snippets/") }, -- Your directory for JSON snippets
    })

    -- 2. Load custom Lua snippets for MATLAB
    require("luasnip").filetype_extend("matlab", { "all" })
    require("luasnip").add_snippets("matlab", require("snippets.matlab"))
    
    -- ADD YOUR CMP ACTIONS HERE
    -- This is a great place for them, as it's imperative setup logic
  end,
}
