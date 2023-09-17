return {
  {
    "stevearc/aerial.nvim",
    event = "VeryLazy",
    keys = {
      { "{", "<cmd>AerialPrev<CR>", desc = "Prev function/interface" },
      { "}", "<cmd>AerialNext<CR>", desc = "Next function/interface" },
      { "<leader>a", "<cmd>AerialToggle! left<CR>", desc = "Open Aerial view" },
    },
    opts = {
      autojump = true,
      disable_max_size = 100000,
      open_automatic = true,
      show_guides = true,
      layout = {
        default_direction = "prefer_left",
      }
    },
    dependencies = {
      "nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
}