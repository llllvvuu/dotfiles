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
