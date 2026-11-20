vim.lsp.log.set_level(vim.log.levels.ERROR)
-- delete the lsp log if it gets too big
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        local f = vim.lsp.log.get_filename()
        local st = vim.uv.fs_stat(f)
        if st and st.size > 5 * 1024 * 1024 then os.remove(f) end
    end,
})

-- code stuff
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf
		local function map(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, noremap = true, desc = desc })
		end

		-- K, [d, ]d, grn, gra, grr, gri, grt, gO are Neovim defaults
		map("n", "<leader>cR", vim.lsp.buf.rename, "Rename Symbol")
		map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
	end,
})

return {
	{ "williamboman/mason.nvim", build = ":MasonUpdate", opts = {} },

	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig", "saghen/blink.cmp" },
		config = function()
			-- Global capabilities (blink.cmp completions)
			vim.lsp.config("*", {
				capabilities = require("blink.cmp").get_lsp_capabilities(),
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
						check = { command = "clippy" },
						cargo = { allFeatures = true },
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
				cmd = { "opam", "exec", "--", "ocamllsp" },
			})
			vim.lsp.enable("ocamllsp") -- comes from opam, not Mason, so enable it explicitly

			require("mason-lspconfig").setup({
				ensure_installed = { "clangd", "rust_analyzer", "jdtls", "lua_ls", "marksman", "zls" },
			})
		end,
	},
}
