--- @type LazyPluginSpec
return {
  "Julian/lean.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "nvim-lua/plenary.nvim",
  },
  ft = { "lean", "lean4" },
  opts = { mappings = true },
}
