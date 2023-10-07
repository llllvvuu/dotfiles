--- @diagnostic disable: missing-fields

--- @type lspconfig.options.rust_analyzer
return {
  on_attach = function(_, bufnr)
    local rt = require("rust-tools")
    local map = vim.keymap.set
    map("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr })
    -- stylua: ignore
    map("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
  end,
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
        loadOutDirsFromCheck = true,
        runBuildScripts = true,
      },
      checkOnSave = true,
      check = {
        command = "clippy",
        extraArgs = { "--no-deps" },
        features = "all",
      },
      procMacro = {
        enable = true,
        ignored = {
          ["async-trait"] = { "async_trait" },
          ["napi-derive"] = { "napi" },
          ["async-recursion"] = { "async_recursion" },
        },
      },
    },
  },
}
