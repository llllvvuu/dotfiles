local function diagnostic_goto(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

return {
  -- { "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help" },
  { "<leader>lx", vim.diagnostic.open_float, desc = "LSP Line Diagnostics" },
  {
    "<leader>lh",
    function()
      vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled())
    end,
    desc = "Toggle [L]SP inlay [h]ints",
  },
  {
    "gd",
    function()
      require("telescope.builtin").lsp_definitions({ reuse_win = true })
    end,
    desc = "LSP goto [d]efinition (telescope.nvim)",
  },
  {
    "<leader>s",
    function()
      require("telescope.builtin").lsp_document_symbols({ reuse_win = true })
    end,
    desc = "LSP document [s]ymbols (telescope.nvim)",
  },
  {
    "gr",
    function()
      require("telescope.builtin").lsp_references({ reuse_win = true })
    end,
    desc = "LSP [r]eferences (telescope.nvim)",
  },
  { "<leader>r", vim.lsp.buf.rename, desc = "LSP [r]ename" },
  { "gD", vim.lsp.buf.declaration, desc = "LSP Goto [D]eclaration" },
  {
    "gi",
    function()
      require("telescope.builtin").lsp_implementations({ reuse_win = true })
    end,
    desc = "LSP goto [i]mplementation (telescope.nvim)",
  },
  {
    "gy",
    function()
      require("telescope.builtin").lsp_type_definitions({ reuse_win = true })
    end,
    desc = "LSP goto T[y]pe Definition (telescope.nvim)",
  },
  { "]d", diagnostic_goto(true), desc = "LSP next [d]iagnostic" },
  { "[d", diagnostic_goto(false), desc = "LSP prev [d]iagnostic" },
  { "]e", diagnostic_goto(true, "ERROR"), desc = "LSP next [e]rror" },
  { "[e", diagnostic_goto(false, "ERROR"), desc = "LSP prev [e]rror" },
  { "]w", diagnostic_goto(true, "WARN"), desc = "LSP next [w]arning" },
  { "[w", diagnostic_goto(false, "WARN"), desc = "LSP prev [w]arning" },
}
