local js_filetypes = {
  "javascript",
  "javascriptreact",
  "typescript",
  "typescriptreact",
  "vue",
}

return {
  {
    "llllvvuu/nvim-js-actions",
    ft = js_filetypes,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    init = function()
      vim.api.nvim_create_autocmd(
        "FileType",
        {
          pattern = js_filetypes,
          command = "nnoremap <buffer> <leader>ta " ..
            ":lua require('nvim-js-actions').js_arrow_fn.toggle()<CR>"
            -- can also do `require('nvim-js-actions/js-arrow-fn').toggle()`
        }
      )
    end
  }
}
