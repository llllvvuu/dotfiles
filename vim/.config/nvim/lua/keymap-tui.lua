require("keymap")

local map = vim.keymap.set

function toggle_quickfix()
  local win_info = vim.fn.getwininfo()
  for _, win in pairs(win_info) do
    if win.quickfix == 1 then
      vim.cmd("cclose")
      return
    end
  end
  vim.cmd("copen")
end

function surround_in_quotes()
  local lines = vim.api.nvim_buf_get_lines(
    0,
    vim.fn.line("'<") - 1,
    vim.fn.line("'>"),
    false
  )

  for i, line in ipairs(lines) do
    local leading_whitespace = line:match("^(%s*)")
    local content = line:match("^%s*(.-)%s*$")
    lines[i] = leading_whitespace .. '"' .. content .. '"'
  end

  vim.api.nvim_buf_set_lines(
    0,
    vim.fn.line("'<") - 1,
    vim.fn.line("'>"),
    false,
    lines
  )
end

function toggle_commas()
  local lines = vim.api.nvim_buf_get_lines(
    0,
    vim.fn.line("'<") - 1,
    vim.fn.line("'>"),
    false
  )

  for i, line in ipairs(lines) do
    if line:sub(-1) == "," then
      -- remove the comma if it's the last character
      lines[i] = line:sub(1, -2)
    else
      -- add a comma at the end if there isn't one
      lines[i] = line .. ","
    end
  end

  vim.api.nvim_buf_set_lines(
    0,
    vim.fn.line("'<") - 1,
    vim.fn.line("'>"),
    false,
    lines
  )
end

map(
  "v",
  "q",
  ":lua surround_in_quotes()<CR>",
  { noremap = true, silent = true, desc = "Surround each line in quotes" }
)
map(
  "v",
  "m",
  ":lua toggle_commas()<CR>",
  { noremap = true, silent = true, desc = "Toggle co[m]mas after each line" }
)

map(
  "n",
  "<leader>c",
  toggle_quickfix,
  { desc = "Toggle Qui[c]kfix", noremap = true, silent = true }
)
map("n", "<C-q>", ":cfdo e<cr>", { desc = "Open all Quickfix files", noremap = true, silent = true })
map("n", "]q", "<cmd>cn<cr>", { desc = "Next [q]uickfix", noremap = true, silent = true })
map("n", "[q", "<cmd>cp<cr>", { desc = "Previous [q]uickfix", noremap = true, silent = true })

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
