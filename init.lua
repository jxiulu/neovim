-- poopoo nvim configur

if vim.loader and vim.loader.enable then
	vim.loader.enable()
end

-- LEADER KEY
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- OPTIONS
local o, wo, bo = vim.o, vim.wo, vim.bo
o.termguicolors = true
o.number = true
o.relativenumber = true
o.mouse = "a"
o.clipboard = "unnamedplus"
o.updatetime = 200
o.timeoutlen = 400
o.smartindent = true
o.splitbelow = true
o.splitright = true
o.ignorecase = true
o.smartcase = true
o.signcolumn = "yes"
o.cursorline = false

o.swapfile = false

local borderopt = "none"

vim.opt.autochdir = false

vim.o.background = "dark"

vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.wo.conceallevel = 2
	end,
})

-- LAZY
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local function lsp_on_attach(client, bufnr)
	local map = function(mode, lhs, rhs, desc)
		vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, noremap = true, desc = desc })
	end

	map("n", "K", vim.lsp.buf.hover, "LSP Hover")
	map("n", "gd", vim.lsp.buf.definition, "Goto Definition")
	map("n", "gr", vim.lsp.buf.references, "References")
	map("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")
	map("n", "gi", vim.lsp.buf.implementation, "Goto Implementation")
	map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
	map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")

	-- diagnostics (buffer-local)
	map("n", "gl", vim.diagnostic.open_float, "Line Diagnostics")
	map("n", "[d", vim.diagnostic.goto_prev, "Prev Diagnostic")
	map("n", "]d", vim.diagnostic.goto_next, "Next Diagnostic")

	-- DISABLE inlay hints by default (toggle with <leader>uh)
	if vim.lsp.inlay_hint and client.server_capabilities.inlayHintProvider then
		vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
	end
end

local cherry = "#ff5f87" -- vibrant rose red
local poppy = "#ff5f5f" -- warm scarlet
local coral = "#ff875f" -- soft orange-red
local amber = "#ffaf5f" -- golden amber
local orange = "#d28b44"
local marigold = "#ffd75f" -- bright sunflower yellow
local chartreuse = "#d7ff5f" -- lively yellow-green
local spring = "#afff87" -- fresh spring green
local jade = "#5fff87" -- saturated leafy green
local seafoam = "#5fffc7" -- aqua-tinted green
local turquoise = "#5fffd7" -- cool turquoise
local lagoon = "#5fd7ff" -- clear lagoon blue
local fartgreen = "#64af49"
local cerulean = "#5fafff" -- calm sky blue
local indigo = "#5f87ff" -- rich indigo
local violet = "#875fff" -- dusky violet
local orchid = "#af5fff" -- electric orchid
local magenta = "#d75fff" -- vivid magenta
local burple = "#b65493"

