return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = function()
			vim.cmd.TSUpdate()
		end,
		config = function()
			local treesitter = require("nvim-treesitter")
			local parsers = {
				"c",
				"cpp",
				"java",
				"rust",
				"zig",
				"lua",
				"vim",
				"vimdoc",
				"markdown",
				"markdown_inline",
				"json",
				"toml",
				"bash",
			}

			treesitter.setup({
				install_dir = vim.fn.stdpath("data") .. "/site",
			})

			treesitter.install(parsers)

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("treesitter_start", { clear = true }),
				pattern = parsers,
				callback = function()
					if pcall(vim.treesitter.start) then
						vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})
		end,
	},
}
