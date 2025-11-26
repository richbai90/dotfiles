local functions = require('config.functions')
local keymap = vim.keymap.set
-- Remap d to be a true delete command by sending deleted text to the black hole register
-- keymap("n", "d", '"_d', { desc = "Delete without yanking" })
-- keymap("v", "d", '"_d', { desc = "Delete without yanking" })

-- Remap x to be the new cut command
-- keymap("n", "x", "d", { desc = "Cut" })
-- keymap("v", "x", "d", { desc = "Cut" })
-- keymap("n", "xx", "dd", { desc = "Cut" })
-- keymap("v", "xx", "dd", { desc = "Cut" })
keymap("n", "<Leader>zl", functions.CopyZoteroLink, { desc = "Zotcite: Copy Zotero attachment link" })
