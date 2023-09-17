return {
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      {
        "<leader>xx",
        function()
          require("trouble").toggle()
        end,
        desc = "Open Trouble",
      },
      {
        "<leader>xw",
        function()
          require("trouble").open("workspace_diagnostics")
        end,
        desc = "Open Trouble Workspace Diagnostics",
      },
      {
        "<leader>xd",
        function()
          require("trouble").open("document_diagnostics")
        end,
        desc = "Open Trouble Document Diagnostics",
      },
    },
  },
}
