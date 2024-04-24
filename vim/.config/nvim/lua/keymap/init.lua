local map = vim.keymap.set

map("n", "gh", "0", { desc = "Beginning of line" })
map("n", "gs", "^", { desc = "first non-whitespace character" })
map("n", "gl", "$", { desc = "End of line" })
map("n", "[g", "g;", { desc = "Previous chan[g]e" })
map("n", "]g", "g,", { desc = "Next chan[g]e" })
map("n", "<leader>e", "<C-w>c", { desc = "exit window" })
map("n", "<D-v>", '"+p', { desc = "Paste from system clipboard" })
map("i", "<D-v>", "<C-r>+", { desc = "Paste from system clipboard" })
map("n", "<C-w>q", function() end, { desc = "quit" })

-- stylua: ignore start
map("v", "q", require("utils").surround_in_quotes, { desc = "Surround each line in quotes" })
map("v", "m", require("utils").toggle_commas, { desc = "Toggle co[m]mas after each line" })
-- stylua: ignore end

map("v", "<", "<gv")
map("v", ">", ">gv")
