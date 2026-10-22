vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf
		local function map(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, noremap = true, desc = desc })
		end

		map("n", "K", vim.lsp.buf.hover, "LSP Hover")
		map("n", "<leader>cR", vim.lsp.buf.rename, "Rename Symbol")
		map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
		map("n", "[d", vim.diagnostic.goto_prev, "Prev Diagnostic")
		map("n", "]d", vim.diagnostic.goto_next, "Next Diagnostic")

		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client and vim.lsp.inlay_hint and client.server_capabilities.inlayHintProvider then
			vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
		end
	end,
})

return {
	{ "williamboman/mason.nvim", build = ":MasonUpdate", opts = {} },

	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig", "hrsh7th/cmp-nvim-lsp" },
		config = function()
			-- Global capabilities (cmp completions)
			vim.lsp.config("*", {
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
			})

			-- Overrides on top of nvim-lspconfig's built-in lsp/*.lua defaults
			local clangd_bin = vim.fn.executable("/opt/homebrew/opt/llvm/bin/clangd") == 1
					and "/opt/homebrew/opt/llvm/bin/clangd"
				or "clangd"

			vim.lsp.config("clangd", {
				cmd = {
					clangd_bin,
					"--header-insertion=never",
					"--completion-style=detailed",
					"--background-index",
					"--offset-encoding=utf-16",
					"--function-arg-placeholders=false",
					"--query-driver=/usr/bin/gcc,/usr/bin/clang,/opt/homebrew/opt/llvm/bin/clang,/opt/homebrew/bin/gcc*,/usr/bin/*gcc*,/usr/bin/*clang*",
				},
				root_markers = {
					".clangd",
					".clang-tidy",
					".clang-format",
					"compile_commands.json",
					"compile_flags.txt",
					"configure.ac",
					"Makefile",
					"makefile",
					"GNUmakefile",
					".git",
				},
				before_init = function(params, config)
					local root = (type(params.rootUri) == "string" and vim.uri_to_fname(params.rootUri))
						or config.root_dir
						or vim.fn.getcwd()
					params.initializationOptions = params.initializationOptions or {}
					local fallback = params.initializationOptions.fallbackFlags or {}
					if root then
						local default_dirs = {
							"-I" .. root,
							"-I" .. root .. "/include",
							"-I" .. root .. "/inc",
							"-I" .. root .. "/src",
						}
						for _, flag in ipairs(default_dirs) do
							table.insert(fallback, flag)
						end
					end
					params.initializationOptions.fallbackFlags = fallback
				end,
			})

			vim.lsp.config("rust_analyzer", {
				settings = {
					["rust-analyzer"] = {
						checkOnSave = true,
						check = { command = "clippy" },
						cargo = { allFeatures = true },
						procMacro = { enable = true },
					},
				},
			})

			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						workspace = { checkThirdParty = false },
						diagnostics = { globals = { "vim" } },
					},
				},
			})

            vim.lsp.config("ocamllsp", {
                cmd = { "opam", "exec",  "--", "ocamllsp" },
                filetypes = { "ocaml", "ocamlinterace" },
                root_markers = { "dune-project", ".git", "*.opam"}
            })

			require("mason-lspconfig").setup({
				ensure_installed = { "clangd", "rust_analyzer", "jdtls", "lua_ls", "marksman", "zls", "ocamllsp" },
			})
		end,
	},

	{ "neovim/nvim-lspconfig" },
}
