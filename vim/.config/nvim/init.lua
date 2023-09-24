local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

if vim.g.vscode then
  require("options")
  require("keymap-vscode")
  require("lazy").setup({
    { import = "plugins" },
  })
elseif vim.g.started_by_firenvim then
  require("options-tui")
  require("options-firenvim")
  require("keymap-tui")
  require("lazy").setup({
    { import = "plugins" },
    { import = "plugins-nonvscode" },
  })
  vim.opt.laststatus = 0
else
  require("options-tui")
  require("keymap-tui")
  require("lazy").setup({
    { import = "plugins" },
    { import = "plugins-nonvscode" },
    { import = "plugins-tui" },
  })
end
