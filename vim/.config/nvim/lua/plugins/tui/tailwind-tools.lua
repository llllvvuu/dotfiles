--- @diagnostic disable: missing-fields

--- @type LazyPluginSpec
return {
  "luckasRanarison/tailwind-tools.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = {
    document_color = {
      enabled = true,
      kind = "background",
    },
    conceal = {
      enabled = true,
    },
  },
}
