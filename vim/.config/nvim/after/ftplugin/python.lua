local map = vim.keymap.set

map("n", "<leader>df", function()
  require("dap-python").test_method()
end, { desc = "Test Method" })

map("n", "<leader>da", function()
  require("dap-python").test_class()
end, { desc = "Test Method" })

map("n", "<leader>dv", function()
  require("dap-python").test_selection()
end, { desc = "Test Selection" })