-- PLUGINS
require("lazy").setup({
	-- THEMES
	{
		dir = "/Users/jerrylu/Documents/Projects/agi-theme",
		name = "agi-theme",
		lazy = true,
		config = function()
			require("agi-theme").setup({ colors = { bg0 = "#181818", fg0 = "#dadada" } })
		end,
	},
	{
		dir = "/Users/jerrylu/Documents/Projects/mytheme",
		name = "mytheme",
		lazy = true,
		priority = 1000,

		opts = {
			variant = "dark",
			transparent = false,
			palette = {
				base00 = "#212121",
				-- primary background / editor surface
				base01 = "#212121",
				-- elevated panels, cursorline, popups
				base02 = "#6c6c6c",
				-- subtle separators, selection outlines
				base03 = "#6c6c6c",
				-- comments, noncritical accents
				base04 = "#9e9e9e",
				-- muted status text and secondary UI
				base05 = "#dadada",
				-- default foreground
				base06 = "#eeeeee",
				-- brighter foreground accents
				base07 = "#ffffff",
				-- highest-value highlights
				base08 = cherry,
				-- errors, deletions, critical warnings
				base09 = amber,
				-- warnings, numbers, attention markers
				base0A = orange,
				-- search matches, emphasized labels, types
				base0B = fartgreen,
				-- strings, successes, additions
				base0C = burple,
				-- hints, special text, builtins, namespaces, constants
				base0D = violet,
				-- functions, titles, active selection
				base0E = magenta,
				-- keywords, control flow, type hints,
				base0F = "#dadada",
				-- fields, attributes, miscellaneous accents
			},
			styles = {
				keywords = { bold = false },
				constants = { bold = true },
				comments = { italic = true },
			},
		},
		config = function(_, opts)
			vim.g.mytheme_options = opts
			require("mytheme").setup(opts)
		end,
	},
	-- other themes
	{
		"nickkadutskyi/jb.nvim",
		"xiantang/darcula-dark.nvim",
		"idr4n/github-monochrome.nvim",
		"felipeagc/fleet-theme-nvim",
		"flazz/vim-colorschemes",

		priority = 1000,
	},
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			bigfile = { enabled = true },
			dashboard = { enabled = true },
			explorer = { enabled = false },
			indent = { enabled = false },
			input = { enabled = false },
			picker = { enabled = true },
			notifier = { enabled = true },
			quickfile = { enabled = true },
			scope = { enabled = true },
			scroll = { enabled = false },
			statuscolumn = { enabled = false },
			words = { enabled = true },
			zen = {
				hide_line_numbers = false,
			},
			image = {},
		},
		keys = {

			-- EXPLORER
			{
				"<leader>e2",
				function()
					Snacks.explorer.reveal()
				end,
				desc = "snacks explorer",
			},

			-- NOTIFIER

			{
				"<leader>ns",
				function()
					---@param opts? snacks.notifier.history
					Snacks.notifier.show_history(opts)
				end,
				desc = "show history",
			},

			-- FIND
			{
				"<leader>fp",
				function()
					Snacks.picker.projects()
				end,
				desc = "find projects",
			},
			{
				"<leader>ff",
				function()
					Snacks.picker.files()
				end,
				desc = "Find Files",
			},
			{
				"<leader>fg",
				function()
					Snacks.picker.git_files()
				end,
				desc = "Find Git Files",
			},

			-- git
			{
				"<leader>gb",
				function()
					Snacks.picker.git_branches()
				end,
				desc = "Git Branches",
			},
			{
				"<leader>gl",
				function()
					Snacks.picker.git_log()
				end,
				desc = "Git Log",
			},
			{
				"<leader>gL",
				function()
					Snacks.picker.git_log_line()
				end,
				desc = "Git Log Line",
			},
			{
				"<leader>gs",
				function()
					Snacks.picker.git_status()
				end,
				desc = "Git Status",
			},
			{
				"<leader>gS",
				function()
					Snacks.picker.git_stash()
				end,
				desc = "Git Stash",
			},
			{
				"<leader>gd",
				function()
					Snacks.picker.git_diff()
				end,
				desc = "Git Diff (Hunks)",
			},
			{
				"<leader>gf",
				function()
					Snacks.picker.git_log_file()
				end,
				desc = "Git Log File",
			},

			{
				"<leader>fr",
				function()
					Snacks.picker.recent()
				end,
				desc = "recent",
			},
			{
				"<leader>uz",
				function()
					Snacks.zen()
				end,
				desc = "zen toggle",
			},

			--LSP
			{
				"gd",
				function()
					Snacks.picker.lsp_definitions()
				end,
				desc = "goto definition",
			},
			{
				"gD",
				function()
					Snacks.picker.lsp_declarations()
				end,
				desc = "goto declaration",
			},
			{
				"gr",
				function()
					Snacks.picker.lsp_references()
				end,
				nowait = true,
				desc = "References",
			},
			{
				"gI",
				function()
					Snacks.picker.lsp_implementations()
				end,
				desc = "Goto Implementation",
			},
			{
				"gy",
				function()
					Snacks.picker.lsp_type_definitions()
				end,
				desc = "Goto T[y]pe Definition",
			},
			{
				"<leader>ss",
				function()
					Snacks.picker.lsp_symbols()
				end,
				desc = "lsp symbols",
			},
			{
				"<leader>sS",
				function()
					Snacks.picker.lsp_workspace_symbols()
				end,
				desc = "lsp workspace symbols",
			},

			-- SEARCHING
			{
				"<leader>fc",
				function()
					Snacks.picker.colorschemes()
				end,
				desc = "find colorschemes",
			},
			-- Grep
			{
				"<leader>sb",
				function()
					Snacks.picker.lines()
				end,
				desc = "Buffer Lines",
			},
			{
				"<leader>sB",
				function()
					Snacks.picker.grep_buffers()
				end,
				desc = "Grep Open Buffers",
			},
			{
				"<leader>sg",
				function()
					Snacks.picker.grep()
				end,
				desc = "Grep",
			},
			{
				"<leader>sw",
				function()
					Snacks.picker.grep_word()
				end,
				desc = "Visual selection or word",
				mode = { "n", "x" },
			},

			--CODE

			{
				"<leader>cr",
				function()
					vim.lsp.buf.rename()
				end,
				desc = "Rename Symbol",
			},
		},

		init = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "VeryLazy",
				callback = function()
					-- Setup some globals for debugging (lazy-loaded)
					_G.dd = function(...)
						Snacks.debug.inspect(...)
					end
					_G.bt = function()
						Snacks.debug.backtrace()
					end
					vim.print = _G.dd -- Override print to use snacks for `:=` command

					-- Create some toggle mappings
					Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
					Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
					Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
					Snacks.toggle.diagnostics():map("<leader>ud")
					Snacks.toggle.line_number():map("<leader>ul")
					Snacks.toggle
						.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
						:map("<leader>uc")
					Snacks.toggle.treesitter():map("<leader>uT")
					Snacks.toggle
						.option("background", { off = "light", on = "dark", name = "Dark Background" })
						:map("<leader>ub")
					Snacks.toggle.inlay_hints():map("<leader>uh")
					Snacks.toggle.indent():map("<leader>ug")
					Snacks.toggle.dim():map("<leader>uD")
				end,
			})
		end,
	},
	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			pcall(require("nvim-treesitter.install").update({ with_sync = true }))
		end,
		opts = {
			ensure_installed = {
				"c",
				"cpp",
				"lua",
				"vim",
				"vimdoc",
				"markdown",
				"markdown_inline",
				"python",
				"json",
				"bash",
			},
			highlight = { enable = true },
			indent = { enable = true },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<CR>",
					node_incremental = "<CR>",
					node_decremental = "<BS>",
					scope_incremental = "<TAB>",
				},
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},

	-- LSP Core + Installer
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		opts = {},
		config = function(_, opts)
			require("mason").setup(opts)
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
		},
		opts = function()
			local lspconfig = require("lspconfig")
			local util = require("lspconfig.util")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			capabilities.textDocument.completion.completionItem.snippetSupport = false

			local base_opts = {
				on_attach = lsp_on_attach,
				capabilities = capabilities,
			}

			local servers = {
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
					flags = {
						debounce_text_changes = 150,
					},
					root_dir = util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
				},
				lua_ls = {
					settings = {
						Lua = {
							workspace = { checkThirdParty = false },
							diagnostics = { globals = { "vim" } },
						},
					},
				},
				cmake = {},
				ts_ls = {
					settings = {
						typescript = {
							preferences = {
								includeCompletionsForModuleExports = true,
								includeCompletionsForImportStatements = true,
							},
						},
					},
				},
				rust_analyzer = {},
			}

			local skip_servers = {
				rust_analyzer = true, -- rustaceanvim manages this server
			}

			return {
				ensure_installed = { "clangd", "lua_ls", "cmake", "ts_ls", "eslint", "biome", "rust_analyzer" },
				automatic_installation = false,
				handlers = {
					function(server_name)
						if skip_servers[server_name] then
							return
						end
						if not lspconfig[server_name] then
							return
						end
						local server_opts = vim.tbl_deep_extend("force", {}, base_opts, servers[server_name] or {})
						lspconfig[server_name].setup(server_opts)
					end,
				},
			}
		end,
		config = function(_, opts)
			require("mason-lspconfig").setup(opts)
		end,
	},
	{
		"neovim/nvim-lspconfig",
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^5",
		lazy = false,
		ft = { "rust" },
		opts = {
			server = {
				on_attach = lsp_on_attach, -- Uses your existing function
				default_settings = {
					["rust-analyzer"] = {
						checkOnSave = true,
						cargo = {
							allFeatures = true,
							loadOutDirsFromCheck = true,
							buildScripts = { enable = true },
						},
						procMacro = {
							enable = true,
							ignored = {
								["async-trait"] = { "async_trait" },
								["napi-derive"] = { "napi" },
							},
						},
						inlayHints = {
							typeHints = { enable = true },
							parameterHints = { enable = true },
							chainingHints = { enable = true },
						},
					},
				},
			},
		},
		config = function(_, opts)
			vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
		end,
	},
	{
		"saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			completion = {
				cmp = { enabled = true },
			},
			lsp = {
				enabled = true,
				actions = true,
				completion = true,
				hover = true,
			},
		},
		config = function(_, opts)
			require("crates").setup(opts)

			-- Add to nvim-cmp sources
			local cmp_ok, cmp = pcall(require, "cmp")
			if cmp_ok then
				local config = cmp.get_config()
				table.insert(config.sources, { name = "crates" })
				cmp.setup(config)
			end
		end,
	},

	-- Autocomplete
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			-- "hrsh7th/cmp-buffer",
			-- "rafamadriz/friendly-snippets",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			require("luasnip.loaders.from_vscode").lazy_load()

			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
					-- { name = "buffer" },
				},
			})
		end,
	},

	-- Formatting (sync or async on save)
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				c = { "clang_format" },
				cpp = { "clang_format" },
				lua = { "stylua" },
				python = { "isort", "black" },
				rust = { "rustfmt" },
				javascript = { "biome", "prettierd", "prettier" },
				typescript = { "biome", "prettierd", "prettier" },
				javascriptreact = { "biome", "prettierd", "prettier" },
				typescriptreact = { "biome", "prettierd", "prettier" },
			},
			formatters = {
				clang_format = {
					args = { "--style={BasedOnStyle: llvm, IndentWidth: 4}" }, -- Set IndentWidth to 4
				},
			},
			-- Run async to keep UI responsive
			format_on_save = function(buf)
				local ignore_large = vim.api.nvim_buf_line_count(buf) > 5000
				return ignore_large and nil or { lsp_fallback = true, timeout_ms = 2000 }
			end,
		},
	},

	-- Telescope fuzzy finder
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {}, -- no overlapping mappings
		config = true,
	},

	{
		"stevearc/oil.nvim",
		dependencies = { { "echasnovski/mini.icons", opts = {} } },
		keys = {
			{
				"<leader>o",
				"<cmd>Oil<CR>",
				desc = "open parent dir with oil",
			},
		},
		lazy = false,
		opts = {
			default_file_explorer = true,
			columns = { "icon", "permissions", "size", "mtime" },
			view_options = {
				show_hidden = true,
				natural_order = true,
				case_insensitive = false,
				sort = { { "type", "asc" }, { "name", "asc" } },
			},
			float = {
				padding = 2,
				max_width = 0.95,
				max_height = 0.90,
				border = borderopt,
				win_options = { winblend = 0 },
			},
			delete_to_trash = true,
			skip_confirm_for_simple_edits = true,
			use_default_keymaps = true,
		},
	},

	-- UI niceties
	{
		"nvim-lualine/lualine.nvim",
		opts = { options = { theme = "auto", section_separators = "", component_separators = "" } },
	},
	{ "lewis6991/gitsigns.nvim", event = { "BufReadPre", "BufNewFile" }, opts = {} },
	{ "numToStr/Comment.nvim", opts = {} },
	{
		"folke/which-key.nvim",
	},
	{
		"nssteinbrenner/dart",
		branch = "master",
		tag = "v1.0.0",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
		},
	},
	{
		"cbochs/grapple.nvim",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons", lazy = true },
		},
		opts = {
			scope = "git_branch", -- also try out "git"
		},
		event = { "BufReadPost", "BufNewFile" },
		cmd = "Grapple",
		keys = {
			{ "<leader>rm", "<cmd>Grapple toggle<cr>", desc = "Grapple toggle tag" },
			{ "<leader>rM", "<cmd>Grapple toggle_tags<cr>", desc = "Grapple open tags window" },
			{ "<leader>rn", "<cmd>Grapple cycle_tags next<cr>", desc = "Grapple cycle next tag" },
			{ "<leader>rp", "<cmd>Grapple cycle_tags prev<cr>", desc = "Grapple cycle previous tag" },
		},
	},

	-- Debugging (C/C++ with codelldb)
	{
		"mfussenegger/nvim-dap",
		enabled = true,
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"jay-babu/mason-nvim-dap.nvim",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			require("mason-nvim-dap").setup({
				ensure_installed = { "codelldb" }, -- installs the adapter
				handlers = {},
			})
			dapui.setup()
			-- Auto-open UI
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			-- Keymaps
			local map = vim.keymap.set
			map("n", "<F5>", dap.continue, { desc = "DAP Continue" })
			map("n", "<F10>", dap.step_over, { desc = "DAP Step Over" })
			map("n", "<F11>", dap.step_into, { desc = "DAP Step Into" })
			map("n", "<F12>", dap.step_out, { desc = "DAP Step Out" })
			map("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP Breakpoint" })
			map("n", "<leader>dB", function()
				dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end, { desc = "DAP Conditional BP" })
			map("n", "<leader>dr", dap.repl.open, { desc = "DAP REPL" })

			-- Basic C/C++ template config (codelldb path resolved by Mason)
			local mason_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/"
			local codelldb = mason_path .. "adapter/codelldb"
			local liblldb = mason_path .. "lldb/lib/liblldb.dylib" -- Linux: liblldb.so; Windows: .dll
			pcall(function()
				dap.adapters.codelldb = {
					type = "server",
					port = "${port}",
					executable = { command = codelldb, args = { "--port", "${port}" }, detached = false },
				}
			end)
			dap.configurations.cpp = {
				{
					name = "Launch (build and run)",
					type = "codelldb",
					request = "launch",
					program = function()
						-- Simple build example; adapt to your project
						vim.fn.jobstart(
							{ "bash", "-lc", "make -j || cmake -S . -B build && cmake --build build -j" },
							{ stdout_buffered = true }
						)
						local exe = vim.fn.input("Path to executable: ", "./build/main", "file")
						return exe
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					args = {},
				},
			}
			dap.configurations.c = dap.configurations.cpp
		end,
	},

	{
		"mxsdev/nvim-dap-vscode-js",
		"microsoft/vscode-js-debug",
		build = "npm i --prefix=vscode-js-debug --legacy-peer-deps && npm run compile --prefix=vscode-js-debug",
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			local dap = require("dap")
			require("dap-vscode-js").setup({
				debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
				adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
			})

			-- Node.js/TypeScript debugging configurations
			dap.configurations.javascript = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					cwd = "${workspaceFolder}",
				},
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch npm script",
					runtimeExecutable = "npm",
					runtimeArgs = { "run", "debug" },
					cwd = "${workspaceFolder}",
				},
			}

			dap.configurations.typescript = dap.configurations.javascript
			dap.configurations.javascriptreact = dap.configurations.javascript
			dap.configurations.typescriptreact = dap.configurations.javascript
		end,
	},

	{
		"folke/neodev.nvim",
		opts = {},
	},

	{
		"altermo/ultimate-autopair.nvim",
		event = { "InsertEnter", "CmdlineEnter" },
		branch = "v0.6", --recommended as each new version will have breaking changes
		opts = {
			--Config goes here
		},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},

	{
		"epwalsh/obsidian.nvim",
		version = "*", -- recommended, use latest release instead of latest commit
		lazy = true,
		ft = "markdown",
		-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
		-- event = {
		--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
		--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
		--   -- refer to `:h file-pattern` for more examples
		--   "BufReadPre path/to/my-vault/*.md",
		--   "BufNewFile path/to/my-vault/*.md",
		-- },
		dependencies = {
			-- Required.
			"nvim-lua/plenary.nvim",

			-- see below for full list of optional dependencies ðŸ‘‡
		},
		opts = {
			workspaces = {
				{
					name = "personal",
					path = "/Users/jerrylu/Library/Mobile Documents/iCloud~md~obsidian/Documents/myvault",
				},
			},

			ui = {
				enable = false,
			},
			-- see below for full list of options ðŸ‘‡
		},
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" }, -- if you use the mini.nvim suite
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' }, -- if you use standalone mini plugins
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {
			render_modes = true,
			anti_conceal = {
				enabled = true,
			},
			heading = {
				border = true,
				border_virtual = true,
			},
		},
		ft = { "markdown" },
	},
	-- {
	-- 	"bullets-vim/bullets.vim",
	-- 	ft = "markdown",
	-- 	event = "LspAttach",
	-- },

	-- {
	-- 	"folke/noice.nvim",
	-- 	event = "VeryLazy",
	-- 	opts = {
	-- 		-- add any options here
	-- 		lsp = {
	-- 			-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
	-- 			override = {
	-- 				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
	-- 				["vim.lsp.util.stylize_markdown"] = true,
	-- 				["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
	-- 			},
	-- 		},
	-- 		-- you can enable a preset for easier configuration
	-- 		presets = {
	-- 			bottom_search = true, -- use a classic bottom cmdline for search
	-- 			command_palette = true, -- position the cmdline and popupmenu together
	-- 			long_message_to_split = true, -- long messages will be sent to a split
	-- 			inc_rename = false, -- enables an input dialog for inc-rename.nvim
	-- 			lsp_doc_border = false, -- add a border to hover docs and signature help
	-- 		},
	--
	-- 		cmdline = {
	-- 			enabled = true,
	-- 			view = "cmdline",
	-- 		},
	-- 	},
	-- 	dependencies = {
	-- 		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
	-- 		"MunifTanjim/nui.nvim",
	-- 		-- OPTIONAL:
	-- 		--   `nvim-notify` is only needed, if you want to use the notification view.
	-- 		--   If not available, we use `mini` as the fallback
	-- 		"rcarriga/nvim-notify",
	-- 	},
	-- },
	{
		"Civitasv/cmake-tools.nvim",
		dependencies = { "stevearc/overseer.nvim" },
		event = "LspAttach",
		opts = {
			cmake_regenerate_on_save = true,
			cmake_build_directory = "build",
			cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON", "-DCMAKE_BUILD_TYPE=Debug" },
		},
	},

	{
		"numToStr/Comment.nvim",
		event = "LspAttach",
		opts = {
			-- add any options here
		},
	},

	{
		"ray-x/lsp_signature.nvim",
		event = "InsertEnter",
		opts = {
			bind = true,
			handler_opts = {
				border = borderopt,
				-- Only show signature, not parameter hints
				hint_enable = false,
				-- Make it less intrusive
				floating_window = true,
				toggle_key = "<leader>uls", -- Add toggle key
				floating_window_above_cur_line = true,
			},
		},
		-- or use config
		-- config = function(_, opts) require'lsp_signature'.setup({you options}) end
	},

	--[[ 	{
		"ahmedkhalf/project.nvim",
		event = "VeryLazy",
		config = function()
			require("project_nvim").setup({
				detection_methods = { "lsp", "pattern" },
				patterns = { ".git", "compile_commands.json", "Makefile", "CMakeLists.txt" },
			})
			require("telescope").load_extension("projects")
		end,
	}, ]]

	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {

			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>xs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>xl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},
	{
		"rmagatti/auto-session",
		lazy = false,

		---enables autocomplete for opts
		---@module "auto-session"
		---@type AutoSession.Config
		opts = {
			suppressed_dirs = { "~/Downloads" },
			-- log_level = 'debug',
			cwd_change_handling = { restore_upcoming_session = true },
		},
	},
}, {
	ui = { border = borderopt },
})

