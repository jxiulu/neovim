local function lsp_on_attach(client, bufnr)
	local function map(mode, lhs, rhs, desc)
		vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, noremap = true, desc = desc })
	end

	map("n", "K", vim.lsp.buf.hover, "LSP Hover")
	map("n", "<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
	map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
	map("n", "[d", vim.diagnostic.goto_prev, "Prev Diagnostic")
	map("n", "]d", vim.diagnostic.goto_next, "Next Diagnostic")

	if vim.lsp.inlay_hint and client.server_capabilities.inlayHintProvider then
		vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
	end
end

return {
	{ "williamboman/mason.nvim", build = ":MasonUpdate", opts = {} },

	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig", "hrsh7th/cmp-nvim-lsp" },
		opts = function()
			local lspconfig = require("lspconfig")
			local util = require("lspconfig.util")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local base_opts = { on_attach = lsp_on_attach, capabilities = capabilities }

			local servers = {
				-- C/C++
				clangd = {
					cmd = {
						"clangd",
						"--header-insertion=never",
						"--completion-style=detailed",
						"--background-index",
						"--offset-encoding=utf-16",
						"--function-arg-placeholders=false",
					},
					init_options = {
						clangdFileStatus = true,
						fallbackFlags = { "-Xclang", "-code-completion-brief-comments" },
					},
					root_dir = util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
				},

				-- Rust
				rust_analyzer = {
					settings = {
						["rust-analyzer"] = {
							checkOnSave = { command = "clippy" },
							cargo = { allFeatures = true },
							procMacro = { enable = true },
						},
					},
					root_dir = util.root_pattern("Cargo.toml", ".git"),
				},

				-- Java
				jdtls = {
					root_dir = util.root_pattern("build.gradle", "pom.xml", "settings.gradle", ".git"),
				},

				-- Zig
				zls = {},

				-- Lua (for config editing)
				lua_ls = {
					settings = {
						Lua = {
							workspace = { checkThirdParty = false },
							diagnostics = { globals = { "vim" } },
						},
					},
				},

				-- Markdown
				marksman = {},
			}

			return {
				ensure_installed = { "clangd", "rust_analyzer", "jdtls", "lua_ls", "marksman", "zls" },
				automatic_installation = false,
				handlers = {
					function(server_name)
						if not lspconfig[server_name] then
							return
						end
						lspconfig[server_name].setup(
							vim.tbl_deep_extend("force", {}, base_opts, servers[server_name] or {})
						)
					end,
				},
			}
		end,
	},

	{ "neovim/nvim-lspconfig" },
}
