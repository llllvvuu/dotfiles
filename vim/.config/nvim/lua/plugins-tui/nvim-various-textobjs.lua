return {
  {
    "chrisgrieser/nvim-various-textobjs",
    event = "VeryLazy",
    init = function()
      vim.keymap.set(
        { "o", "x" },
        "as",
        '<cmd>lua require("various-textobjs").subword(false)<CR>'
      )
      vim.keymap.set(
        { "o", "x" },
        "is",
        '<cmd>lua require("various-textobjs").subword(true)<CR>'
      )
    end,
  },
}
