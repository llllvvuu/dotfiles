return {
  {
    "llllvvuu/syntax-tree-surfer",
    branch = "dev",
    dependencies = { "nvim-treesitter", "hydra.nvim" },
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
      -- stylua: ignore end
    },
    opts = {},
    config = function()
      local surfer = require("syntax-tree-surfer")
      surfer.setup()
      local hint = [[
      _n_: Next Sibling     _p_: Previous Sibling     _O_: Out (Parent Node)     _I_: In (Child Node)
      _N_: Swap w/ Next     _P_: Swap w/ Previous     _s_: Hold Or Swap Node
      ^
      _<Enter>_: Exit (Keep Selection)              _q_: Exit (Discard Selection)
      ]]
      require("hydra")({
        name = "syntax-tree-[S]urfer",
        body = "<leader>S",
        mode = { "n", "x" },
        hint = not vim.g.vscode and hint,
        config = {
          color = "pink",
          invoke_on_body = true,
          hint = {
            border = "rounded",
          },
          on_enter = function()
            vim.bo.modifiable = false
            surfer.select_current_node()
            surfer.clear_held_node()
          end,
          on_exit = function()
            surfer.clear_held_node()
          end,
        },
        -- stylua: ignore
        heads = {
          { "n", function() surfer.surf("next", "visual") end },
          { "p", function() surfer.surf("prev", "visual") end },
          {
            "O",
            function()
              if vim.api.nvim_get_mode().mode ~= "v" then
                surfer.select_current_node()
              else
                surfer.surf("parent", "visual")
              end
            end,
          },
          { "I", function() surfer.surf("child", "visual") end },
          {
            "N",
            function()
              vim.bo.modifiable = true
              surfer.surf("next", "visual", true)
              vim.bo.modifiable = false
            end,
            { desc = "swapN" },
          },
          {
            "P",
            function()
              vim.bo.modifiable = true
              surfer.surf("prev", "visual", true)
              vim.bo.modifiable = false
            end,
          },
          {
            "s",
            function()
              vim.bo.modifiable = true
              surfer.hold_or_swap(true)
              vim.bo.modifiable = false
            end,
            { desc = "holdswap" },
          },
          { "<Enter>", nil, { exit = true, nowait = true, desc = "keep" } },
          {
            "q",
            function()
              vim.cmd("norm! ")
            end,
            { exit = true, nowait = true, desc = "discard" },
          },
        },
      })
    end,
  },
}
