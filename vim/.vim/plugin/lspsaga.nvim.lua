local keymap = vim.keymap.set

require("lspsaga").setup({})

keymap("n", "<leader>d", "<cmd>Lspsaga lsp_finder<CR>")
keymap("n", "<leader>t", "<cmd>Lspsaga peek_definition<CR>")
keymap({"n","v"}, "ga", "<cmd>Lspsaga code_action<CR>")
keymap("n", "gr", "<cmd>Lspsaga rename<CR>")
keymap("n", "gR", "<cmd>Lspsaga rename ++project<CR>")
keymap("n", "ge", "<cmd>Lspsaga show_buf_diagnostics<CR>")
keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")
keymap("n", "go", "<cmd>Lspsaga outline<CR>")
keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>")
keymap("n", "<C-t>", "<cmd>Lspsaga term_toggle<CR>")


local function repl(glob, cmd)
  vim.api.nvim_create_autocmd(
    { "BufRead", "BufNewFile" },
    {
      pattern = glob,
      callback = function ()
        keymap(
          "n",
          "<C-i>",
          "<cmd>Lspsaga term_toggle LANG=en_US.UTF8\\ "
          .. cmd .. "\\ " .. vim.api.nvim_buf_get_name(0)
          .."<CR>"
        )
      end
    }
  )
end

repl("*.hs", "cabal\\ v2-repl")
repl("*.py", "python\\ -i")