-- THEMES

-- Save colorscheme on exit
vim.api.nvim_create_autocmd("VimLeavePre", {
	callback = function()
		local colorscheme = vim.g.colors_name or "default"
		local config_dir = vim.fn.stdpath("config")
		local theme_file = config_dir .. "/last_theme.txt"

		local file = io.open(theme_file, "w")
		if file then
			file:write(colorscheme)
			file:close()
		end
	end,
})

-- Load saved colorscheme on startup
-- Use VimEnter to ensure plugins are loaded but before UI is fully rendered
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		local config_dir = vim.fn.stdpath("config")
		local theme_file = config_dir .. "/last_theme.txt"

		local file = io.open(theme_file, "r")
		if file then
			local saved_theme = file:read("*line")
			file:close()

			if saved_theme and saved_theme ~= "" then
				-- Ensure the theme plugin is loaded before applying
				vim.schedule(function()
					pcall(vim.cmd.colorscheme, saved_theme)
				end)
			end
		end
	end,
})

-- INLINE DIAGNOSTICS

local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
	vim.notify("LSP config failed to load", vim.log.levels.ERROR)
	return
end

vim.diagnostic.config({
	virtual_text = false,
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = { border = borderopt, source = "if_many", focusable = false },
})

local function close_diag_float()
	local win = vim.b._diag_float
	if win and vim.api.nvim_win_is_valid(win) then
		pcall(vim.api.nvim_win_close, win, true)
	end
	vim.b._diag_float = nil
