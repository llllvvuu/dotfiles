return {
  setup = function()
    local dap = require("dap")

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
      dap.adapters.nlua = function(callback)
        callback({ type = "server", host = "127.0.0.1", port = 8086 })
      end
    end
  end,
}
