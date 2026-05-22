return {
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
}
