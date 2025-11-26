local M = {}

function M.CopyZoteroLink()
  local ok, zotcite_get = pcall(require, "zotcite.get")
  if not ok then
    vim.notify("Could not load zotcite module.", vim.log.levels.ERROR, { title = "Keymap Error" })
    return
  end

  local zotkey = zotcite_get.citation_key()

  if not zotkey or zotkey == "" then
    vim.notify("No Zotcite key found under cursor.", vim.log.levels.WARN, { title = "Zotcite" })
    return
  end

  -- This is the callback function that will handle the result
  local function handle_path(_, idx)
    -- This internal table `sel_list` is populated by PDFPath before the callback
    if idx and zotcite_get.sel_list and zotcite_get.sel_list[idx] then
      local path = zotcite_get.sel_list[idx]
      vim.fn.setreg('+', path) -- Copy to clipboard
      vim.notify("Copied Zotero link: " .. path, vim.log.levels.INFO, { title = "Zotcite" })
    else
      -- This handles cases where there's no attachment or the user cancels the selection
      vim.notify("No attachment found or selected for this reference.", vim.log.levels.WARN, { title = "Zotcite" })
    end
  end

  -- Call PDFPath and get its return value
  local result = zotcite_get.PDFPath(zotkey, handle_path)

  -- **This is the crucial part:** if the result is a string, it means there was
  -- only one attachment and the callback was NOT used. We need to handle it here.
  if type(result) == "string" and result ~= "" then
    vim.fn.setreg('+', result) -- Copy the path directly
    vim.notify("Copied Zotero link: " .. result, vim.log.levels.INFO, { title = "Zotcite" })
  end
end

return M
