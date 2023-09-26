return {
  {
    "nvim-neotest/neotest",
    lazy = false,
    dependencies = {
      "hydra.nvim",
      "llllvvuu/neotest-gtest",
      "llllvvuu/neotest-foundry",
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-go",
      "nvim-treesitter",
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

      local hint = [[
 ^ ^                  ^ ^    TESTING 󰙨
 _t_: test nearest    _a_: attach nearest    _o_: output           _O_: toggle output panel
 _f_: test file       _x_: stop nearest      _d_: debug nearest    _n_: jump to next test
 _q_: exit            _w_: toggle watch      _s_: goto summary     _p_: jump to prev test

SUMMARY WINDOW:
"a" attach       "M" clear marked  "T" clear target    "d" debug
"D" debug marked "<CR>" expand     "<2-LeftMouse>" expand all
"e" expand all   "i" jumpto        "m" mark            "J" next failed
"o" output       "K" prev failed   "r" run             "R" run marked
"O" short        "u" stop          "t" target          "w" watch
]]
      local prev_win = nil
      require("hydra")({
        hint = hint,
        name = "neo[t]est",
        mode = { "n", "x" },
        body = "<leader>t",
        config = {
          color = "pink",
          invoke_on_body = true,
          hint = {
            position = "bottom",
            border = "rounded",
          },
          on_enter = function()
            vim.bo.modifiable = false
            require("neotest").summary.open()
          end,
          on_exit = function()
            require("neotest").summary.close()
          end,
        },
        heads = {
          { "t", neotest.run.run, { silent = true } },
          { "x", neotest.run.stop, { silent = true } },
          {
            "f",
            function()
              neotest.run.run(vim.fn.expand("%"))
            end,
            { silent = true },
          },
          {
            "d",
            function()
              neotest.run.run({ strategy = "dap" })
              require("plugins-tui.nvim-dap").hydra:activate()
            end,
            { silent = true, exit = true },
          },
          { "a", neotest.run.attach, { silent = true } },
          { "o", neotest.output.open, { silent = true } },
          { "O", neotest.output_panel.toggle, { silent = true } },
          { "n", neotest.jump.next, { silent = true } },
          { "w", neotest.watch.toggle, { silent = true } },
          { "p", neotest.jump.prev, { silent = true } },
          {
            "s",
            function()
              neotest.summary.open()
              local cur_win = vim.api.nvim_get_current_win()
              local win = vim.fn.bufwinid("Neotest Summary")
              if win == cur_win then
                vim.api.nvim_set_current_win(prev_win)
              elseif win and win > -1 then
                prev_win = cur_win
                vim.api.nvim_set_current_win(win)
              end
            end,
            { silent = true },
          },
          { "q", nil, { exit = true, nowait = true } },
        },
      })
    end,
  },
}
