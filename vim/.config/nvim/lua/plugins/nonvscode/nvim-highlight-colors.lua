--- @diagnostic disable: missing-fields

--- @type LazyPluginSpec
return {
  "brenoprata10/nvim-highlight-colors",
  event = { "BufReadPost", "BufNewFile" },
  config = true,
}
