return {
  {
    "ziontee113/syntax-tree-surfer",
    dependencies = { "nvim-treesitter" },
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
      {
        "<M-o>",
        "<Cmd>STSSelectCurrentNode<CR>",
        desc = "Treesitter Select Current Node",
      },
      {
        "<M-ø>",
        "<Cmd>STSSelectCurrentNode<CR>",
        desc = "Treesitter Select Current Node",
      },
      {
        "ø",
        "<Cmd>STSSelectCurrentNode<CR>",
        desc = "Treesitter Select Current Node",
      },
      {
        "<M-n>",
        "<Cmd>STSSelectNextSiblingNode<CR>",
        mode = "x",
        desc = "Treesitter Select Next",
      },
      {
        "<M-˜>",
        "<Cmd>STSSelectNextSiblingNode<CR>",
        mode = "x",
        desc = "Treesitter Select Next",
      },
      {
        "˜",
        "<Cmd>STSSelectNextSiblingNode<CR>",
        mode = "x",
        desc = "Treesitter Select Next",
      },
      {
        "<M-p>",
        "<Cmd>STSSelectPrevSiblingNode<CR>",
        mode = "x",
        desc = "Treesitter Select Prev",
      },
      {
        "π",
        "<Cmd>STSSelectPrevSiblingNode<CR>",
        mode = "x",
        desc = "Treesitter Select Prev",
      },
      {
        "<M-π>",
        "<Cmd>STSSelectPrevSiblingNode<CR>",
        mode = "x",
        desc = "Treesitter Select Prev",
      },
      {
        "<M-o>",
        "<Cmd>STSSelectParentNode<CR>",
        mode = "x",
        desc = "Treesitter Select Parent",
      },
      {
        "<M-ø>",
        "<Cmd>STSSelectParentNode<CR>",
        mode = "x",
        desc = "Treesitter Select Parent",
      },
      {
        "ø",
        "<Cmd>STSSelectParentNode<CR>",
        mode = "x",
        desc = "Treesitter Select Parent",
      },
      {
        "<M-i>",
        "<Cmd>STSSelectChildNode<CR>",
        mode = "x",
        desc = "Treesitter Select Child",
      },
      {
        "<M-ˆ>",
        "<Cmd>STSSelectChildNode<CR>",
        mode = "x",
        desc = "Treesitter Select Child",
      },
      {
        "ˆ",
        "<Cmd>STSSelectChildNode<CR>",
        mode = "x",
        desc = "Treesitter Select Child",
      },
      { "<C-n>", "<Cmd>STSSwapNextVisual<CR>", mode = "x" },
      { "<C-p>", "<Cmd>STSSwapPrevVisual<CR>", mode = "x" },
    },
    opts = {},
  },
}
