local diagnostics =
  { Error = " ", Warn = " ", Hint = " ", Info = " " }

---@param opts PluginLspOpts
return function(opts)
  for name, icon in pairs(diagnostics) do
    name = "DiagnosticSign" .. name
    vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
  end

  if
    type(opts.diagnostics.virtual_text) == "table"
    and opts.diagnostics.virtual_text.prefix == "icons"
  then
    opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0
        and "●"
      or function(diagnostic)
        for d, icon in pairs(diagnostics) do
          if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
            return icon
          end
        end
      end
  end

  vim.diagnostic.config(vim.deepcopy(opts.diagnostics))
end
