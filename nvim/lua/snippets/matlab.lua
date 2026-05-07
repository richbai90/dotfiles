-- ~/.config/nvim/lua/my-snippets/matlab.lua

local ls = require("luasnip")
local s = ls.snippet
local f = ls.function_node
local i = ls.insert_node
local extras = require("luasnip.extras")
local rep = extras.rep

-- ====================================================================
-- Snippets from matlab-separators.json
-- ====================================================================

-- Helper function to generate the text that fills the rest of the line
local function fill_line(char)
  local line_content = ls.variables.TM_CURRENT_LINE
  local text_width = vim.opt.textwidth:get()
  if text_width == 0 then text_width = 80 end -- Fallback

  local fill_len = text_width - #line_content
  if fill_len <= 0 then return "" end
  return string.rep(char, fill_len)
end

-- Reusable function to create a filler snippet
local function create_filler_snippet(trigger, char, description)
  return s({ trig = trigger, dscr = description }, {
    f(function() return fill_line(char) end),
    i(0),
  })
end

-- ====================================================================
-- Snippets from matlab-textformatting.json
-- ====================================================================

-- Helper function for the alignment snippets
local function align_helper(text, char)
  if not text or text == '' then return '' end
  local lines = vim.split(text, '\n')
  local max_pos = 0
  
  -- Find the maximum position of the character to align
  for _, line in ipairs(lines) do
    local pos = line:find(char, 1, true)
    if pos and pos > max_pos then
      max_pos = pos
    end
  end

  if max_pos == 0 then return text end

  -- Rebuild each line with padding
  local new_lines = {}
  for _, line in ipairs(lines) do
    local pos = line:find(char, 1, true)
    if pos then
      local prefix = line:sub(1, pos - 1)
      local suffix = line:sub(pos)
      table.insert(new_lines, string.rep(' ', max_pos - pos) .. prefix .. suffix)
    else
      table.insert(new_lines, line)
    end
  end

  return table.concat(new_lines, '\n')
end

-- Snippet that operates on the selected text
local function create_text_op_snippet(trigger, op_func, description, arg)
  return s({ trig = trigger, dscr = description }, {
    f(function(_, snip)
      -- TM_SELECTED_TEXT is available in the snip.env table
      local selected_text = snip.env.TM_SELECTED_TEXT or ""
      if arg then
        return op_func(selected_text, arg)
      else
        return op_func(selected_text)
      end
    end, {}),
  })
end


-- Now, we define all the snippets
return {
  -- From matlab-separators.json
  create_filler_snippet("--", "-", "Fill line end with '-'"),
  create_filler_snippet("==", "=", "Fill line end with '='"),
  create_filler_snippet("**", "*", "Fill line end with '*'"),

  -- From matlab-textformatting.json
  create_text_op_snippet("align%", align_helper, "Align comments ('%')", '%'),
  create_text_op_snippet("align=", align_helper, "Align equality symbols ('=')", '='),
  create_text_op_snippet("align=%", function(text)
    return align_helper(align_helper(text, '='), '%')
  end, "Align equality symbols and comments"),

  create_text_op_snippet("remSpace", function(text)
    return text:gsub(" ", "")
  end, "Removes space characters"),

  create_text_op_snippet("remDuplicateSpace", function(text)
    return text:gsub(" +", " ")
  end, "Removes duplicate space characters"),
  
  create_text_op_snippet("upperCase", string.upper, "Convert to upper case"),
  create_text_op_snippet("lowerCase", string.lower, "Convert to lower case"),
}
