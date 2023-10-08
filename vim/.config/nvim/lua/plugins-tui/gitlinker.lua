return {
  "linrongbin16/gitlinker.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader><C-g>y", function()
      require('gitlinker').link({
        action = require("gitlinker.actions").system,
      })
    end, desc = "gitlinker" },
    { "<leader>gy", function()
      local lstart, lend = vim.fn.line("v") or 0, vim.fn.line(".") or 0
      if lstart > lend then
        lstart, lend = lend, lstart
      end
      require('gitlinker').link({
        action = require("gitlinker.actions").system,
        lstart = lstart,
        lend = lend,
      })
    end, mode = "x", desc = "gitlinker" },
  },
  opts = { mapping = false },
}
