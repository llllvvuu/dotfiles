--- @diagnostic disable: missing-fields
---
--- @type LazyPluginSpec
return {
  "echasnovski/mini.files",
  keys = {
    {
      "<leader>m",
      function()
        require("mini.files").open(vim.api.nvim_buf_get_name(0))
      end,
      desc = "mini.files",
    },
  },
  opts = {
    window = {
      preview = true,
      width_preview = 80,
    },
  },
}
