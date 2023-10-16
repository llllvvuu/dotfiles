vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown*", "text" },
  callback = function()
    vim.wo.wrap = true
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.mdx",
  callback = function()
    vim.bo.filetype = "markdown.mdx"
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(opts)
    local fname = vim.api.nvim_buf_get_name(opts.buf)
    if #fname <= 0 then
      return
    end
    local size = vim.fn.getfsize(fname) / 1024
    if size >= 1024 then
      vim.schedule(function()
        vim.lsp.buf_detach_client(opts.buf, opts.data.client_id)
      end)
    end
  end,
})
