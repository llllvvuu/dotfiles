return {
	{
		"zbirenbaum/copilot-cmp",
    event = "InsertEnter",
    dependencies = {
      "zbirenbaum/copilot.lua",
      opts = {
        suggestion = { enabled = false },
        panel = { enabled = false },
      }
    },
		config = function()
			require("copilot_cmp").setup()
		end,
	},
}
