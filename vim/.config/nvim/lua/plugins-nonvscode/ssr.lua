return {
  {
    "cshuaimin/ssr.nvim",
    keys = {
      {
        "<leader>%",
        function()
          require("ssr").open()
        end,
        mode = { "n", "x" },
        desc = "Structural Search + Replace",
      },
    },
  },
}
