local luasnip = require('luasnip')
luasnip.filetype_extend('typescript.tsx', { 'typescriptreact' })
luasnip.filetype_extend('typescript', { 'typescriptreact' })
require("luasnip.loaders.from_vscode").lazy_load()
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

vim.o.completeopt = 'menu,menuone,noselect'
vim.api.nvim_set_keymap(
  'i',
  '<Tab>',
  "luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'",
  { silent = true, expr = true }
)
vim.api.nvim_set_keymap(
  'i',
  '<S-Tab>',
  "<cmd>lua require'luasnip'.jump(-1)<Cr>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  's',
  '<Tab>',
  "<cmd>lua require'luasnip'.jump(1)<Cr>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  's',
  '<S-Tab>',
  "<cmd>lua require'luasnip'.jump(-1)<Cr>",
  { noremap = true, silent = true }
)

vim.opt.signcolumn = "yes:1"
local cmp = require('cmp')
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp'},
    {name = 'buffer'},
    {name = 'luasnip'},
  },
}
