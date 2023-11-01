local ht = require("haskell-tools")
local bufnr = vim.api.nvim_get_current_buf()

ht.lsp.start()

-- stylua: ignore start
vim.keymap.set('n', '<space>lc', vim.lsp.codelens.run, { desc = 'Run [c]ode lens', buffer = bufnr })
vim.keymap.set('n', '<space>lg', ht.hoogle.hoogle_signature, { desc = 'Hoo[g]le signature', buffer = bufnr })
vim.keymap.set('n', '<space>le', ht.lsp.buf_eval_all, { desc = 'Buf [e]val all', buffer = bufnr })
vim.keymap.set('n', '<leader>lr', ht.repl.toggle, { desc = "Toggle [r]epl", buffer = bufnr })
vim.keymap.set('n', '<leader>lb', function()
  ht.repl.toggle(vim.api.nvim_buf_get_name(0))
end, { desc = "Toggle repl for [b]uffer", buffer = bufnr })
vim.keymap.set('n', '<leader>lq', ht.repl.quit, { desc = "quit repl", buffer = bufnr })
-- stylua: ignore end
