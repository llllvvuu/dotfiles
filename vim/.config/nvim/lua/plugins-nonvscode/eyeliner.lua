--- @type LazyPluginSpec
return {
  "jinh0/eyeliner.nvim",
  config = function()
    require("eyeliner").setup({})
    vim.api.nvim_create_autocmd("BufReadPre", {
      pattern = "*",
      callback = function(opts)
        if vim.fn.getfsize(vim.api.nvim_buf_get_name(opts.buf)) > 100000 then
          vim.cmd("EyelinerDisable")
        end
      end
    })
  end,
}