end

vim.api.nvim_create_autocmd({ "CursorHold" }, {
	callback = function()
		local win = vim.b._diag_float
		if win and vim.api.nvim_win_is_valid(win) then
			return
		end
		local _, float_win = vim.diagnostic.open_float(nil, { border = borderopt, focusable = false })
		if float_win and vim.api.nvim_win_is_valid(float_win) then
			vim.b._diag_float = float_win
		end
	end,
})

vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "InsertEnter", "BufHidden" }, {
	callback = close_diag_float,
})

-- KEYMAPS

vim.api.nvim_create_user_command("Config", function()
	vim.cmd("cd ~/.config/nvim")
	vim.cmd("e init.lua")
	print("Changed directory to ~/.config/nvim")
end, {})

local map = vim.keymap.set
local opts = { noremap = true, silent = true, desc = "" }

require("which-key").add({
	{ "<leader>u", group = "ui / toggles" },
	{ "<leader>w", group = "window" },
	{ "<leader>t", group = "tab" },
	{ "<leader>r", group = "grapple" },
	{ "<leader>d", group = "dart" },
	{ "<leader>f", group = "find (Snacks)" },
	{ "<leader>g", group = "git (Snacks)" },
	{ "<leader>s", group = "lsp symbols" },
	{ "<leader>x", group = "trouble" },
})

