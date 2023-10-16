--- @diagnostic disable: missing-fields

--- @type LazyPluginSpec
return {
  "stevearc/aerial.nvim",
  event = "VeryLazy",
  keys = {
    { "{", "<cmd>AerialPrev<CR>", desc = "Prev function/interface" },
    { "}", "<cmd>AerialNext<CR>", desc = "Next function/interface" },
    {
      "<leader>O",
      "<cmd>AerialToggle! left<CR>",
      desc = "Toggle [O]utline (aerial.nvim)",
    },
  },
  opts = {
    autojump = true,
    disable_max_size = 250000,
    open_automatic = true,
    show_guides = true,
    layout = {
      default_direction = "prefer_right",
    },
  },
  dependencies = {
    "nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
}
