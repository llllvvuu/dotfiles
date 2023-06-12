require("indent_blankline").setup {
  -- for example, context is off by default, use this to turn it on
  show_current_context = true,
  show_current_context_start = true,
}

for _, keymap in pairs({
  'zo',
  'zO',
  'zc',
  'zC',
  'za',
  'zA',
  'zv',
  'zx',
  'zX',
  'zm',
  'zM',
  'zr',
  'zR',
}) do
vim.api.nvim_set_keymap('n', keymap,  keymap .. '<CMD>IndentBlanklineRefresh<CR>', { noremap=true, silent=true })
end
