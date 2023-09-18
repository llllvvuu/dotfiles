vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

return {
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async", "nvim-treesitter" },
    event = "BufReadPost",
    opts = {
      {
        provider_selector = function()
          return { "lsp", "treesitter", "indent" }
        end,
      },
    },
    init = function()
      vim.keymap.set("n", "zR", function()
        require("ufo").openAllFolds()
      end)
      vim.keymap.set("n", "zM", function()
        require("ufo").closeAllFolds()
      end)
    end,
  },
}
