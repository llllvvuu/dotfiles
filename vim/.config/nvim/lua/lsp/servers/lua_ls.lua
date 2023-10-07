--- @diagnostic disable: missing-fields

local nofmt_all = require("lsp.util").nofmt_all

--- @type lspconfig.options.lua_ls
return {
  on_attach = nofmt_all,
  settings = {
    Lua = {
      workspace = {
        checkThirdParty = false,
      },
      completion = {
        callSnippet = "Replace",
      },
      format = {
        enable = false,
      },
      hint = {
        enable = true,
        setType = true,
      },
    },
  },
}
