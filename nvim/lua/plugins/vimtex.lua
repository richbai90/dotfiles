return {
  "lervag/vimtex",
  lazy = false,
  init = function()
    vim.g.vimtex_view_method = 'zathura'
    vim.g.vimtex_compiler_method = 'latexmk'
    vim.g.vimtex_quickfix_mode = 0

    -- Configure general latexmk options
    vim.g.vimtex_compiler_latexmk = {
      out_dir = 'out',
      options = {
        '-verbose',
        '-file-line-error',
        '-synctex=1',
        '-interaction=nonstopmode',
      }
    }

    -- Configure the default engine to LuaLaTeX
    vim.g.vimtex_compiler_latexmk_engines = {
      _ = '-lualatex'
    }
  end,
  config = function()
    -- Register Which-Key labels specifically for tex filetypes
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "tex",
      callback = function(event)
        local status_ok, wk = pcall(require, "which-key")
        if not status_ok then return end

        wk.add({
          { "<localleader>l",  group = "VimTeX",           buffer = event.buf },
          { "<localleader>li", desc = "Info",              buffer = event.buf },
          { "<localleader>lt", desc = "Table of Contents", buffer = event.buf },
          { "<localleader>lv", desc = "View PDF",          buffer = event.buf },
          { "<localleader>ll", desc = "Compile",           buffer = event.buf },
          { "<localleader>lk", desc = "Stop Compilation",  buffer = event.buf },
          { "<localleader>lc", desc = "Clean Aux Files",   buffer = event.buf },
          { "<localleader>le", desc = "Show Errors",       buffer = event.buf },
        })
      end,
    })
  end,
}
