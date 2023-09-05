vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "TSUpdateSync" },
		keys = {
			{ "<c-space>", desc = "Increment selection" },
			{ "<bs>", desc = "Decrement selection", mode = "x" },
		},
		---@type TSConfig
		opts = {
			context_commentstring = {
				enable = true,
				enable_autocmd = false,
			},
			highlight = {
				enable = true,
				disable = function(_, buf)
					local max_filesize = 100 * 1024 -- 100 KB
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end
				end,
			},
			indent = { enable = true },
			ensure_installed = "all",
			sync_install = false,
			auto_install = true,
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-s>",
					node_incremental = "<C-s>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	{
		"kevinhwang91/nvim-ufo",
		dependencies = "kevinhwang91/promise-async",
		event = "BufReadPost",
		opts = {
			{
				provider_selector = function()
					return { "lsp", "treesitter", "indent" }
				end,
			},
		},
		init = function()
			vim.keymap.set("n", "zR", function()
				require("ufo").openAllFolds()
			end)
			vim.keymap.set("n", "zM", function()
				require("ufo").closeAllFolds()
			end)
		end,
	},
	{
		"ziontee113/syntax-tree-surfer",
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
				"<M-l>",
				function()
					vim.opt.opfunc = "v:lua.STSSwapCurrentNodeNextNormal_Dot"
					vim.api.nvim_feedkeys("g@l", "n", true)
				end,
        desc = "Treesitter Swap Next",
			},
			{
				"<M-h>",
				function()
					vim.opt.opfunc = "v:lua.STSSwapCurrentNodePrevNormal_Dot"
					vim.api.nvim_feedkeys("g@l", "n", true)
				end,
        desc = "Treesitter Swap Prev",
			},
			{ "<leader>v", "<Cmd>STSSelectMasterNode<CR>", desc = "Select Treesitter Master Node" },
			{ "J", "<Cmd>STSSelectNextSiblingNode<CR>", mode = "x", desc = "Treesitter Select Next" },
			{ "K", "<Cmd>STSSelectPrevSiblingNode<CR>", mode = "x" },
			{ "H", "<Cmd>STSSelectParentNode<CR>", mode = "x" },
			{ "L", "<Cmd>STSSelectChildNode<CR>", mode = "x" },
			{ "<C-j>", "<Cmd>STSSwapNextVisual<CR>", mode = "x" },
			{ "<C-k>", "<Cmd>STSSwapPrevVisual<CR>", mode = "x" },
		},
		opts = {},
	},
	{
		"llllvvuu/ssr.nvim",
		branch = "feat/open_last_pattern",
		keys = {
			{
				"<leader>sr",
				function()
					require("ssr").open()
				end,
				mode = { "n", "x" },
        desc = "Structural Search + Replace"
			},
		},
	},
	{
		"Wansmer/treesj",
		keys = {
			{ "gs", "<Cmd>TSJSplit<CR>" },
			{ "gj", "<Cmd>TSJJoin<CR>" },
		},
		opts = {
			use_default_keymaps = false,
			max_join_length = 80,
		},
	},
	{
		"HiPhish/rainbow-delimiters.nvim",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			local rainbow_delimiters = require("rainbow-delimiters")

			vim.g.rainbow_delimiters = {
				strategy = {
					[""] = rainbow_delimiters.strategy["global"],
					vim = rainbow_delimiters.strategy["local"],
				},
				query = {
					[""] = "rainbow-delimiters",
					lua = "rainbow-blocks",
				},
				highlight = {
					"RainbowDelimiterRed",
					"RainbowDelimiterYellow",
					"RainbowDelimiterBlue",
					"RainbowDelimiterOrange",
					"RainbowDelimiterGreen",
					"RainbowDelimiterViolet",
					"RainbowDelimiterCyan",
				},
			}
		end,
	},
	{
		"stevearc/aerial.nvim",
		keys = {
			{ "{", "<cmd>AerialPrev<CR>", desc = "Prev function/interface" },
			{ "}", "<cmd>AerialNext<CR>", desc = "Next function/interface" },
			{ "<leader>a", "<cmd>AerialToggle! left<CR>", desc = "Open Aerial view" },
		},
		opts = {},
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
	},
}
