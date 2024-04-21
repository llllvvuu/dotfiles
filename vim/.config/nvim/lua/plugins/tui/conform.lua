--- @type LazyPluginSpec
return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "black" },
      javascript = { { "prettierd", "prettier" } },
      javascriptreact = { { "prettierd", "prettier" } },
      typescript = { { "prettierd", "prettier" } },
      typescriptreact = { { "prettierd", "prettier" } },
      markdown = { { "prettierd", "prettier" } },
      json = { { "prettierd", "prettier" } },
      rust = { "rustfmt" },
    },
  },
  keys = {
    --- @diagnostic disable-next-line: missing-fields
    {
      "<leader>lf",
      function()
        require("conform").format({ lsp_fallback = true })
      end,
      mode = { "n", "x" },
      desc = "LSP Format",
    },
  },
}
