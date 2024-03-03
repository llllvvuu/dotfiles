--- @diagnostic disable: missing-fields

local nofmt = require("lsp.util").nofmt

--- @type lspconfig.options.vtsls
return {
  on_attach = nofmt,
  settings = {
    vtsls = {
      autoUseWorkspaceTsdk = true,
      experimental = {
        completion = {
          enableServerSideFuzzyMatch = true,
        },
      },
    },
    typescript = {
      inlayHints = {
        parameterNames = { enabled = "literals" },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
      referencesCodeLens = { enabled = true },
      format = { enable = false },
      suggest = {
        completeFunctionCalls = true,
      },
      preferGoToSourceDefinition = true,
    },
    javascript = {
      preferGoToSourceDefinition = true,
      referencesCodeLens = { enabled = true },
      inlayHints = {
        parameterNames = { enabled = "literals" },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
    },
    ["js/ts"] = {
      implicitProjectConfig = {
        checkJs = true,
        compilerOptions = {
          module = "esnext",
          target = "esnext",
        },
      },
    },
  },
}
