return {
	{ "lewis6991/gitsigns.nvim", event = { "BufReadPre", "BufNewFile" }, opts = {} },
	{ "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
	{
		"folke/which-key.nvim",
		opts = {
			spec = {
				{ "<leader>u", group = "UI/Toggles" },
				{ "<leader>w", group = "Window" },
				{ "<leader>t", group = "Tab" },
				{ "<leader>f", group = "Find" },
				{ "<leader>s", group = "Search" },
				{ "<leader>g", group = "Git" },
				{ "<leader>c", group = "Code" },
				{ "<leader>d", group = "Debug" },
				{ "<leader>x", group = "Diagnostics" },
				{ "<leader>o", group = "Oil" },
			},
		},
	},
	-- Single icon provider; also stands in for nvim-web-devicons (lualine, grapple)
	{
		"echasnovski/mini.icons",
		lazy = true,
		opts = {},
		init = function()
			package.preload["nvim-web-devicons"] = function()
				require("mini.icons").mock_nvim_web_devicons()
				return package.loaded["nvim-web-devicons"]
			end
		end,
	},
}
