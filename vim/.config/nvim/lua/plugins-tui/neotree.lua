--- @diagnostic disable: missing-fields

--- @type LazyPluginSpec
return {
  "nvim-tree/nvim-tree.lua",
  keys = {
    { "<leader>n", function()
      require "nvim-tree.api".tree.open() end
    , desc = "nvim-tree" },
  },
  config = true,
}
