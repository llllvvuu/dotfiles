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
      desc = "osv - Debug Neovim's Lua (port 8086)",
    },
  },
}
