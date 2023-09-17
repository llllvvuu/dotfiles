local map = vim.keymap.set

map("n", "<leader>o", function()
  require("vscode-neovim").call("workbench.action.quickOpen")
end)
map("n", "<leader>la", function()
  require("vscode-neovim").call("editor.action.quickFix")
end)

map("v", "<", "<gv")
map("v", ">", ">gv")

map("n", "<leader>w", function()
  require("vscode-neovim").notify("workbench.action.files.save")
end)
map("n", "<leader>q", function()
  require("vscode-neovim").notify("workbench.action.closeActiveEditor")
end)
