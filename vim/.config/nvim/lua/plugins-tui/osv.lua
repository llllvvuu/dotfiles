return {
  {
    "jbyuki/one-small-step-for-vimkind",
    keys = {
      {
        "<leader>o",
        function()
          require("osv").launch({ port = 8086 })
        end,
        desc = "osv - Debug Neovim's Lua (port 8086)",
      },
    },
  },
}
