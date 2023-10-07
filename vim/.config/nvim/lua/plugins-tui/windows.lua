--- @diagnostic disable: missing-fields

-- TODO: make working sub-mode

--- @type LazyPluginSpec
return {
  "anuvyklack/windows.nvim",
  dependencies = {
    -- "hydra.nvim",
    -- "anuvyklack/middleclass",
    "nyngwang/NeoZoom.lua",
  },
  keys = {
    {
      "<leader>z",
      function()
        require("neo-zoom").neo_zoom({})
      end,
      desc = "zoom window",
    },
  },
  -- lazy = false,
  opts = {},
  config = function()
    local neozoom = require("neo-zoom")
    neozoom.setup({})
    --       local windows = require("windows")
    --       windows.setup({ autowidth = { enable = false } })
    --       local window_hint = [[
    --  ^^^^^^^^^^^^     Move      ^^    Size   ^^   ^^     Split
    --  ^^^^^^^^^^^^-------------  ^^-----------^^   ^^---------------
    --  ^ ^ _k_ ^ ^  ^ ^ _K_ ^ ^   ^   _+_   ^       _s_: horizontally
    --  _h_ ^ ^ _l_  _H_ ^ ^ _L_   _<_     _>_       _v_: vertically
    --  ^ ^ _j_ ^ ^  ^ ^ _J_ ^ ^   ^   _-_   ^       _c_: close
    --  focus^^^^^^  window^^^^^^  ^_=_: equalize^   _z_: zoom
    --  ^ ^ ^ ^ ^ ^  ^ ^ ^ ^ ^ ^   _m_: maximize^   _o_: remain only
    --  _q_: exit
    -- ]]
    --   local cmd = require("hydra.keymap-util").cmd
    --   local pcmd = require("hydra.keymap-util").pcmd
    --   require("hydra")({
    --     name = "Windows",
    --     hint = window_hint,
    --     config = {
    --       invoke_on_body = true,
    --       hint = { border = "rounded" },
    --     },
    --     mode = { "n", "x" },
    --     body = "<C-w>",
    --     heads = {
    --       { "h", "<C-w>h" },
    --       { "j", "<C-w>j" },
    --       { "k", "<C-w>k" },
    --       { "l", "<C-w>l" },
    --
    --       { "H", "<C-w>H" },
    --       { "J", "<C-w>J" },
    --       { "K", "<C-w>K" },
    --       { "L", "<C-w>L" },
    --
    --       { "<", "<C-w><" },
    --       { ">", "<C-w>>" },
    --       { "-", "<C-w>-" },
    --       { "+", "<C-w>+" },
    --       { "=", "<C-w>=", { desc = "equalize" } },
    --
    --       { "s", pcmd("split", "E36") },
    --       { "<C-s>", pcmd("split", "E36"), { desc = false } },
    --       { "v", pcmd("vsplit", "E36") },
    --       { "<C-v>", pcmd("vsplit", "E36"), { desc = false } },
    --
    --       { "m", cmd("WindowsMaximize"), { desc = "maximize" } },
    --       { "<C-m>", cmd("WindowsMaximize"), { desc = false } },
    --
    --       { "z", function() neozoom.neo_zoom({}) end, { desc = "zoom" } },
    --       { "<C-z>", function() neozoom.neo_zoom({}) end, { desc = false } },
    --
    --       { "o", "<C-w>o", { exit = true, desc = "remain only" } },
    --       { "<C-o>", "<C-w>o", { exit = true, desc = false } },
    --
    --       { "c", pcmd("close", "E444"), { desc = "close window" } },
    --       { "<C-c>", pcmd("close", "E444"), { desc = false } },
    --
    --       { "q", nil, { exit = true, desc = false } },
    --     },
    --   })
  end,
}
