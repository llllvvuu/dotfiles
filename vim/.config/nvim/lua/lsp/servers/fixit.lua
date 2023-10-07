return {
  setup = function(opts)
    local lspconfig = require("lspconfig")
    require("lspconfig.configs").fixit = {
      default_config = {
        cmd = { "fixit", "lsp" },
        filetypes = { "python" },
        root_dir = lspconfig.util.root_pattern(
          "pyproject.toml",
          "requirements.txt",
          "setup.py",
          "setup.cfg"
        ) or lspconfig.util.find_git_ancestor,
        single_file_support = true,
      },
    }
    lspconfig.fixit.setup(opts)
  end,
}
