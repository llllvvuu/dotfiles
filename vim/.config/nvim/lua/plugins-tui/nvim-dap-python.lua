return {
  {
    "mfussenegger/nvim-dap-python",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("dap-python").setup(
        "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      )
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "python",
        command = "nnoremap <buffer> <leader>df "
          .. ":lua require('dap-python').test_method()<CR>",
      })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "python",
        command = "nnoremap <buffer> <leader>da "
          .. ":lua require('dap-python').test_class()<CR>",
      })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "python",
        command = "vnoremap <buffer> <leader>dv "
          .. ":lua require('dap-python').test_selection()<CR>",
      })

      local configurations = require("dap").configurations.python
      for _, configuration in pairs(configurations) do
        configuration.justMyCode = false
      end
    end,
  },
}
