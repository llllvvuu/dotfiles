--- @type LazyPluginSpec
return {
  "mrcjkb/haskell-tools.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
}
