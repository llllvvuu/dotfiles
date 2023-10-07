--- @type LazyPluginSpec
return {
  "cshuaimin/ssr.nvim",
  keys = {
    --- @diagnostic disable-next-line: missing-fields
    {
      "<leader>%",
      function()
        require("ssr").open()
      end,
      mode = { "n", "x" },
      desc = "Structural Search + Replace",
    },
  },
}
