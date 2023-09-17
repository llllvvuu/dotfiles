return {
  "rcarriga/nvim-notify",
  event = "VeryLazy",
  keys = {
    {
      "<leader><leader>",
      function()
        require("notify").dismiss()
      end,
      desc = "Dismiss All Notifications",
    },
  },
  init = function()
    vim.notify = require("notify")
  end,
}
