return {
  {
    "ggandor/leap.nvim",
    keys = {
      { "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
      { "S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
    },
    config = function()
      local leap = require("leap")
      leap.add_default_mappings()
      leap.add_repeat_mappings('g;', 'g,', {
        relative_directions = true,
        modes = {'n', 'x', 'o'},
      })
    end,
  },
}
