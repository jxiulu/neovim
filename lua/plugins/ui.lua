return {
	{
		"stevearc/oil.nvim",
		dependencies = { "echasnovski/mini.icons" },
		lazy = false,
		opts = {
			default_file_explorer = true,
			columns = { "icon", "permissions", "size", "mtime" },
			view_options = {
				show_hidden = true,
				natural_order = true,
				sort = { { "type", "asc" }, { "name", "asc" } },
			},
			float = {
				padding = 2,
				max_width = 0.95,
				max_height = 0.90,
				border = "rounded",
			},
			delete_to_trash = true,
			skip_confirm_for_simple_edits = true,
		},
		keys = {
			{ "<leader>o", "<cmd>Oil<CR>", desc = "Open Oil" },
			{ "<leader>of", "<cmd>Oil --float<CR>", desc = "Open Oil (float)" },
		},
	},

	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				theme = "auto",
				section_separators = "",
				component_separators = "",
			},
		},
	},

	{
		"cbochs/grapple.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = { scope = "git_branch" },
		keys = {
			{ "<leader>m", "<cmd>Grapple toggle<cr>", desc = "Grapple Toggle" },
			{ "<leader>M", "<cmd>Grapple toggle_tags<cr>", desc = "Grapple Menu" },
			{ "<leader>n", "<cmd>Grapple cycle_tags next<cr>", desc = "Grapple Next" },
			{ "<leader>p", "<cmd>Grapple cycle_tags prev<cr>", desc = "Grapple Prev" },
		},
	},

	{
		"folke/trouble.nvim",
		opts = {},
		cmd = "Trouble",
		keys = {
			{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
			{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
			{ "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
		},
	},

	{ "lewis6991/gitsigns.nvim", event = { "BufReadPre", "BufNewFile" }, opts = {} },
	{ "numToStr/Comment.nvim", opts = {} },
	{ "folke/which-key.nvim", opts = {} },
	{ "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
}
