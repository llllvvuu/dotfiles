--- @type LazyPluginSpec
return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    { "LiadOz/nvim-dap-repl-highlights", opts = {} },
  },
  build = ":TSUpdate",
  lazy = false,
  ---@type TSConfig
  opts = {
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },
    auto_install = true,
    sync_install = false,
    ensure_installed = { "dap_repl" },
    ignore_install = { "unsupported" },
    indent = { enable = not vim.g.vscode },
    modules = {},
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
    if not vim.g.vscode then
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "*" },
        callback = function(data)
          if
            data.match ~= "csv" -- play nice with rainbow_csv
            and data.match ~= "tsv"
            and pcall(vim.treesitter.start)
          then
            vim.wo.foldmethod = "expr"
            vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
            vim.wo.foldtext = "v:lua.vim.treesitter.foldtext()"
            -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end
  end,
}
