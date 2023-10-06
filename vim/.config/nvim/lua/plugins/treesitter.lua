return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    ---@type TSConfig
    opts = {
      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },
      auto_install = true,
      ignore_install = { "unsupported" },
      indent = { enable = not vim.g.vscode },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
      if not vim.g.vscode then
        vim.api.nvim_create_autocmd("FileType", {
          pattern = { "*" },
          callback = function()
            if pcall(vim.treesitter.start) then
              vim.wo.foldmethod = "expr"
              vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
              vim.wo.foldtext = "v:lua.vim.treesitter.foldtext()"
              -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end
          end,
        })
      end
    end,
  },
}
