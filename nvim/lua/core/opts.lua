-- ~/.config/nvim/lua/core/options.lua

local opt = vim.opt -- for conciseness

-- line numbers
opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- line wrapping
opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true

-- cursor line
opt.cursorline = true

-- backspace
opt.backspace = 'start,eol,indent'

-- clipboard
opt.clipboard = 'unnamedplus'

-- split windows
opt.splitright = true
opt.splitbelow = true

vim.wo.relativenumber=true
