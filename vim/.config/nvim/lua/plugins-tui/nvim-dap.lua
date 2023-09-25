local dap_icons = {
  Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
  Breakpoint = " ",
  BreakpointCondition = " ",
  BreakpointRejected = { " ", "DiagnosticError" },
  LogPoint = ".>",
}

return {
  {
    "mfussenegger/nvim-dap",

    dependencies = {
      "hydra.nvim",
      -- fancy UI for the debugger
      {
        "rcarriga/nvim-dap-ui",
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

      -- virtual text for the debugger
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },

      -- mason.nvim integration
      {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = "mason.nvim",
        cmd = { "DapInstall", "DapUninstall" },
        opts = {
          -- Makes a best effort to setup the various debuggers with
          -- reasonable debug configurations
          automatic_installation = true,

          -- You can provide additional configuration to the handlers,
          -- see mason-nvim-dap README for more information
          handlers = {},

          -- You'll need to check that you have the required things installed
          -- online, please don't ask me how to install them :)
          ensure_installed = {
            "codelldb",
            "delve",
            "js",
            "python",
          },
        },
      },
    },

    lazy = false,

    keys = {
      {
        "<leader>td",
        function()
          require("neotest").run.run({ strategy = "dap" })
        end,
        desc = "Debug Nearest",
      },
    },

    config = function()
      vim.api.nvim_set_hl(
        0,
        "DapStoppedLine",
        { default = true, link = "Visual" }
      )

      local dap = require("dap")
      local widgets = require("dap.ui.widgets")
      local Hydra = require("hydra")

      for _, lang in ipairs({ "c", "cpp" }) do
        dap.configurations[lang] = {
          {
            type = "codelldb",
            request = "launch",
            name = "Launch file",
            program = function()
              return vim.fn.input(
                "Path to executable: ",
                vim.fn.getcwd() .. "/",
                "file"
              )
            end,
            args = function()
              return vim.split(vim.fn.input("Args:"), " ", { trimempty = true })
            end,
            cwd = "${workspaceFolder}",
          },
          {
            type = "codelldb",
            request = "attach",
            name = "Attach to process",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
          },
          {
            type = "codelldb",
            request = "launch",
            name = "Launch Neovim Server",
            program = function()
              local nvim_bin = vim.fn.input(
                "Neovim repo root: ",
                vim.fn.getcwd(),
                "file"
              ) .. "/build/bin/nvim"
              print(
                "Launch client using: "
                  .. nvim_bin
                  .. " --server 127.0.0.1:8888 --remote-ui"
              )
              return nvim_bin
            end,
            args = { "--listen", "127.0.0.1:8888", "--headless" },
            cwd = "${workspaceFolder}",
          },
        }
      end

      if not dap.adapters["pwa-node"] then
        require("dap").adapters["pwa-node"] = {
          type = "server",
          host = "localhost",
          port = "${port}",
          executable = {
            command = "node",
            args = {
              require("mason-registry")
                .get_package("js-debug-adapter")
                :get_install_path()
                .. "/js-debug/src/dapDebugServer.js",
              "${port}",
            },
          },
        }
      end

      for _, language in ipairs({
        "typescript",
        "javascript",
        "typescriptreact",
        "javascriptreact",
      }) do
        if not dap.configurations[language] then
          dap.configurations[language] = {
            {
              type = "pwa-node",
              request = "launch",
              name = "Launch file",
              program = "${file}",
              cwd = "${workspaceFolder}",
            },
            {
              type = "pwa-node",
              request = "attach",
              name = "Attach",
              processId = require("dap.utils").pick_process,
              cwd = "${workspaceFolder}",
            },
          }
        end
      end

      if not dap.configurations.lua then
        dap.configurations.lua = {
          {
            type = "nlua",
            request = "attach",
            name = "Attach to running Neovim instance",
          },
        }
      end

      if not dap.adapters.lua then
        dap.adapters.nlua = function(callback, config)
          callback({
            type = "server",
            host = config.host or "127.0.0.1",
            port = config.port or 8086,
          })
        end
      end

      for name, sign in pairs(dap_icons) do
        sign = type(sign) == "table" and sign or { sign }
        vim.fn.sign_define("Dap" .. name, {
          text = sign[1],
          texthl = sign[2] or "DiagnosticInfo",
          linehl = sign[3],
          numhl = sign[3],
        })
      end

      local hint = [[
_<Enter>_: step over   _s_: Continue/Start   _b_: Breakpoint     _K_: Eval
_i_: step into         _d_: Terminate        _B_: Breakpoint Condition
_o_: step out          _x_: Clear Breakpoints
_c_: to cursor         _a_: Goto (no execute)
^
_q_: exit]]
      Hydra({
        hint = hint,
        config = {
          color = "pink",
          invoke_on_body = true,
          hint = {
            position = "bottom",
            border = "rounded",
          },
        },
        name = "DAP",
        mode = { "n", "x" },
        body = "<leader>d",
        on_enter = function()
          vim.bo.modifiable = false
        end,
        heads = {
          { "<Enter>", dap.step_over, { silent = true } },
          { "i", dap.step_into, { silent = true } },
          { "o", dap.step_out, { silent = true } },
          { "c", dap.run_to_cursor, { silent = true } },
          { "s", dap.continue, { silent = true } },
          { "a", dap.goto_, { silent = true } },
          { "d", dap.terminate, { exit = true, silent = true } },
          { "x", dap.clear_breakpoints, { silent = true } },
          { "b", dap.toggle_breakpoint, { silent = true } },
          {
            "B",
            function()
              dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
            end,
            { silent = true },
          },
          { "K", widgets.hover, { silent = true } },
          { "q", nil, { exit = true, nowait = true } },
        },
      })
    end,
  },
}
