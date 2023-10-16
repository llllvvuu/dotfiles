--- @type LazyPluginSpec
return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  opts = {
    options = {
      diagnostics = "nvim_lsp",
    },
  },
  config = function(_, opts)
    local buf = require("bufferline")
    buf.setup(opts)

    local map = vim.keymap.set
    map("n", "[b", function()
      buf.cycle(-1)
    end, { desc = "Prev buffer" })
    map("n", "]b", function()
      buf.cycle(1)
    end, { desc = "Next buffer" })
  end,
}
