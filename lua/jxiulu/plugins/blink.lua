return {
	{
		"saghen/blink.cmp",
		version = "1.*", -- release tag, so the prebuilt Rust fuzzy matcher is downloaded
		event = "InsertEnter",
		opts = {
			keymap = {
				-- <CR> accept, <C-n>/<C-p> select, <C-e> hide, <C-space> show
				preset = "enter",
				["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
				["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
			},
			sources = {
				default = { "lsp", "path", "snippets" },
			},
		},
	},
}
