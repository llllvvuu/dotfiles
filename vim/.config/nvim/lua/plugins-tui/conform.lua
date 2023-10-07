--- @type LazyPluginSpec
return {
  "stevearc/conform.nvim",
  keys = {
    --- @diagnostic disable-next-line: missing-fields
    {
      "<leader>lf",
      function()
        require("conform").format({ lsp_fallback = true })
      end,
      desc = "LSP Format Document",
    },
  },
}
