--- @diagnostic disable: missing-fields

local dap_icons = {
  Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
  Breakpoint = " ",
  BreakpointCondition = " ",
  BreakpointRejected = { " ", "DiagnosticError" },
  LogPoint = ".>",
}

--- @type LazyPluginSpec
return {
  "mfussenegger/nvim-dap",

  dependencies = {
    {
      "rcarriga/nvim-dap-ui",
      dependencies = { "nvim-neotest/nvim-nio" },
      opts = {},
      config = function(_, opts)
        local dap = require("dap")
        local dapui = require("dapui")
        dapui.setup(opts)
        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open({})
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
          dapui.close({})
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
          dapui.close({})
        end
      end,
    },

    {
      "theHamsta/nvim-dap-virtual-text",
      opts = {},
    },

    {
      "jay-babu/mason-nvim-dap.nvim",
      dependencies = "mason.nvim",
      cmd = { "DapInstall", "DapUninstall" },
      opts = {
        automatic_installation = true,
        handlers = {},
        ensure_installed = {
          "codelldb",
          "delve",
          "js",
          "python",
          "haskell",
        },
      },
    },
  },

  -- stylua: ignore
  keys = {
    { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "toggle [b]reakpoint" },
    { "<leader>dx", function() require("dap").clear_breakpoints() end, desc = "clear breakpoints" },
    { "<leader>dc", function() require("dap").continue() end, desc = "continue" },
    { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "run to [C]ursor" },
    { "<leader>dg", function() require("dap").goto_() end, desc = "go to line (no execute)" },
    { "<leader>di", function() require("dap").step_into() end, desc = "step [i]nto" },
    { "<leader>dj", function() require("dap").down() end, desc = "down frame" },
    { "<leader>dk", function() require("dap").up() end, desc = "up frame" },
    { "<leader>dl", function() require("dap").run_last() end, desc = "Run [l]ast session" },
    { "<leader>do", function() require("dap").step_out() end, desc = "step [o]ut" },
    { "<leader>dn", function() require("dap").step_over() end, desc = "step over ([n]ext)" },
    { "<leader>dp", function() require("dap").pause() end, desc = "pause" },
    { "<leader>dr", function() require("dap").reverse_continue() end, desc = "reverse continue" },
    { "<leader>dt", function() require("dap").terminate() end, desc = "terminate" },
    { "<leader>dw", function() require("dap.ui.widgets").preview() end, desc = "hover [w]indow" },
  },

  config = function()
    require("debugger.codelldb").setup()
    require("debugger.pwa-node").setup()
    require("debugger.nlua").setup()

    vim.api.nvim_set_hl(
      0,
      "DapStoppedLine",
      { default = true, link = "Visual" }
    )

    for name, sign in pairs(dap_icons) do
      if type(sign) == "string" then
        sign = { sign }
      end
      vim.fn.sign_define("Dap" .. name, {
        text = sign[1],
        texthl = sign[2] or "DiagnosticInfo",
        linehl = sign[3],
        numhl = sign[3],
      })
    end
  end,
}
