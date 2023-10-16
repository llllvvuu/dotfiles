--- @type LazyPluginSpec
return {
  "jbyuki/one-small-step-for-vimkind",
  keys = {
    --- @diagnostic disable-next-line: missing-fields
    {
      "<leader>o",
      function()
        require("osv").launch({ port = 8086 })
      end,
      desc = "osv - Debug nvim lua (port 8086)",
    },
  },
}
