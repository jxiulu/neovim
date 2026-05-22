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
		dir = vim.fn.stdpath("config"),
		name = "lar-ping",
		lazy = false,
		priority = 1000,
		opts = {
		},
		config = function(_, opts)
			require("lar-ping").setup(opts)
			_G.reload_colorscheme = function()
				for k in pairs(package.loaded) do
					if k:find("lar%-ping") then
						package.loaded[k] = nil
					end
				end
				require("lar-ping").setup(opts)
				vim.cmd.colorscheme("lar-ping")
				vim.notify("Reloaded: lar-ping")
			end
		end,
	},
}
