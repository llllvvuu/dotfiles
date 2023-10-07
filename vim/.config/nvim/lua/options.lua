require("autocmds")

local g = vim.g

g.mapleader = " "
g.maplocalleader = " "
g.markdown_recommended_style = 0
g.sql_type_default = "postgresql"
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.loaded_sql_completion = 0
g.omni_sql_default_compl_type = "syntax"
g.omni_sql_no_default_maps = 1

local opt = vim.opt

opt.clipboard = "unnamedplus"
opt.foldenable = false
opt.ignorecase = true
opt.inccommand = "nosplit"
opt.syntax = "off"
opt.timeoutlen = 300
