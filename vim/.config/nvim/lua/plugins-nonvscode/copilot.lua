--- @type LazyPluginSpec
return {
  "zbirenbaum/copilot.lua",
  opts = {
    panel = { enabled = false },
    suggestion = {
      enabled = true,
      auto_trigger = true,
      keymap = {
        accept = "<M-a>",
        accept_word = "<M-w>",
        accept_line = "<M-l>",
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-]>",
      },
    },
    filetypes = {
      yaml = true,
      markdown = true,
      gitcommit = true,
      hgcommit = true,
      svn = true,
      cvs = true,
    },
  },
  config = function(_, opts)
    require("copilot").setup(opts)

    local map = vim.keymap.set
    local suggestions = require("copilot.suggestion")

      -- stylua: ignore start
      map("i", "å", suggestions.accept, { desc = "[copilot] accept suggestion", silent = true })
      map("i", "<M-å>", suggestions.accept, { desc = "[copilot] accept suggestion", silent = true })

      map("i", "∑", suggestions.accept_word, { desc = "[copilot] accept word", silent = true })
      map("i", "<M-∑>", suggestions.accept_word, { desc = "[copilot] accept word", silent = true })

      map("i", "¬", suggestions.accept_line, { desc = "[copilot] accept line", silent = true })
      map("i", "<M-¬>", suggestions.accept_line, { desc = "[copilot] accept line", silent = true })

      map("i", "‘", suggestions.next, { desc = "[copilot] accept next", silent = true })
      map("i", "<M-‘>", suggestions.next, { desc = "[copilot] accept next", silent = true })

      map("i", "“", suggestions.prev, { desc = "[copilot] accept prev", silent = true })
      map("i", "<M-“>", suggestions.prev, { desc = "[copilot] accept prev", silent = true })
    -- stylua: ignore end
  end,
}
