return {
  'Julian/lean.nvim',
  event = { 'BufReadPre *.lean', 'BufNewFile *.lean' },

  dependencies = {
  },

  ---@type lean.Config
  opts = {
    mappings = false, -- Disable defaults to use our prefixed versions
    graphics = { enabled = true }
  },

  config = function (_, opts)
    -- 1. Initialize the plugin with your opts
    require('lean').setup(opts)

    -- 2. Define your prefixed mappings
    local lean_mappings = {
      i = { '<Plug>(LeanInfoviewToggle)', 'Toggle Infoview' },
      p = { '<Plug>(LeanInfoviewPinTogglePause)', 'Pause Infoview' },
      r = { '<Plug>(LeanRestartFile)', 'Restart Lean File' },
      s = { '<Plug>(LeanInfoviewAcceptSuggestion)', 'Accept Suggestion' },
      v = { '<Plug>(LeanInfoviewViewOptions)', 'Infoview Options' },
      x = { '<Plug>(LeanInfoviewAddPin)', 'Add Pin' },
      c = { '<Plug>(LeanInfoviewClearPins)', 'Clear Pins' },
      dx = { '<Plug>(LeanInfoviewSetDiffPin)', 'Set Diff Pin' },
      dc = { '<Plug>(LeanInfoviewClearDiffPin)', 'Clear Diff Pin' },
      dd = { '<Plug>(LeanInfoviewToggleAutoDiffPin)', 'Toggle Auto Diff' },
      dt = { '<Plug>(LeanInfoviewToggleNoClearAutoDiffPin)', 'Toggle Auto Diff (No Clear)' },
      w = { '<Plug>(LeanInfoviewEnableWidgets)', 'Enable Widgets' },
      W = { '<Plug>(LeanInfoviewDisableWidgets)', 'Disable Widgets' },
      ['<Tab>'] = { '<Plug>(LeanGotoInfoview)', 'Jump to Infoview' },
      ['\\'] = { '<Plug>(LeanAbbreviationsReverseLookup)', 'Reverse Lookup Abbreviation' },
    }

    for key, map in pairs(lean_mappings) do
      vim.keymap.set('n', '<LocalLeader>l' .. key, map[1], { desc = 'Lean: ' .. map[2] })
    end

    -- 3. Register with Which-Key
    local wk = require("which-key")
    wk.add({
      { "<LocalLeader>l", group = "Lean" },
    })
  end
}
