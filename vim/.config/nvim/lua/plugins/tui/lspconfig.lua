--- @type LazyPluginSpec
return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    {
      "folke/neoconf.nvim",
      cmd = "Neoconf",
      config = true,
      dependencies = { "nvim-lspconfig" },
    },
    { "folke/neodev.nvim", opts = {} },
    {
      "williamboman/mason-lspconfig.nvim",
      dependencies = { "williamboman/mason.nvim", opts = {} },
    },
    "hrsh7th/cmp-nvim-lsp",
  },
  keys = require("lsp.keys"),
  ---@class PluginLspOpts
  opts = {
    diagnostics = {
      float = { border = "single", source = "always" },
      underline = true,
      update_in_insert = false,
      virtual_text = {
        spacing = 4,
        source = "always",
        prefix = "icons",
      },
      severity_sort = true,
    },
    inlay_hints = {
      enabled = true,
    },
    capabilities = {
      textDocument = {
        foldingRange = {
          dynamicRegistration = false,
          lineFoldingOnly = true,
        },
      },
    },
    servers = require("lsp.servers"),
    setup = require("lsp.setup"),
  },
  config = require("lsp.config"),
}
