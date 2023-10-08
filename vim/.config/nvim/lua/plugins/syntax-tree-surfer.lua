--- @diagnostic disable: missing-fields

local prefix = "<leader><C-v>" -- dummy prefix for mini.clue

local function surf_parent()
  local surfer = require("syntax-tree-surfer")
  if vim.api.nvim_get_mode().mode ~= "v" then
    surfer.select_current_node()
  else
    surfer.surf("parent", "visual")
  end
end

--- @type LazyPluginSpec
return {
  "ziontee113/syntax-tree-surfer",
  dependencies = { "nvim-treesitter" },
  lazy = false,
  keys = {
    {
      "<C-k>",
      function()
        vim.opt.opfunc = "v:lua.STSSwapUpNormal_Dot"
        vim.api.nvim_feedkeys("g@l", "n", true)
      end,
      desc = "Treesitter Swap Up",
    },
    {
      "<C-j>",
      function()
        vim.opt.opfunc = "v:lua.STSSwapDownNormal_Dot"
        vim.api.nvim_feedkeys("g@l", "n", true)
      end,
      desc = "Treesitter Swap Down",
    },
    {
      "<C-n>",
      function()
        vim.opt.opfunc = "v:lua.STSSwapCurrentNodeNextNormal_Dot"
        vim.api.nvim_feedkeys("g@l", "n", true)
      end,
      desc = "Treesitter Swap Next",
    },
    {
      "<C-p>",
      function()
        vim.opt.opfunc = "v:lua.STSSwapCurrentNodePrevNormal_Dot"
        vim.api.nvim_feedkeys("g@l", "n", true)
      end,
      desc = "Treesitter Swap Prev",
    },

    -- stylua: ignore start
    { "<M-o>", "<Cmd>STSSelectCurrentNode<CR>", desc = "Treesitter Select Current Node" },
    { "<M-ø>", "<Cmd>STSSelectCurrentNode<CR>", desc = "Treesitter Select Current Node" },
    { "ø", "<Cmd>STSSelectCurrentNode<CR>", desc = "Treesitter Select Current Node" },

    { "<M-n>", "<Cmd>STSSelectNextSiblingNode<CR>", mode = "x", desc = "Treesitter Select Next" },
    { "<M-˜>", "<Cmd>STSSelectNextSiblingNode<CR>", mode = "x", desc = "Treesitter Select Next" },
    { "˜", "<Cmd>STSSelectNextSiblingNode<CR>", mode = "x", desc = "Treesitter Select Next" },

    { "<M-p>", "<Cmd>STSSelectPrevSiblingNode<CR>", mode = "x", desc = "Treesitter Select Prev" },
    { "π", "<Cmd>STSSelectPrevSiblingNode<CR>", mode = "x", desc = "Treesitter Select Prev" },
    { "<M-π>", "<Cmd>STSSelectPrevSiblingNode<CR>", mode = "x", desc = "Treesitter Select Prev" },

    { "<M-o>", "<Cmd>STSSelectParentNode<CR>", mode = "x", desc = "Treesitter Select Parent" },
    { "<M-ø>", "<Cmd>STSSelectParentNode<CR>", mode = "x", desc = "Treesitter Select Parent" },
    { "ø", "<Cmd>STSSelectParentNode<CR>", mode = "x", desc = "Treesitter Select Parent" },

    { "<M-i>", "<Cmd>STSSelectChildNode<CR>", mode = "x", desc = "Treesitter Select Child" },
    { "<M-ˆ>", "<Cmd>STSSelectChildNode<CR>", mode = "x", desc = "Treesitter Select Child" },
    { "ˆ", "<Cmd>STSSelectChildNode<CR>", mode = "x", desc = "Treesitter Select Child" },

    { "<C-n>", "<Cmd>STSSwapNextVisual<CR>", mode = "x" },
    { "<C-p>", "<Cmd>STSSwapPrevVisual<CR>", mode = "x" },
    { "<C-s>", function() require("syntax-tree-surfer").hold_or_swap(true) end, mode = "x" },
    { "<leader>v", surf_parent, mode = { "n", "x", "v" } , desc = "visual syntax-tree-surfer" },
    { prefix .."O", surf_parent, mode = { "n", "x", "v" }, desc = "parent ([O]ut)" },
    { prefix .."I", function()
      require("syntax-tree-surfer").surf("child", "visual")
    end, mode = { "x", "v" }, desc = "child ([I]n)" },
    { prefix .. "n", function()
      require("syntax-tree-surfer").surf("next", "visual")
    end, mode = { "x", "v" }, desc = "next" },
    { prefix .. "p", function()
      require("syntax-tree-surfer").surf("prev", "visual")
    end, mode = { "x", "v" }, desc = "previous" },
    { prefix .. "N", function()
      require("syntax-tree-surfer").surf("next", "visual", true)
    end, mode = { "x", "v" }, desc = "Swap with [N]ext" },
    { prefix .. "P", function()
      require("syntax-tree-surfer").surf("prev", "visual", true)
    end, mode = { "x", "v" }, desc = "Swap with [P]revious" },
    { prefix .. "s", function()
      require("syntax-tree-surfer").hold_or_swap(true)
    end, mode = { "x", "v" }, desc = "hold or [s]wap" },
    { prefix .. "q", function() vim.cmd("norm! ") end, mode = { "n", "x", "v" }, desc = "quit" },
    { prefix .. "<Space>", function() end, mode = { "n", "x", "v" }, desc = "confirm selection" },
    -- stylua: ignore end
  },
  config = true,
}
