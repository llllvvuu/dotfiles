--- @diagnostic disable: param-type-mismatch

--- @param is_available boolean
--- @param keys LazyKeys[]
--- @param prefix string
--- @param overrides table<string, string?>?
--- @param modes (string | string[])?
local function submode(is_available, keys, prefix, overrides, modes)
  overrides = overrides or {}
  if is_available then
    local clues = {}
    for _, key in pairs(keys) do
      local postkeys = overrides[key[1]] ~= nil and overrides[key[1]] or prefix
      if postkeys ~= "" then
        for _, mode in pairs(modes or { "n" }) do
          table.insert(clues, {
            mode = mode,
            keys = key[1],
            postkeys = postkeys,
          })
        end
      end
    end
    return clues
  else
    return {}
  end
end

local function native_window_submode_extra()
  local win_keys = { "c", "o", "=", "_", "+", "s", "v", "m", "z" }
  return vim.tbl_map(function(key)
    return { mode = "n", keys = "<C-w>" .. key, postkeys = "<C-w>" }
  end, win_keys)
end

return {
  "echasnovski/mini.clue",
  opts = function()
    local miniclue = require("mini.clue")
    return {
      triggers = {
        { mode = "n", keys = "<Leader>" },
        { mode = "x", keys = "<Leader>" },

        { mode = "n", keys = "g" },
        { mode = "x", keys = "g" },

        { mode = "n", keys = "'" },
        { mode = "n", keys = "`" },
        { mode = "x", keys = "'" },
        { mode = "x", keys = "`" },

        { mode = "n", keys = '"' },
        { mode = "x", keys = '"' },
        { mode = "i", keys = "<C-r>" },
        { mode = "c", keys = "<C-r>" },

        { mode = "n", keys = "<C-w>" },

        { mode = "n", keys = "z" },
        { mode = "x", keys = "z" },
      },

      -- stylua: ignore
      clues = {
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows({
          submode_move = true,
          submode_navigate = true,
          submode_resize = true,
        }),
        miniclue.gen_clues.z(),
        miniclue.gen_clues.g(),
        { mode = "n", keys = "g'", desc = "Jump to mark (don't affect jumplist)" },
        { mode = "n", keys = "g`", desc = "Jump to mark (don't affect jumplist)" },
        { mode = "x", keys = "g'", desc = "Jump to mark (don't affect jumplist)" },
        { mode = "x", keys = "g`", desc = "Jump to mark (don't affect jumplist)" },
        { mode = "n", keys = "<leader>l", desc = "LSP" },
        { mode = "n", keys = "<leader>x", desc = "trouble.nvim" },
        { mode = "n", keys = "<leader>d", desc = "DAP" },
        { mode = "n", keys = "<leader><C-t>", desc = "[DUMMY - IGNORE]" },
        { mode = "n", keys = "<leader><C-g>", desc = "[DUMMY - IGNORE]" },
        { mode = "n", keys = "<leader><C-g>y", postkeys = "<leader><C-g>" },
        { mode = "n", keys = "<leader><C-v>", desc = "[DUMMY - IGNORE]" },
        { mode = "x", keys = "<leader><C-v>", desc = "[DUMMY - IGNORE]" },
        { mode = "x", keys = "<leader>g", desc = "git" },
        native_window_submode_extra(),
        submode(
          not vim.g.vscode and not vim.g.started_by_firenvim,
          require("plugins-tui.nvim-dap").keys,
          "<leader>d"
        ),
        submode(
          not vim.g.vscode and not vim.g.started_by_firenvim,
          require("plugins-tui.neotest").keys,
          "<leader><C-t>",
          { ["<leader><C-t>q"] = "", ["<leader><C-t>d"] = "<leader>d" }
        ),
        submode(
          not vim.g.vscode and not vim.g.started_by_firenvim,
          require("plugins-tui.gitsigns").keys,
          "<leader><C-g>",
          { ["<leader><C-g>q"] = "", ["<leader><C-g>g"] = "" }
        ),
        submode(
          true,
          --- @param key LazyKeys
          vim.tbl_filter(function(key)
            return key[1]:byte(-1) >= 65 and key[1]:byte(-1) <= 122
          end, require("plugins.syntax-tree-surfer").keys),
          "<leader><C-v>",
          { ["<leader><C-v>q"] = "" },
          { "n", "x", "v" }
        ),
      },
      window = {
        config = {
          width = 42,
        },
        delay = 69,
        scroll_down = "<C-d>",
        scroll_up = "<C-u>",
      },
    }
  end,
}
