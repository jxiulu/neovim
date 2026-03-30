return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			bigfile = { enabled = true },
			dashboard = { enabled = true },
			notifier = { enabled = true },
			picker = { enabled = true },
			quickfile = { enabled = true },
			scope = { enabled = true },
			words = { enabled = true },
			zen = { enabled = true },
		},
		keys = {
			-- File pickers
			{ "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
			{ "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
			{ "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent Files" },
			{ "<leader>fc", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },

			-- Search
			{ "<leader>sb", function() Snacks.picker.lines() end, desc = "Search Buffer Lines" },
			{ "<leader>sg", function() Snacks.picker.grep() end, desc = "Live Grep" },
			{ "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Grep Word", mode = { "n", "x" } },

			-- LSP pickers
			{ "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
			{ "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
			{ "gr", function() Snacks.picker.lsp_references() end, desc = "References" },
			{ "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
			{ "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto Type Definition" },
			{ "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },

			-- Git
			{ "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
			{ "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
			{ "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },

			-- UI toggles
			{ "<leader>uz", function() Snacks.zen() end, desc = "Zen Mode" },
			{ "<leader>ns", function() Snacks.notifier.show_history() end, desc = "Notification History" },
		},
		init = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "VeryLazy",
				callback = function()
					_G.dd = function(...) Snacks.debug.inspect(...) end
					_G.bt = function() Snacks.debug.backtrace() end
					vim.print = _G.dd

					Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
					Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
					Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
					Snacks.toggle.diagnostics():map("<leader>ud")
					Snacks.toggle.line_number():map("<leader>ul")
					Snacks.toggle.inlay_hints():map("<leader>uh")
					Snacks.toggle
						.option("background", { off = "light", on = "dark", name = "Dark Background" })
						:map("<leader>ub")
				end,
			})
		end,
	},
}
