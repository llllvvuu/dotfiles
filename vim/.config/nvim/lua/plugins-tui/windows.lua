--- @diagnostic disable: missing-fields

--- @type LazyPluginSpec
return {
  "anuvyklack/windows.nvim",
  dependencies = {
    "anuvyklack/middleclass",
    "nyngwang/NeoZoom.lua",
  },
  keys = {
    {
      "<C-w>z",
      function()
        require("neo-zoom").neo_zoom({})
      end,
      desc = "zoom window",
    },
    {
      "<C-w>m",
      function() require("windows.commands").maximize() end,
      desc = "maximize window",
    },
  },
  opts = {},
  config = function()
    local neozoom = require("neo-zoom")
    neozoom.setup({})
    require("windows").setup()
  end,
}
