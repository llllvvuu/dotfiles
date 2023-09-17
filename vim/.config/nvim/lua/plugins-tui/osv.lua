return {
  {
    "jbyuki/one-small-step-for-vimkind",
    keys = {
      {
        "<leader>dv",
        function()
          require("osv").launch({ port = 8086 })
        end,
        desc = "Start Neovim Debug Server",
      },
    },
  },
}
