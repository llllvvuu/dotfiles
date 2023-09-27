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
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "*" },
        callback = function()
          pcall(vim.treesitter.start)
          local hl_ns = vim.api.nvim_get_namespaces()["treesitter/highlighter"]
          if vim.g.vscode and hl_ns then
            vim.api.nvim_set_decoration_provider(hl_ns, {
              on_win = vim.treesitter.highlighter._on_win,
              _on_spell_nav = nil,
              on_line = nil,
            })
          end
          vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
          -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
}
