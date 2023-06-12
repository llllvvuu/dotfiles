vim.cmd('source ~/.vimrc')

vim.g.python3_host_prog = vim.fn.expand('$HOME') .. '/.pyenv/versions/neovim3/bin/python'
vim.g.node_host_prog = vim.fn.system('which neovim-node-host')

vim.opt.colorcolumn = "80,100," .. table.concat(vim.fn.range(120,999), ',')
vim.opt.cursorcolumn = true
vim.opt.cursorline = true

-- statusline
local function GitBranch()
    return vim.fn.system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
end

local function StatuslineGit()
    local branchname = GitBranch()
    return #branchname > 0 and '  ' .. branchname .. ' ' or ''
end

-- Set statusline
vim.o.statusline = ""
vim.o.statusline = vim.o.statusline .. "%#Cursor#"
vim.o.statusline = vim.o.statusline .. StatuslineGit()
vim.o.statusline = vim.o.statusline .. "%#Visual#"
vim.o.statusline = vim.o.statusline .. " %y %{&fileencoding?&fileencoding:&encoding}"
vim.o.statusline = vim.o.statusline .. "[%{&fileformat}] "
vim.o.statusline = vim.o.statusline .. "%#Normal#"
vim.o.statusline = vim.o.statusline .. " %f %h%w%m%r%=%-14.(%l:%c%V / %L%) %P"
