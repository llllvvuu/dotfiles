return {
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>xx", function() require("trouble").open() end },
      { "<leader>xw", function() require("trouble").open("workspace_diagnostics") end },
      { "<leader>xd", function() require("trouble").open("document_diagnostics") end },
    }
	},
}
