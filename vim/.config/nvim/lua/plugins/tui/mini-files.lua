--- @diagnostic disable: missing-fields
---
--- @type LazyPluginSpec
return {
  "echasnovski/mini.files",
  dependencies = { "telescope.nvim" },
  keys = {
    {
      "<leader>m",
      function()
        require("mini.files").open(vim.api.nvim_buf_get_name(0))
      end,
      desc = "mini.files",
    },
    {
      "<leader>M",
      function()
        local pickers = require("telescope.pickers")
        local finders = require("telescope.finders")
        local conf = require("telescope.config").values
        local actions = require("telescope.actions")
        local action_state = require("telescope.actions.state")

        local mini_files_picker = function(opts)
          opts = opts or {}

          pickers
            .new(opts, {
              prompt_title = "Git Files",
              finder = finders.new_oneshot_job({ "git", "ls-files" }, opts),
              sorter = conf.file_sorter(opts),
              previewer = conf.file_previewer(opts),

              attach_mappings = function(prompt_bufnr)
                actions.select_default:replace(function()
                  actions.close(prompt_bufnr)
                  require("mini.files").open(
                    action_state.get_selected_entry()[1],
                    false
                  )
                end)

                return true
              end,
            })
            :find()
        end
        mini_files_picker()
      end,
      desc = "mini.files (telescope.nvim)",
    },
  },
  opts = {
    window = {
      preview = true,
      width_preview = 80,
    },
  },
}
