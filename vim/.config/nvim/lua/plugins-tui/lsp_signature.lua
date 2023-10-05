return {
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {
      hint_inline = function() return vim.fn.has("nvim-0.10.0") ~= 0 end,
    },
    config = function(_, opts)
      require("lsp_signature").setup(opts)
    end,
  },
}
