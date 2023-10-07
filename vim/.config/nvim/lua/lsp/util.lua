local M = {}

--- @param client lsp.Client
M.nofmt = function(client)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
end

--- @param client lsp.Client
M.nofmt_all = function(client)
  M.nofmt(client)
  client.server_capabilities.documentOnTypeFormattingProvider = nil
end

return M
