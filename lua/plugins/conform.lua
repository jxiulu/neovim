return {
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				c = { "clang_format" },
				cpp = { "clang_format" },
				java = { "google-java-format" },
				rust = { "rustfmt" },
				zig = { "zigfmt" },
				markdown = { "prettier" },
			},
			formatters = {
				clang_format = {
					prepend_args = {
						"--style={BasedOnStyle: LLVM, UseTab: Never, IndentWidth: 4, BreakBeforeBraces: Linux, AllowShortIfStatementsOnASingleLine: false, IndentCaseLabels: false, ColumnLimit: 80}",
					},
				},
			},
		},
		keys = {
			{
				"<leader>cf",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = { "n", "v" },
				desc = "Format buffer/selection",
			},
		},
	},
}
