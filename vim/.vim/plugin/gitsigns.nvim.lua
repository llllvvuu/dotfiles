require('gitsigns').setup{
  signcolumn = true,
  numhl      = true,
  current_line_blame = true,
  current_line_blame_opts = {
    delay = 250,
    ignore_whitespace = false,
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']h', function()
      if vim.wo.diff then return ']h' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    map('n', '[h', function()
      if vim.wo.diff then return '[h' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    -- Actions
    map('n',
      '<leader>gb',
      function() gs.blame_line{full=true} end,
      { desc = 'Show commit of blame' }
    )
    map('n', '<leader>gd', gs.diffthis, { desc = "Diff Index"} )
    map('n',
      '<leader>gD',
      function() gs.diffthis('~') end,
      { desc = "Diff HEAD^" }
    )
    map('n', '<leader>gx', gs.toggle_deleted, { desc = "Show Deleted" })
    map('n',
      '<leader>gw',
      gs.toggle_word_diff,
      { desc = "Highlight diffed words" }
    )
    map('n', '<leader>gs', gs.stage_hunk, { desc = "Stage Hunk" })
    map('n', '<leader>gr', gs.reset_hunk, { desc = "Reset Hunk" })
    map('n', '<leader>gu', gs.undo_stage_hunk, { desc = "Undo Stage Hunk"})
    map('n', '<leader>gS', gs.stage_buffer, { desc = "Stage Buffer" })
    map('n', '<leader>gu', gs.undo_stage_hunk, { desc = "Undo Stage Hunk" })
    map('n', '<leader>gR', gs.reset_buffer, { desc = "Reset Buffer" })
    map('n', '<leader>gp', gs.preview_hunk, { desc = "Preview Hunk" })

    -- Text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
}
