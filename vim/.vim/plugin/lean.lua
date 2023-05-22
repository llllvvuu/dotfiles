-- Enable lean.nvim, and enable abbreviations and mappings
require('lean').setup{
  abbreviations = { builtin = true },
  mappings = true,
}

-- Update error messages even while you're typing in insert mode
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = { spacing = 4 },
    update_in_insert = true,
  }
)
