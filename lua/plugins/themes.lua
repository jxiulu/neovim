return {
	{
		"nickkadutskyi/jb.nvim",
		"NTBBloodbath/doom-one.nvim",
		"mswift42/vim-themes",
		"gaelph/nano.nvim",
		"abcwalk/gruber-darker-theme.nvim",
		"d11wtq/subatomic256.vim",
		"ThunderBoltCODMYT/gruber-darker.vim",
		"anshai-git/sephyr.nvim",
		"gregsexton/Muon",
		"baskerville/bubblegum",
		"zefei/simple-dark",
		lazy = false,
		priority = 1000,
		opts = {},
	},
	{
		dir = "/Users/jerrylu/Documents/Projects/BetterTheme",
		lazy = false,
		priority = 1000,
		config = function()
			require("bettertheme").setup({
				background = "#303030",
				lighter_background = "#3f3f3f",
				standard_text = "#dbdbdb",
				keywords = "#8fbf7a",
				type_names = "#ebebeb",
				syntax = "#c9c9c9",
				comments = "#AAAAAA",
				variables = "#b8b8b8",
			})
		end,
	},
}
