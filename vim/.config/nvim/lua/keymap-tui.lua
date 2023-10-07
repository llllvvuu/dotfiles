require("keymap")

local map = vim.keymap.set

local function toggle_quickfix()
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
local function visual_range()
  local l1 = vim.fn.line("v") or 0
  local l2 = vim.fn.line(".") or l1
  if l1 > l2 then
    return l2 - 1, l1
  else
    return l1 - 1, l2
  end
end

local function surround_in_quotes()
  local start, end_ = visual_range()
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

local function toggle_commas()
  local start, end_ = visual_range()
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

map(
  "v",
  "q",
  surround_in_quotes,
  { noremap = true, silent = true, desc = "Surround each line in quotes" }
)
map(
  "v",
  "m",
  toggle_commas,
  { noremap = true, silent = true, desc = "Toggle co[m]mas after each line" }
)

map(
  "n",
  "<leader>c",
  toggle_quickfix,
  { desc = "Toggle Qui[c]kfix", noremap = true, silent = true }
)
map(
  "n",
  "<C-q>",
  ":cfdo e<cr>",
  { desc = "Open all Quickfix files", noremap = true, silent = true }
)
map(
  "n",
  "]q",
  "<cmd>cn<cr>",
  { desc = "Next [q]uickfix", noremap = true, silent = true }
)
map(
  "n",
  "[q",
  "<cmd>cp<cr>",
  { desc = "Previous [q]uickfix", noremap = true, silent = true }
)

map("n", "<leader>p", "<cmd>pclose<cr>", { desc = "Close [p]review window" })

map("n", "<leader>w", "<cmd>w<cr>", { desc = "write buffer (save)" })
map("n", "<leader>q", "<cmd>bp|bd #<cr>", { desc = "quit buffer" })

map("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
map("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

map("v", "<", "<gv")
map("v", ">", ">gv")

map({ "i", "s" }, "jk", "<Esc>")
map("t", "jk", [[<C-\><C-n>]])
