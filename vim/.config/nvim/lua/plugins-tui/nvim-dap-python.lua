--- @type LazyPluginSpec
return {
  "mfussenegger/nvim-dap-python",
  dependencies = { "mfussenegger/nvim-dap" },
  config = function()
    require("dap-python").setup(
      "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
    )

    local configurations = require("dap").configurations.python
    for _, configuration in pairs(configurations) do
      --- @diagnostic disable-next-line: inject-field
      configuration.justMyCode = false
    end
  end,
}
