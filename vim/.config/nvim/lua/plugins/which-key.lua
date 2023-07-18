return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = {
        presets = {
          operators = false,
        },
      },
    },
    config = function(_, opts)
      require("which-key").setup(opts)
      vim.keymap.set({ "n", "x" }, "<C-h>", "<cmd>WhichKey<CR>")
    end,
  },
}
