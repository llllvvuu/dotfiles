local g = vim.g

g.mapleader = " "
g.maplocalleader = " "
g.markdown_recommended_style = 0

local opt = vim.opt

opt.clipboard = "unnamedplus"
opt.colorcolumn = "80,100," .. table.concat(vim.fn.range(120,999), ',')
opt.cursorcolumn = true
opt.cursorline = true
opt.expandtab = true
opt.formatoptions = "jcroqlnt"
opt.ignorecase = true
opt.inccommand = "nosplit"
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
opt.spelllang = { "en" }
opt.splitbelow = true
opt.splitright = true
opt.tabstop = 2
opt.termguicolors = true
opt.timeoutlen = 300
opt.updatetime = 250
opt.wildmode = "longest:full,full"
opt.wrap = false

vim.api.nvim_create_autocmd(
  "BufReadPre", {
    pattern = "*",
    command = 'if getfsize(expand("%")) > 100000 | syntax off | endif'
  }
)

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(opts)
    local fname = vim.api.nvim_buf_get_name(opts.buf)
    if #fname <= 0 then
      return
    end
    local size = vim.fn.getfsize(fname) / 1024
    if size >= 100 then
      vim.schedule(function()
        vim.lsp.buf_detach_client(opts.buf, opts.data.client_id)
      end)
    end
  end
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.mdx",
  callback = function(opts)
    vim.api.nvim_buf_set_option(0, 'filetype', 'markdown.mdx')
  end
})
