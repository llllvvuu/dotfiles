require("keymap")

local map = vim.keymap.set

map("n", "<leader>f", function()
  require("vscode-neovim").call("workbench.action.quickOpen")
end)
map("n", "<leader>a", function()
  require("vscode-neovim").call("editor.action.quickFix")
end)
map("n", "<leader>s", function()
  require("vscode-neovim").call("workbench.action.gotoSymbol")
end)
map("n", "<leader>lf", function()
  require("vscode-neovim").call("editor.action.formatDocument")
end)
map("x", "<leader>lf", function()
  require("vscode-neovim").call("editor.action.formatSelection")
end)
map("n", "gD", function()
  require("vscode-neovim").call("editor.action.revealDeclaration")
end)
map("n", "gr", function()
  require("vscode-neovim").call("editor.action.referenceSearch.trigger")
end)
map("n", "gy", function()
  require("vscode-neovim").call("editor.action.goToTypeDefinition")
end)
map("n", "gi", function()
  require("vscode-neovim").call("editor.action.goToImplementation")
end)
map("n", "gcc", function()
  require("vscode-neovim").call("editor.action.commentLine")
end)
map("x", "gc", function()
  require("vscode-neovim").call("editor.action.commentLine")
  vim.api.nvim_input("<esc>")
end)
map("n", "<leader>r", function()
  require("vscode-neovim").call("editor.action.rename")
end)
map("n", "<leader>/", function()
  require("vscode-neovim").notify("workbench.action.findInFiles")
end)
map("i", "<C-k>", function()
  require("vscode-neovim").call("editor.action.triggerParameterHints")
end, { desc = "Signature Help" })

map("n", "<leader>w", function()
  require("vscode-neovim").notify("workbench.action.files.save")
end)
map("n", "<leader>q", function()
  require("vscode-neovim").notify("workbench.action.closeActiveEditor")
end)
map("n", "[b", function()
  require("vscode-neovim").notify("workbench.action.previousEditor")
end)
map("n", "]b", function()
  require("vscode-neovim").notify("workbench.action.nextEditor")
end)
map("n", "[d", function()
  require("vscode-neovim").notify("editor.action.marker.prev")
end)
map("n", "]d", function()
  require("vscode-neovim").notify("editor.action.marker.next")
end)
map("n", "[D", function()
  require("vscode-neovim").notify("editor.action.marker.prevInFiles")
end)
map("n", "]D", function()
  require("vscode-neovim").notify("editor.action.marker.nextInFiles")
end)