return {
  {
    "glacambre/firenvim",

    -- Lazy load firenvim
    -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
    lazy = not vim.g.started_by_firenvim,
    build = function()
      vim.fn["firenvim#install"](0)
    end,

    config = function()
      vim.g.firenvim_config = {
        globalSettings = { alt = "all" },
        localSettings = {
          [".*"] = {
            takeover = "never",
            priority = 0,
          },
          [".*github.com.*"] = {
            takeover = "always",
            priority = 1,
          },
          [".*reddit.com.*"] = {
            takeover = "always",
            priority = 1,
          },
          [".*mail.google.*"] = {
            takeover = "always",
            priority = 1,
          },
          [".*gmail.*"] = {
            takeover = "always",
            priority = 1,
          },
        },
      }

      vim.api.nvim_create_autocmd({ "BufEnter" }, {
        pattern = { "github.com_*.txt", "reddit.com_*.txt" },
        cmd = "set filetype=markdown",
      })
    end,
  },
}
