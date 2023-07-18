return {
  {
    'jinh0/eyeliner.nvim',
    config = function()
      require'eyeliner'.setup({})
      vim.api.nvim_create_autocmd(
        "BufReadPre", {
          pattern = "*",
          command = 'if getfsize(expand("%")) > 100000 | execute "EyelinerDisable" | endif'
        }
      )
    end
  }
}
