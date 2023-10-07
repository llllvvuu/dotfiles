return {
  --- @param opts lspconfig.options.clangd
  clangd = function(_, opts)
    require("clangd_extensions").setup({ server = opts })
    return false
  end,

  --- @param opts lspconfig.options.rust_analyzer
  rust_analyzer = function(_, opts)
    local ok, mason_registry = pcall(require, "mason-registry")
    local adapter ---@type any
    if ok then
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
      dap = { adapter = adapter },
      server = opts,
    })
    return true
  end,
}
