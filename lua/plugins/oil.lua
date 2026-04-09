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
}
