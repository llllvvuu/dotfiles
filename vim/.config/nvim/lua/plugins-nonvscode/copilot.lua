return {
  {
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
      local suggestions = require("copilot.suggestion")
      vim.keymap.set("i", "å", suggestions.accept, { desc = "[copilot] accept suggestion", silent = true })
      vim.keymap.set("i", "<M-å>", suggestions.accept, { desc = "[copilot] accept suggestion", silent = true })
      vim.keymap.set("i", "∑", suggestions.accept_word, { desc = "[copilot] accept word", silent = true })
      vim.keymap.set("i", "<M-∑>", suggestions.accept_word, { desc = "[copilot] accept word", silent = true })
      vim.keymap.set("i", "¬", suggestions.accept_line, { desc = "[copilot] accept line", silent = true })
      vim.keymap.set("i", "<M-¬>", suggestions.accept_line, { desc = "[copilot] accept line", silent = true })
      vim.keymap.set("i", "‘", suggestions.next, { desc = "[copilot] accept next", silent = true })
      vim.keymap.set("i", "<M-‘>", suggestions.next, { desc = "[copilot] accept next", silent = true })
      vim.keymap.set("i", "“", suggestions.prev, { desc = "[copilot] accept prev", silent = true })
      vim.keymap.set("i", "<M-“>", suggestions.prev, { desc = "[copilot] accept prev", silent = true })
    end
  },
}
