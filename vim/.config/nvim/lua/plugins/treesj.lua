--- @diagnostic disable: missing-fields

--- @type LazyPluginSpec
return {
  "Wansmer/treesj",
  keys = {
    { "gS", "<Cmd>TSJSplit<CR>", desc = "Split Line (treesj)" },
    { "gJ", "<Cmd>TSJJoin<CR>", desc = "Join Line (treesj)" },
  },
  opts = {
    use_default_keymaps = false,
    max_join_length = 200,
  },
}
