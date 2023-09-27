return {
  {
    "stevearc/conform.nvim",
    keys = {
      {
        "<leader>lf",
        function()
          require("conform").format({ lsp_fallback = true })
        end,
        desc = "LSP Format Document",
      },
    },
  },
}
