--- @diagnostic disable: missing-fields

local nofmt = require("lsp.util").nofmt

---@type lspconfig.options
return {
  bashls = { on_attach = nofmt },
  -- biome = { on_attach = nofmt },
  bufls = {}, -- Protobuf
  clangd = require("lsp.servers.clangd"),
  cmake = {},
  cssls = {},
  cssmodules_ls = {},
  docker_compose_language_service = {},
  dockerls = {},
  efm = {},
  eslint = {},
  gopls = {},
  graphql = {},
  html = {},
  lua_ls = require("lsp.servers.lua_ls"),
  jsonls = { on_attach = nofmt },
  marksman = { on_attach = nofmt },
  mdx_analyzer = { on_attach = nofmt },
  mm0_ls = {},
  ocamllsp = { mason = false },
  basedpyright = {},
  ruff_lsp = {},
  rust_analyzer = require("lsp.servers.rust_analyzer"),
  -- semgrep = {},
  taplo = require("lsp.servers.taplo"),
  solidity_ls = {},
  sqlls = {},
  tailwindcss = require("lsp.servers.tailwindcss"),
  texlab = {},
  vimls = {},
  vtsls = require("lsp.servers.vtsls"),
  vuels = {},
  yamlls = {},
  zls = {},
}
