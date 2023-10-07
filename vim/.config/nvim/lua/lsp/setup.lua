return {
  clangd = function(_, opts)
    require("clangd_extensions").setup({ server = opts })
    return false
  end,

  rust_analyzer = function(_, opts)
    local ok, mason_registry = pcall(require, "mason-registry")
    local adapter ---@type any
    if ok then
      -- rust tools configuration for debugging support
      local codelldb = mason_registry.get_package("codelldb")
      local extension_path = codelldb:get_install_path() .. "/extension/"
      local codelldb_path = extension_path .. "adapter/codelldb"
      local liblldb_path = vim.fn.has("mac") == 1
          and extension_path .. "lldb/lib/liblldb.dylib"
        or extension_path .. "lldb/lib/liblldb.so"
      adapter = require("rust-tools.dap").get_codelldb_adapter(
        codelldb_path,
        liblldb_path
      )
    end
    require("rust-tools").setup({
      dap = {
        adapter = adapter,
      },
      tools = {
        on_initialized = function()
          vim.cmd([[
            augroup RustLSP
            autocmd CursorHold                      *.rs silent! lua vim.lsp.buf.document_highlight()
            autocmd CursorMoved,InsertEnter         *.rs silent! lua vim.lsp.buf.clear_references()
            autocmd BufEnter,CursorHold,InsertLeave *.rs silent! lua vim.lsp.codelens.refresh()
            augroup END
          ]])
        end,
      },
      server = opts,
    })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "rust",
      command = [[
        nnoremap <buffer> K <cmd>RustHoverActions<cr>
        nnoremap <buffer> <leader>lg <cmd>RustDebuggables<cr>
        nnoremap <buffer> <leader>lm <cmd>RustRunnables<cr>
      ]],
    })

    return true
  end,
}
