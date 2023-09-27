return {
  {
    "aznhe21/actions-preview.nvim",
    keys = {
      {
        "<leader>a",
        function()
          require("actions-preview").code_actions()
        end,
        desc = "LSP code [a]ctions preview",
        mode = { "n", "v" },
      },
    },
  },
}
