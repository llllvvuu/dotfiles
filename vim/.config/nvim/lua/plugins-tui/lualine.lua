return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "tokyonight.nvim" },
    event = "VeryLazy",
    opts = function()
      return {
        options = { theme = "tokyonight" },
        sections = {
          lualine_a = {
            {
              "filename",
              newfile_status = true,
              path = 1,
            },
          },
        },
      }
    end,
  },
}
