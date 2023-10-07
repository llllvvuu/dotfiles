require("keymap")

local map = vim.keymap.set

-- stylua: ignore start
map("v", "q", require("utils").surround_in_quotes, { desc = "Surround each line in quotes" })
map("v", "m", require("utils").toggle_commas, { desc = "Toggle co[m]mas after each line" })

map("n", "<leader>c", require("utils").toggle_quickfix, { desc = "Toggle Qui[c]kfix" })
-- stylua: ignore end
map("n", "<C-q>", ":cfdo e<cr>", { desc = "Open all Quickfix files" })
map("n", "]q", "<cmd>cn<cr>", { desc = "Next [q]uickfix" })
map("n", "[q", "<cmd>cp<cr>", { desc = "Previous [q]uickfix" })

map("n", "<leader>p", "<cmd>pclose<cr>", { desc = "Close [p]review window" })

map("n", "<leader>w", "<cmd>w<cr>", { desc = "write buffer (save)" })
map("n", "<leader>q", "<cmd>bp|bd #<cr>", { desc = "quit buffer" })

map("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
map("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })

map("n", "<leader>1", ':!"%:p"<CR>', { desc = "Execute file" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

map("v", "<", "<gv")
map("v", ">", ">gv")

map({ "i", "s" }, "jk", "<Esc>")
map("t", "jk", [[<C-\><C-n>]])
