-- nvim/lua/core/autocmds.lua

local augroup = vim.api.nvim_create_augroup("user_cmds", { clear = true })

-- Set the Python host program after plugins have loaded
vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  group = augroup,
  desc = "Set python3_host_prog after venv activation",
  callback = function()
    if vim.fn.executable("python3") == 1 then
      vim.g.python3_host_prog = vim.fn.exepath('python3')
    end
  end,
})


-- The name of the tags file to update (e.g., in the project root)
local TAGS_FILE = "tags"

-- Define a function to update the tags file
local function update_tags_file()
  -- The filename of the current buffer being saved
  local filename = vim.fn.expand("%:p")

  -- 1. Use the ctags append command to update/re-index only the current file.
  --    -a: Append to the tags file.
  --    --exclude: Excludes the main tags file from being processed.
  --    --tag-relative=yes: Use file paths relative to the tags file location.
  --    --file-scope=no: To avoid duplicate tags if you use both local and global tags.
  --    :! : Runs the command in the background (important for non-blocking save)

  -- First, delete existing tags for the current file (if they exist)
  -- 'silent!' prevents non-existent file errors from showing up.
  vim.cmd('silent! !ctags --delete-tags="' .. filename .. '" --file-scope=no --tag-relative=yes -f ' .. TAGS_FILE)

  -- Second, append the new tags for the current file
  -- The -a (append) flag is usually implicit when using --delete-tags, but specifying it is safer.
  vim.cmd('silent! !ctags -a --file-scope=no --tag-relative=yes -f ' .. TAGS_FILE .. ' ' .. filename .. ' &')
end

-- Create the autocommand group
vim.api.nvim_create_augroup("AutoTagsUpdate", { clear = true })

-- Set the autocommand: on saving a file
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  group = "AutoTagsUpdate",
  -- Pattern for files you want to index (adjust as needed for your languages)
  pattern = { "*.c", "*.cpp", "*.h", "*.py", "*.lua", "*.js", "*.ts", "*.go" },
  callback = update_tags_file,
})

-- NOTE: This setup assumes your 'tags' file is in the current working directory.
-- If you need the tags file in a specific project root, you'll need to
-- incorporate logic to find the project root directory first (e.g., using `vim.fn.finddir`).