-- ===============================
-- CWD helpers
-- ===============================

-- Preferred project root markers if no LSP root is available
local ROOT_MARKERS = { ".git", "compile_commands.json", "CMakeLists.txt", "Makefile", "pyproject.toml", "package.json" }

-- Small helpers
local function notify(msg, level)
	vim.notify(msg, level or vim.log.levels.INFO, { title = "CWD" })
end

local function buf_dir()
	if vim.bo.filetype == "oil" then
		local ok, oil = pcall(require, "oil")
		if ok then
			local dir = oil.get_current_dir()
			if dir then
				return dir
			end
		end
	end
	-- Try the file's folder; fall back to current cwd if the buffer isn't a real file
	local p = vim.api.nvim_buf_get_name(0)
	if p == "" then
		return vim.loop.cwd()
	end
	return vim.fn.fnamemodify(p, ":p:h")
end

-- Walk up from a path until a marker is found
local function find_marker_root(start_dir)
	local dir = start_dir
	while dir and dir ~= "" and dir ~= "/" do
		for _, m in ipairs(ROOT_MARKERS) do
			if vim.fn.isdirectory(dir .. "/" .. m) == 1 or vim.fn.filereadable(dir .. "/" .. m) == 1 then
				return dir
			end
		end
		dir = vim.fn.fnamemodify(dir, ":h")
	end
	return nil
