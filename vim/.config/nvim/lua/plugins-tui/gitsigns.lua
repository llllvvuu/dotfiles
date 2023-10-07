--- @type LazyPluginSpec
return {
  "lewis6991/gitsigns.nvim",
  dependencies = { "hydra.nvim", "neogit" },
  lazy = false,
  config = function()
    local gitsigns = require("gitsigns")
    gitsigns.setup()
    local hint = [[
      _J_: next hunk   _s_: stage hunk        _d_: show deleted   _b_: blame line
      _K_: prev hunk   _u_: undo last stage   _p_: preview hunk   _w_: word diff
      ^ ^              _S_: stage buffer      ^ ^
      ^
      ^ ^              _<Enter>_: Neogit              _q_: exit
      ]]
    require("hydra")({
      name = "gitsigns / neogit",
      hint = hint,
      config = {
        color = "pink",
        invoke_on_body = true,
        hint = {
          border = "rounded",
        },
        on_enter = function()
          vim.cmd("mkview")
          vim.cmd("silent! %foldopen!")
          vim.bo.modifiable = false
          gitsigns.toggle_linehl(true)
          gitsigns.toggle_deleted(true)
          gitsigns.toggle_word_diff(true)
        end,
        on_exit = function()
          local cursor_pos = vim.api.nvim_win_get_cursor(0)
          vim.cmd("loadview")
          vim.api.nvim_win_set_cursor(0, cursor_pos)
          vim.cmd("normal zv")
          gitsigns.toggle_linehl(false)
          gitsigns.toggle_deleted(false)
          gitsigns.toggle_word_diff(false)
        end,
      },
      mode = { "n", "x" },
      body = "<leader>g",
      heads = {
        {
          "J",
          function()
            if vim.wo.diff then
              return "]c"
            end
            vim.schedule(function()
              gitsigns.next_hunk()
            end)
            return "<Ignore>"
          end,
          { expr = true, desc = "next hunk" },
        },
        {
          "K",
          function()
            if vim.wo.diff then
              return "[c"
            end
            vim.schedule(function()
              gitsigns.prev_hunk()
            end)
            return "<Ignore>"
          end,
          { expr = true, desc = "prev hunk" },
        },
        { "s", gitsigns.stage_hunk, { silent = true, desc = "stage hunk" } },
        { "u", gitsigns.undo_stage_hunk, { desc = "undo last stage" } },
        { "S", gitsigns.stage_buffer, { desc = "stage buffer" } },
        { "p", gitsigns.preview_hunk, { desc = "preview hunk" } },
        -- stylua: ignore
        { "d", gitsigns.toggle_deleted, { nowait = true, desc = "toggle deleted" } },
        { "w", gitsigns.toggle_word_diff, { desc = "toggle word diff" } },
        {
          "b",
          function()
            gitsigns.blame_line({ full = true })
          end,
          { desc = "blame show full" },
        },
        { "<Enter>", "<Cmd>Neogit<CR>", { exit = true, desc = "Neogit" } },
        { "q", nil, { exit = true, nowait = true, desc = "exit" } },
      },
    })
  end,
}
