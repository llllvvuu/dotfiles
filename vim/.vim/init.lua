vim.cmd('source ~/.vimrc')

vim.g.python3_host_prog = vim.fn.expand('$HOME') .. '/.pyenv/versions/neovim3/bin/python'
vim.g.node_host_prog = vim.fn.system('which neovim-node-host')

vim.opt.colorcolumn = "80,100," .. table.concat(vim.fn.range(120,999), ',')
vim.opt.cursorcolumn = true
vim.opt.cursorline = true
