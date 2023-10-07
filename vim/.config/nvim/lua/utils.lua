local M = {}

M.toggle_quickfix = function()
  local win_info = vim.fn.getwininfo()
  for _, win in pairs(win_info or {}) do
    if win.quickfix == 1 then
      vim.cmd("cclose")
      return
    end
  end
  vim.cmd("copen")
end

--- @return number, number
M.visual_range = function()
  local l1 = vim.fn.line("v") or 0
  local l2 = vim.fn.line(".") or l1
  if l1 > l2 then
    return l2 - 1, l1
  else
    return l1 - 1, l2
  end
end

M.surround_in_quotes = function()
  local start, end_ = M.visual_range()
  local lines = vim.api.nvim_buf_get_lines(0, start, end_, false)

  for i, line in ipairs(lines) do
    if line:len() ~= 0 then
      local leading_whitespace = line:match("^(%s*)")
      --- @type string
      local content = line:match("^%s*(.-)%s*$")
      if content:byte(1) == 34 and content:byte(-1) == 34 then
        content = content:sub(2, -2)
        lines[i] = leading_whitespace .. content
      else
        lines[i] = leading_whitespace .. '"' .. content .. '"'
      end
    end
  end

  vim.api.nvim_buf_set_lines(0, start, end_, false, lines)
end

M.toggle_commas = function()
  local start, end_ = M.visual_range()
  local lines = vim.api.nvim_buf_get_lines(0, start, end_, false)

  for i, line in ipairs(lines) do
    if line:len() ~= 0 then
      if line:sub(-1) == "," then
        lines[i] = line:sub(1, -2)
      else
        lines[i] = line .. ","
      end
    end
  end

  vim.api.nvim_buf_set_lines(0, start, end_, false, lines)
end

return M
