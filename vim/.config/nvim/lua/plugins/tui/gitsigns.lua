--- @diagnostic disable: missing-fields

local prefix = "<leader><C-g>" -- dummy prefix for mini.clue

--- @type LazyPluginSpec
return {
  "lewis6991/gitsigns.nvim",
  dependencies = { "neogit" },
  keys = {
    {
      "<leader>g",
      function()
        vim.cmd("mkview")
        vim.cmd("silent! %foldopen!")
        local gitsigns = require("gitsigns")
        gitsigns.toggle_linehl(true)
        gitsigns.toggle_deleted(true)
        gitsigns.toggle_word_diff(true)
      end,
      desc = "gitsigns / neogit",
    },
    {
      prefix .. "s",
      function()
        require("gitsigns").stage_hunk()
      end,
      desc = "stage hunk",
    },
    {
      prefix .. "u",
      function()
        require("gitsigns").undo_stage_hunk()
      end,
      desc = "undo stage hunk",
    },
    {
      prefix .. "a",
      function()
        require("gitsigns").stage_buffer()
      end,
      desc = "stage [a]ll of buffer",
    },
    {
      prefix .. "p",
      function()
        require("gitsigns").preview_hunk()
      end,
      desc = "preview hunk",
    },
    {
      prefix .. "d",
      function()
        require("gitsigns").toggle_deleted()
      end,
      desc = "toggle [d]eleted",
    },
    {
      prefix .. "w",
      function()
        require("gitsigns").toggle_word_diff()
      end,
      desc = "toggle [w]ord diff",
    },
    {
      prefix .. "b",
      function()
        require("gitsigns").blame_line()
      end,
      desc = "blame line",
    },
    {
      prefix .. "r",
      function()
        require("gitsigns").reset_hunk()
      end,
      desc = "reset hunk",
    },
    { prefix .. "g", ":Neogit<CR>", desc = "Neogit" },
    {
      prefix .. "j",
      function()
        if vim.wo.diff then
          return "]c"
        end
        require("gitsigns").next_hunk()
      end,
      desc = "next hunk",
    },
    {
      prefix .. "k",
      function()
        if vim.wo.diff then
          return "[c"
        end
        require("gitsigns").prev_hunk()
      end,
      desc = "prev hunk",
    },
    {
      prefix .. "q",
      function()
        local cursor_pos = vim.api.nvim_win_get_cursor(0)
        vim.cmd("loadview")
        vim.api.nvim_win_set_cursor(0, cursor_pos)
        vim.cmd("normal zv")
        local gitsigns = require("gitsigns")
        gitsigns.toggle_linehl(false)
        gitsigns.toggle_deleted(false)
        gitsigns.toggle_word_diff(false)
      end,
      desc = "quit",
    },
  },
  config = true,
}
