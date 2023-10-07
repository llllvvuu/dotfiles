--- @type LazyPluginSpec
return {
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
    local wk = require("which-key")
    wk.setup(opts)
    vim.keymap.set({ "n", "x" }, "<C-h>", "<cmd>WhichKey<CR>")
    wk.register({
      ["<leader>l"] = { name = "lsp", _ = "which_key_ignore" },
      ["<leader>x"] = { name = "trouble.nvim", _ = "which_key_ignore" },
      ["<leader>d"] = { name = "debugger (DAP)", _ = "which_key_ignore" },
    })
  end,
}
