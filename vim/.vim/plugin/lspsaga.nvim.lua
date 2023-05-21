local keymap = vim.keymap.set

require("lspsaga").setup({})

keymap("n", "<leader>d", "<cmd>Lspsaga lsp_finder<CR>")
keymap({"n","v"}, "ga", "<cmd>Lspsaga code_action<CR>")
keymap("n", "gr", "<cmd>Lspsaga rename<CR>")
keymap("n", "ge", "<cmd>Lspsaga show_buf_diagnostics<CR>")
keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")
keymap("n", "go", "<cmd>Lspsaga outline<CR>")
keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>")
