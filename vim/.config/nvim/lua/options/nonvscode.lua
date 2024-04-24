local opt = vim.opt

opt.cursorcolumn = true
opt.cursorline = true
opt.expandtab = true
opt.formatoptions = "jcroqlnt"
opt.laststatus = 0
opt.list = true
opt.number = true
opt.relativenumber = true
opt.scrolloff = 999
opt.shiftround = true
opt.shiftwidth = 2
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.showmode = false
opt.signcolumn = "yes"
opt.smartcase = true
opt.smartindent = true
opt.spelllang = "en_us"
opt.spell = true
opt.spelloptions:append({ "camel" })
opt.splitbelow = true
opt.splitright = true
opt.tabstop = 2
-- https://gist.github.com/andersevenrud/015e61af2fd264371032763d4ed965b6
opt.termguicolors = true
opt.updatetime = 250
opt.wildmode = "longest:full,full"
opt.wrap = false
