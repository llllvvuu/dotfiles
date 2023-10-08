--- @diagnostic disable: missing-fields

--- @type integer?
local prev_win = nil
local prefix = "<leader><C-t>" -- dummy prefix for mini.clue

local function toggle_focus_summary()
  local cur_win = vim.api.nvim_get_current_win()
  local win = vim.fn.bufwinid("Neotest Summary")
  if not win or win == -1 then
    require("neotest").summary.open()
  elseif win == cur_win then
    if prev_win then
      vim.api.nvim_set_current_win(prev_win)
    end
  elseif win > -1 then
    prev_win = cur_win
    vim.api.nvim_set_current_win(win)
  end
end

--- @type LazyPluginSpec
return {
  "nvim-neotest/neotest",
  dependencies = {
    "alfaix/neotest-gtest",
    "llllvvuu/neotest-foundry",
    "nvim-neotest/neotest-python",
    "nvim-neotest/neotest-go",
    "nvim-treesitter",
  },
  -- stylua: ignore
  keys = {
    { "<leader>t", function() require("neotest").summary.open() end, desc = "neo[t]est" },
    { prefix .. "t", function() require("neotest").run.run() end, desc = "test nearest" },
    { prefix .. "x", function() require("neotest").run.stop() end, desc = "stop test" },
    { prefix .. "f", function()
      require("neotest").run.run(vim.api.nvim_buf_get_name(0))
    end, desc = "test [f]ile" },
    { prefix .. "d", function()
      require("neotest").summary.close()
      require("neotest").run.run({ strategy = "dap", suite = false })
    end, desc = "debug nearest test (DAP)" },
    { prefix .. "a", function() require("neotest").run.attach() end, desc = "attach" },
    { prefix .. "o", function() require("neotest").output.open() end, desc = "open output" },
    { prefix .. "O", function() require("neotest").output_panel.toggle() end, desc = "toggle [O]utput panel" },
    { prefix .. "n", function() require("neotest").jump.next() end, desc = "next test" },
    { prefix .. "w", function() require("neotest").watch.toggle() end, desc = "toggle [w]atch" },
    { prefix .. "p", function() require("neotest").jump.prev() end, desc = "prev test" },
    { prefix .. "s", toggle_focus_summary, desc = "open [s]ummary" },
    { prefix .. "q", function() require("neotest").summary.close() end, desc = "quit neotest" },
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

    local neotest = require("neotest")
    neotest.setup(opts)
  end,
}
