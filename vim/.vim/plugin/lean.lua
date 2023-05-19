local function on_attach(_, bufnr)
    local function cmd(mode, lhs, rhs)
      vim.keymap.set(mode, lhs, rhs, { noremap = true, buffer = true })
    end

    -- Autocomplete using the Lean language server
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- gd in normal mode will jump to definition
    cmd('n', 'gd', vim.lsp.buf.definition)
    -- K in normal mode will show the definition of what's under the cursor
    cmd('n', 'K', vim.lsp.buf.hover)

    -- <leader>n will jump to the next Lean line with a diagnostic message on it
    -- <leader>N will jump backwards
    cmd('n', '<leader>n', function() vim.lsp.diagnostic.goto_next{popup_opts = {show_header = false}} end)
    cmd('n', '<leader>N', function() vim.lsp.diagnostic.goto_prev{popup_opts = {show_header = false}} end)

    -- <leader>K will show all diagnostics for the current line in a popup window
    cmd('n', '<leader>K', function() vim.lsp.diagnostic.show_line_diagnostics{show_header = false} end)

    -- <leader>q will load all errors in the current lean file into the location list
    -- (and then will open the location list)
    -- see :h location-list if you don't generally use it in other vim contexts
    cmd('n', '<leader>q', vim.lsp.diagnostic.set_loclist)
end

-- Enable lean.nvim, and enable abbreviations and mappings
require('lean').setup{
    abbreviations = { builtin = true },
    lsp = { on_attach = on_attach },
    lsp3 = { on_attach = on_attach },
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
