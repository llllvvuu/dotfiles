--- @diagnostic disable: missing-fields

--- @type LazyPluginSpec
return {
  "echasnovski/mini.surround",
  --- @diagnostic disable-next-line: assign-type-mismatch
  keys = function(_, keys)
    local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
    local opts = require("lazy.core.plugin").values(plugin, "opts", false)
    --- @type LazyKeys[]
    local mappings = {
      { opts.mappings.add, desc = "Add surrounding", mode = { "n", "v" } },
      { opts.mappings.delete, desc = "Delete surrounding" },
      { opts.mappings.find, desc = "Find right surrounding" },
      { opts.mappings.find_left, desc = "Find left surrounding" },
      { opts.mappings.highlight, desc = "Highlight surrounding" },
      { opts.mappings.replace, desc = "Replace surrounding" },
      {
        opts.mappings.update_n_lines,
        desc = "Update `MiniSurround.config.n_lines`",
      },
    }
    --- @type LazyKeys[]
    mappings = vim.tbl_filter(function(m)
      return m[1] and #m[1] > 0
    end, mappings)
    return vim.list_extend(mappings, keys)
  end,
  opts = {
    mappings = {
      add = "ys",
      delete = "ds",
      replace = "cs",
    },
  },
}