end

-- Prefer LSP root if available; otherwise use markers
local function find_project_root()
	-- LSP roots (take the first with a root_dir)
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	for _, c in ipairs(clients) do
		if c.config and c.config.root_dir and c.config.root_dir ~= "" then
			return c.config.root_dir
		end
	end
	-- Fallback by markers from the buffer's dir
	return find_marker_root(buf_dir())
end

-- Change CWD to a target directory (if it exists)
local function set_cwd(dir)
	if not dir or dir == "" then
		notify("No directory given", vim.log.levels.WARN)
		return
	end
	local stat = vim.loop.fs_stat(dir)
	if not stat or stat.type ~= "directory" then
		notify("Not a directory: " .. dir, vim.log.levels.ERROR)
		return
	end
	local ok, err = pcall(vim.cmd, "noautocmd cd " .. vim.fn.fnameescape(dir))
	if not ok then
		notify("Failed to change CWD: " .. err, vim.log.levels.ERROR)
		return
	end
	notify("CWD >> " .. vim.loop.cwd())
end

-- Public actions / keymaps
vim.keymap.set("n", "<leader>ed", function()
	set_cwd(buf_dir())
end, { desc = "CWD: parent of current file" })

vim.keymap.set("n", "<leader>er", function()
	local root = find_project_root()
	if root then
		set_cwd(root)
	else
		notify("No project root found (checked LSP & markers)", vim.log.levels.WARN)
	end
end, { desc = "CWD: project root" })

