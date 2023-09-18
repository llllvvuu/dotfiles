return {
  {
    "Wansmer/treesj",
    keys = {
      { "gS", "<Cmd>TSJSplit<CR>", desc = "Tree-sitter split" },
      { "gJ", "<Cmd>TSJJoin<CR>", desc = "Tree-sitter join" },
    },
    opts = {
      use_default_keymaps = false,
      max_join_length = 80,
    },
  },
}
