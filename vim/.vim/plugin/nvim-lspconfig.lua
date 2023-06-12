local lspconfig = require('lspconfig')

local servers = {
  'bashls',
  'bufls', -- Protobuf
  'clangd',
  'cssls',
  'cssmodules_ls',
  'docker_compose_language_service',
  'dockerls',
  'eslint',
  'graphql',
  'hls', -- Haskell
  'html',
  'lua_ls',
  'jsonls',
  'mm0_ls',
  'pyright',
  'rust_analyzer',
  'solc', -- Solidity
  'sqlls',
  'tailwindcss',
  'texlab',
  'tsserver',
  'vimls',
  'vuels',
}
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        capabilities = capabilities,
    }
end

local on_attach_ruff = function(client, bufnr)
  client.server_capabilities.hoverProvider= false
end

lspconfig.ruff_lsp.setup {
  on_attach = on_attach_ruff,
}
