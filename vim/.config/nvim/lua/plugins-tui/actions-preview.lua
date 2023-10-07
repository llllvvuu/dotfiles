--- @type LazyPluginSpec
return {
  "aznhe21/actions-preview.nvim",
  keys = {
    --- @diagnostic disable-next-line: missing-fields
    {
      "<leader>a",
      function()
        require("actions-preview").code_actions()
      end,
      desc = "LSP code [a]ctions preview",
      mode = { "n", "v" },
    },
  },
}
