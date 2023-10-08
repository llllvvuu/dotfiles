--- @type LazyPluginSpec
return {
  "ecthelionvi/NeoComposer.nvim",
  dependencies = { "kkharji/sqlite.lua" },
  keys = {
    --- @diagnostic disable-next-line: missing-fields
    { "Q", "<cmd>ToggleDelay<cr>" },
  },
  opts = {
    keymaps = {
      play_macro = "@",
      toggle_play_macro = "@",
    },
  },
}
