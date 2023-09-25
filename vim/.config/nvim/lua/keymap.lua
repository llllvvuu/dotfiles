local map = vim.keymap.set

map("n", "gh", "0", { desc = "Beginning of line" })
map("n", "gs", "^", { desc = "first non-whitespace character" })
map("n", "gl", "$", { desc = "End of line" })
map("n", "[g", "g;", { desc = "Previous change" })
map("n", "]g", "g,", { desc = "Next change" })
