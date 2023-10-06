return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = { { "<leader>n", ":Neotree<Cr>", desc = "Open [N]eotree" } },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
  },
}
