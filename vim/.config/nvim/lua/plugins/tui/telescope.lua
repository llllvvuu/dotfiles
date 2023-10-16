--- @diagnostic disable: missing-fields

local cycle_history_next = function(...)
  require("telescope.actions").cycle_history_next(...)
end

local cycle_history_prev = function(...)
  require("telescope.actions").cycle_history_prev(...)
end

--- @type LazyPluginSpec
return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  -- stylua: ignore
  keys = {
    { "<leader>f", "<cmd>Telescope git_files<cr>", desc = "git [f]iles (telescope.nvim)" },
    { "<leader>b", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "buffers (telescope.nvim)" },
    { "<leader>/", function() require("git_grep").live_grep() end, desc = "Live Grep" },
    { "<leader>*", "<cmd>Telescope grep_string<cr>", desc = "Grep Under Cursor" },
    { "<leader>u", "<cmd>Telescope undo<cr>", desc = "undotree (telescope.nvim)" },
    { "<leader>j", function() require'telescope.builtin'.jumplist() end, desc = "jumplist (telescope.nvim)" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    { "davvid/telescope-git-grep.nvim", branch = "main" },
    "debugloop/telescope-undo.nvim",
  },
  opts = {
    defaults = {
      prompt_prefix = " ",
      selection_caret = " ",
      mappings = {
        i = {
          ["<M-Down>"] = cycle_history_next,
          ["<M-Up>"] = cycle_history_prev,
        },
      },
    },
    extensions = {
      undo = {
        side_by_side = true,
        diff_context_lines = 8,
        layout_strategy = "vertical",
        layout_config = {
          preview_height = 0.6,
        },
      },
    },
  },
  config = function(_, opts)
    require("telescope").setup(opts)
    require("telescope").load_extension("git_grep")
    require("telescope").load_extension("undo")
  end,
}
