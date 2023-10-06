return {
  {
    "m4xshen/hardtime.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      max_count = 1,
      allow_different_key = true,
      disabled_filetypes = {
        "qf",
        "netrw",
        "help",
        "NvimTree",
        "NeogitStatus",
        "NeogitPopup",
        "NeogitCommitView",
        "lazy",
        "mason",
        "dapui_scopes",
        "dapui_breakpoints",
        "dapui_stacks",
        "dapui_watches",
        "dapui_console",
        "dap-repl",
        "neotest-summary",
        "query",
        "dbui",
        "fugitiveblame",
        "neo-tree",
        "neo-tree-popup",
      },
    },
  },
}
