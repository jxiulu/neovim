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
		dir = "/Users/jerrylu/Documents/Software/neovim/netenyahu-theme",
		name = "netenyahu",
		lazy = false,
		priority = 1000,
		opts = {
		},
		config = function(_, opts)
			require("netenyahu").setup(opts)
			_G.reload_colorscheme = function()
				for k in pairs(package.loaded) do
					if k:find("netenyahu", 1, true) then
						package.loaded[k] = nil
					end
				end
				require("netenyahu").setup(opts)
				vim.cmd.colorscheme("netenyahu")
				vim.notify("Reloaded: netenyahu")
			end
		end,
	},
}
