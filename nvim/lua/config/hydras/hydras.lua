local M = {}

function M.setup()
  -- Get the absolute path to the 'lua/config/hydras/' directory
  local hydras_dir = vim.fn.stdpath("config") .. "/lua/config/hydras"

  -- Scandir returns a list of filenames
  local handle = vim.fs.dir(hydras_dir)
  if not handle then
    vim.notify("Hydra loader: Could not find directory " .. hydras_dir, vim.log.levels.WARN)
    return
  end

  while true do
    local name, type = vim.fs.dir(hydras_dir)
    if not name then break end

    -- Only load .lua files and ignore init.lua to prevent circular loops
    if type == "file" and name:match("%.lua$") and name ~= "init.lua" then
      local module_name = name:gsub("%.lua$", "")
      require("config.hydras." .. module_name)
    end
  end
end

-- Execute the setup
M.setup()

return M
