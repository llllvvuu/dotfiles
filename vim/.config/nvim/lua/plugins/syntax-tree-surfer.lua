return {
  {
    "ziontee113/syntax-tree-surfer",
    dependencies = vim.g.vscode and { "nvim-treesitter" }
      or { "nvim-treesitter", "hydra.nvim" },
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
      {
        "<C-s>",
        function()
          require("syntax-tree-surfer").hold_or_swap(true)
        end,
        mode = "x",
      },
    },
    opts = {},
    config = function()
      local surfer = require("syntax-tree-surfer")
      surfer.setup()
      local ok, Hydra = pcall(require, "hydra")
      if ok then
        local hint = [[
        _n_: Next Sibling     _p_: Previous Sibling     _o_: Out (Parent Node)     _i_: In (Child Node)
        _N_: Swap w/ Next     _P_: Swap w/ Previous     _s_: Hold Or Swap Node
        ^
        _<Enter>_: Exit (Keep Selection)              _q_: Exit (Discard Selection)
        ]]
        Hydra({
          name = "syntax-tree-[S]urfer",
          body = "<leader>S",
          mode = { "n", "x" },
          hint = hint,
          config = {
            color = "amaranth",
            invoke_on_body = true,
            hint = {
              border = "rounded",
            },
            on_enter = function()
              surfer.select_current_node()
              surfer.held_node = nil
            end,
            on_exit = function()
              if surfer.held_node then
                vim.api.nvim_buf_del_extmark(
                  0,
                  surfer.ns,
                  surfer.held_node.extmark_id
                )
                surfer.held_node = nil
              end
            end,
          },
          heads = {
            {
              "n",
              function()
                surfer.surf("next", "visual")
              end,
              { desc = "Next Sibling" },
            },
            {
              "p",
              function()
                surfer.surf("prev", "visual")
              end,
              { desc = "Prev Sibling" },
            },
            {
              "o",
              function()
                surfer.surf("parent", "visual")
              end,
              { desc = "Out (Parent Node)" },
            },
            {
              "i",
              function()
                surfer.surf("child", "visual")
              end,
              { desc = "In (Child Node)" },
            },
            {
              "N",
              function()
                surfer.surf("next", "visual", true)
              end,
              { desc = "Swap With Next Sibling" },
            },
            {
              "P",
              function()
                surfer.surf("prev", "visual", true)
              end,
              { desc = "Swap With Prev Sibling" },
            },
            {
              "s",
              function()
                surfer.hold_or_swap(true)
              end,
              { desc = "Hold Or Swap Node" },
            },
            {
              "<Enter>",
              nil,
              { exit = true, nowait = true, desc = "Exit (Keep Selection)" },
            },
            {
              "q",
              function()
                vim.cmd("norm! ")
              end,
              { exit = true, nowait = true, desc = "Exit (Discard Selection)" },
            },
          },
        })
      end
    end,
  },
}
