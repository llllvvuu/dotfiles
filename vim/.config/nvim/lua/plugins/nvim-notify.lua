return {
  "rcarriga/nvim-notify",
  event = "VeryLazy",
  keys = {
    {
      "<leader>d",
      function()
        require("notify").dismiss()
      end,
      desc = "Dismiss All Notifications",
    }
  },
  init = function()
    vim.notify = require("notify")
  end,
}
