require("keymap")

local map = vim.keymap.set

-- stylua: ignore
map("n", "<leader>c", require("utils").toggle_quickfix, { desc = "Toggle Qui[c]kfix" })
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
