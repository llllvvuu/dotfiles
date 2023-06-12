local keymap = vim.api.nvim_set_keymap

vim.g.cornelis_max_width = 100
vim.g.cornelis_split_location = 'vertical'

keymap('i', '<C-a>', "<cmd>CornelisLoad<Cr>", { noremap = true })
keymap('n', '<C-a>', "<cmd>CornelisLoad<Cr>", { noremap = true })
keymap('i', '<C-q>', "<cmd>CornelisQuestionToMeta<Cr>", { noremap = true })
keymap('n', '<C-q>', "<cmd>CornelisQuestionToMeta<Cr>", { noremap = true })
keymap('i', '<C-f>', "<cmd>CornelisRefine<Cr>", { noremap = true })
keymap('n', '<C-f>', "<cmd>CornelisRefine<Cr>", { noremap = true })
keymap('i', '<C-s>', "<cmd>CornelisAuto<Cr>", { noremap = true })
keymap('n', '<C-s>', "<cmd>CornelisAuto<Cr>", { noremap = true })
keymap('i', '<C-e>', "<cmd>CornelisMakeCase<Cr>", { noremap = true })
keymap('n', '<C-e>', "<cmd>CornelisMakeCase<Cr>", { noremap = true })
keymap('n', '<Leader>d', "<cmd>CornelisGoToDefinition<Cr>", { noremap = true })
keymap('n', ']g', "<cmd>CornelisNextGoal<Cr>", { noremap = true })
keymap('n', '[g', "<cmd>CornelisPrevGoal<Cr>", { noremap = true })

vim.api.nvim_call_function("cornelis#bind_input", { "==>", "≡⟨⟩" })
vim.api.nvim_call_function("cornelis#bind_input", { "eqb", "≡⟨⟩" })
vim.api.nvim_call_function("cornelis#bind_input", { "eq", "≡" })
vim.api.nvim_call_function("cornelis#bind_input", { "neq", "≢" })
vim.api.nvim_call_function("cornelis#bind_input", { "lam", "λ" })

local function cornelis_load_wrapper()
  if vim.fn.exists(':CornelisLoad') == 2 then
    vim.cmd "CornelisLoad"
  end
end

vim.api.nvim_create_autocmd(
  { "BufReadPre", "BufWritePost" },
  { callback = cornelis_load_wrapper }
)
