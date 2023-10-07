return {
  setup = function()
    for _, lang in ipairs({ "c", "cpp" }) do
      require("dap").configurations[lang] = {
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
          args = function()
            local args =
              vim.split(vim.fn.input("Args:"), " ", { trimempty = true })
            vim.list_extend(
              args,
              { "--listen", "127.0.0.1:8888", "--headless" }
            )
            return args
          end,
          cwd = "${workspaceFolder}",
        },
        {
          type = "codelldb",
          request = "launch",
          name = "Launch node binary",
          program = function()
            return vim.fn.input("Node repo root: ", vim.fn.getcwd(), "file")
              .. "/out/Debug/node"
          end,
          args = function()
            return vim.split(vim.fn.input("Args:"), " ", { trimempty = true })
          end,
          cwd = "${workspaceFolder}",
        },
      }
    end
  end,
}
