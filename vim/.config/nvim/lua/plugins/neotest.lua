return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "alfaix/neotest-gtest",
      "llllvvuu/neotest-foundry",
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-go",
    },
    opts = function()
      return {
        adapters = {
          require("neotest-gtest"),
          require("neotest-go"),
          require("neotest-foundry"),
          require("neotest-python")({ dap = { justMyCode = false } }),
        },
        status = { virtual_text = true, signs = true },
        summary = { follow = true, animated = true },
        output = { open_on_run = false },
      }
    end,
    config = function(_, opts)
      require("neotest-gtest").setup({})
      if opts.adapters then
        local adapters = {}
        for name, config in pairs(opts.adapters or {}) do
          if type(name) == "number" then
            if type(config) == "string" then
              config = require(config)
            end
            adapters[#adapters + 1] = config
          elseif config ~= false then
            local adapter = require(name)
            if type(config) == "table" and not vim.tbl_isempty(config) then
              local meta = getmetatable(adapter)
              if adapter.setup then
                adapter.setup(config)
              elseif meta and meta.__call then
                adapter(config)
              else
                error("Adapter " .. name .. " does not support setup")
              end
            end
            adapters[#adapters + 1] = adapter
          end
        end
        opts.adapters = adapters
      end

      require("neotest").setup(opts)
    end,
    -- stylua: ignore
    keys = {
      { "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File" },
      { "<leader>tT", function() require("neotest").run.run(vim.loop.cwd()) end, desc = "Run All Test Files" },
      { "<leader>tn", function() require("neotest").run.run() end, desc = "Run Nearest" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary" },
      { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output" },
      { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel" },
      { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop" },
      { "<leader>t?", ":h neotest.setup_project()<CR>25k", desc = "Neotest Outline Keybind Help" },
    },
  },
}