vim.keymap.set("n", "<leader>es", function()
	notify("Current CWD: " .. vim.loop.cwd())
end, { desc = "print cwd" })

vim.keymap.set("n", "<leader>or", "<cmd>Oil --float .<CR>", { desc = "open project root in oil" })

-- WINDOW KEYMAPS
map("n", "<leader>wv", "<cmd>vsplit<CR>", { desc = "Vsplit" })
map("n", "<leader>wh", "<cmd>split<CR>", { desc = "Hsplit" })

-- TABS
map("n", "<leader>tt", "<cmd>tabnew<CR>", { desc = "New tab" })
map("n", "<leader>tc", "<cmd>tabclose<CR>", { desc = "Close tab" })
map("n", "<leader>to", "<cmd>tabonly<CR>", { desc = "Close other tabs" })
map("n", "<leader>tp", "<cmd>tabprevious<CR>", { desc = "Previous tab" })
map("n", "<leader>tn", "<cmd>tabnext<CR>", { desc = "Next tab" })
map("n", "<leader>tl", "<cmd>tablast<CR>", { desc = "Last tab" })

for i = 1, 9 do
	map("n", "<leader>t" .. i, i .. "gt", { desc = "Go tab " .. i })
end

-- DART
local dart = require("dart").setup()
map("n", "<leader>da", function()
	dart:list():add()
end, { desc = "dart add" })
map("n", "<leader>dm", function()
	dart.ui:toggle_quick_menu(dart:list())
end, { desc = "dart toggle quick menu" })
map("n", "<leader>d1", function()
	dart:list():select(1)
end, { desc = "sel 1" })
map("n", "<leader>d2", function()
	dart:list():select(2)
end, { desc = "sel 2" })
map("n", "<leader>d3", function()
	dart:list():select(3)
end, { desc = "sel 3" })
map("n", "<leader>d4", function()
	dart:list():select(4)
end, { desc = "sel 4" })
map("n", "<leader>dp", function()
	dart:list():prev()
end, { desc = "dart prev" })
map("n", "<leader>dn", function()
	dart:list():next()
end, { desc = "dart next" })

--
-- rust
--

