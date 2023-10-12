--- @type LazyPluginSpec
return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "tokyonight.nvim",
    {
      "linrongbin16/lsp-progress.nvim",
      config = function()
        require("lsp-progress").setup()
      end,
    },
  },
  event = "VeryLazy",
  opts = function()
    vim.api.nvim_create_augroup("lualine_augroup", { clear = false })
    vim.api.nvim_create_autocmd("User", {
      pattern = "LspProgressStatusUpdated",
      group = "lualine_augroup",
      callback = function()
        require("lualine").refresh({
          scope = "window",
          place = { "statusline" },
        })
      end,
    })
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
        lualine_c = {
          function()
            return require("lsp-progress").progress({
              format = function(messages)
                return #messages > 0 and table.concat(messages, " ") or ""
              end,
            })
          end,
        },
      },
    }
  end,
}
