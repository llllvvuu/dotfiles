vim.cmd('source ~/.vimrc')

vim.opt.colorcolumn = "80,100," .. table.concat(vim.fn.range(120,999), ',')
vim.opt.cursorcolumn = true
vim.opt.cursorline = true