vim.api.nvim_create_autocmd("FileType", {
	pattern = "rust",
	callback = function()
		-- Rust-specific settings
		vim.opt_local.colorcolumn = "100"
		vim.opt_local.textwidth = 99

		-- Cargo command keymaps
		local map = vim.keymap.set
		local opts = { buffer = true, silent = true, noremap = true }

		-- Basic Cargo commands
		map("n", "<leader>rb", ":!cargo build<CR>", vim.tbl_extend("force", opts, { desc = "Cargo Build" }))
		map("n", "<leader>rt", ":!cargo test<CR>", vim.tbl_extend("force", opts, { desc = "Cargo Test" }))
		map("n", "<leader>rr", ":!cargo run<CR>", vim.tbl_extend("force", opts, { desc = "Cargo Run" }))
		map("n", "<leader>rc", ":!cargo check<CR>", vim.tbl_extend("force", opts, { desc = "Cargo Check" }))
		map("n", "<leader>rf", ":!cargo fmt<CR>", vim.tbl_extend("force", opts, { desc = "Cargo Format" }))
		map("n", "<leader>rl", ":!cargo clippy<CR>", vim.tbl_extend("force", opts, { desc = "Cargo Clippy" }))

		-- Rustaceanvim commands (if you added the plugin)
		local rustaceanvim_ok = pcall(require, "rustaceanvim")
		if rustaceanvim_ok then
			map("n", "<leader>rR", ":RustLsp runnables<CR>", vim.tbl_extend("force", opts, { desc = "Rust Runnables" }))
			map("n", "<leader>rd", ":RustLsp debuggables<CR>", vim.tbl_extend("force", opts, { desc = "Rust Debug" }))
			map("n", "<leader>re", ":RustLsp expandMacro<CR>", vim.tbl_extend("force", opts, { desc = "Expand Macro" }))
			map(
				"n",
				"<leader>rC",
				":RustLsp openCargo<CR>",
				vim.tbl_extend("force", opts, { desc = "Open Cargo.toml" })
			)
			map(
				"n",
				"<leader>rp",
				":RustLsp parentModule<CR>",
				vim.tbl_extend("force", opts, { desc = "Parent Module" })
			)
			map(
				"n",
				"<leader>rh",
				":RustLsp hover actions<CR>",
				vim.tbl_extend("force", opts, { desc = "Hover Actions" })
			)
		end

		-- Toggle inlay hints
		map("n", "<leader>ri", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })
		end, vim.tbl_extend("force", opts, { desc = "Toggle Inlay Hints" }))
	end,
})

-- Cargo.toml specific keymaps (for crates.nvim)
vim.api.nvim_create_autocmd("BufRead", {
	pattern = "Cargo.toml",
	callback = function()
		local crates_ok = pcall(require, "crates")
		if not crates_ok then
			return
		end

		local map = vim.keymap.set
		local opts = { buffer = true, silent = true, noremap = true }

		map(
			"n",
			"<leader>ct",
			":lua require('crates').toggle()<CR>",
			vim.tbl_extend("force", opts, { desc = "Crates Toggle" })
		)
		map(
			"n",
			"<leader>cu",
			":lua require('crates').update_crate()<CR>",
			vim.tbl_extend("force", opts, { desc = "Update Crate" })
		)
		map(
			"n",
			"<leader>cU",
			":lua require('crates').upgrade_crate()<CR>",
			vim.tbl_extend("force", opts, { desc = "Upgrade Crate" })
		)
		map(
			"n",
			"<leader>ca",
			":lua require('crates').update_all_crates()<CR>",
			vim.tbl_extend("force", opts, { desc = "Update All" })
		)
		map(
			"n",
			"<leader>cA",
			":lua require('crates').upgrade_all_crates()<CR>",
			vim.tbl_extend("force", opts, { desc = "Upgrade All" })
		)
		map(
			"n",
			"<leader>cH",
			":lua require('crates').open_homepage()<CR>",
			vim.tbl_extend("force", opts, { desc = "Homepage" })
		)
		map(
			"n",
			"<leader>cD",
			":lua require('crates').open_documentation()<CR>",
			vim.tbl_extend("force", opts, { desc = "Documentation" })
		)

		vim.notify("Cargo.toml: <leader>c for crate commands", vim.log.levels.INFO)
	end,
})

-- CODE
--map("n", "<leader>cr", vim.lsp.buf.rename, "LSP Rename Symbol")

vim.opt.wrap = true
vim.opt.linebreak = true -- Break lines at word boundaries
vim.opt.breakindent = true -- Indent wrapped lines
vim.opt.breakindentopt = "shift:2" -- Indent by 2 spaces

vim.opt.tabstop = 4 -- Number of spaces that a <Tab> in the file counts for
vim.opt.shiftwidth = 4 -- Number of spaces used for autoindent (<< and >>, etc.)
vim.opt.softtabstop = 4 -- Number of spaces inserted when pressing <Tab>
vim.opt.expandtab = true -- Convert tabs to spaces
