return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    keys = {
      { "<leader>f", "<cmd>Telescope git_files<cr>", desc = "Git Files" },
      {
        "<leader>b",
        "<cmd>Telescope buffers show_all_buffers=true<cr>",
        desc = "Buffers",
      },
      { "<leader>/", function() require('git_grep').live_grep() end, desc = "Live Grep" },
      {
        "<leader>*",
        "<cmd>Telescope grep_string<cr>",
        desc = "Grep Under Cursor",
      },
    },
    opts = {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        mappings = {
          i = {
            ["<M-Down>"] = function(...)
              return require("telescope.actions").cycle_history_next(...)
            end,
            ["<M-Up>"] = function(...)
              return require("telescope.actions").cycle_history_prev(...)
            end,
          },
        },
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      { "davvid/telescope-git-grep.nvim", branch = "main" },
    },
    config = function(_, opts)
      require("telescope").setup(opts)
      require("telescope").load_extension("git_grep")
    end,
  },
}
