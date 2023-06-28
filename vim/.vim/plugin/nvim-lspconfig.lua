local lspconfig = require('lspconfig')
local configs = require('lspconfig.configs')

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

configs.solidity = {
  default_config = {
    cmd = {'nomicfoundation-solidity-language-server', '--stdio'},
    filetypes = { 'solidity' },
    root_dir = lspconfig.util.find_git_ancestor,
    single_file_support = true,
  },
}

lspconfig.solidity.setup {}
