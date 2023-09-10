return {
  {
    "NeogitOrg/neogit",
    keys = {
      {
        "<leader>g",
        function()
          require("neogit").open()
        end,
        desc = "Open Neogit",
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "sindrets/diffview.nvim",
    },
    config = true,
  },
}
