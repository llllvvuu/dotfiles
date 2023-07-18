return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "folke/tokyonight.nvim" },
    event = "VeryLazy",
    opts = function()
      return {
        options = { theme = 'tokyonight' },
        sections = {
          lualine_a = {
            {
              'filename',
              newfile_status = true,
              path = 1,
            }
          }
        }
      }
    end
  }
}
