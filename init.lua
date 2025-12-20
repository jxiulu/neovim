-- Neovim Configuration - Streamlined for C++ and C# Development

-- =============================================================================
-- PERFORMANCE & BASIC OPTIONS
-- =============================================================================

-- Enable loader optimization
if vim.loader then
	vim.loader.enable()
end

-- Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Basic options
local opt = vim.opt
opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.updatetime = 1000 -- 1 second for CursorHold events (diagnostics/inlay hints)
opt.timeoutlen = 400
opt.smartindent = true
opt.splitbelow = true
opt.splitright = true
opt.ignorecase = true
opt.smartcase = true
opt.signcolumn = "yes"
opt.cursorline = false
opt.swapfile = false
opt.autochdir = false
opt.background = "dark"

-- Indentation & wrapping
opt.wrap = true
opt.linebreak = true
opt.breakindent = true
opt.breakindentopt = "shift:2"
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.colorcolumn = "81"
opt.textwidth = 80

--
-- Fill entire window
--
vim.api.nvim_create_autocmd({ "UIEnter", "ColorScheme" }, {
	callback = function()
		local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
		if not normal.bg then
			return
		end
		io.write(string.format("\027]11;#%06x\027\\", normal.bg))
	end,
})

vim.api.nvim_create_autocmd("UILeave", {
	callback = function()
		io.write("\027]111\027\\")
	end,
})

-- =============================================================================
-- LAZY.NVIM BOOTSTRAP
-- =============================================================================

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

-- Border style for floating windows
local border = "rounded"

-- =============================================================================
-- LSP ON_ATTACH HANDLER
-- =============================================================================

local function lsp_on_attach(client, bufnr)
	local function map(mode, lhs, rhs, desc)
		vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, noremap = true, desc = desc })
	end

	-- LSP navigation (using Snacks pickers)
	map("n", "K", vim.lsp.buf.hover, "LSP Hover")
	map("n", "<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
	map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")

	-- Diagnostics
	map("n", "[d", vim.diagnostic.goto_prev, "Prev Diagnostic")
	map("n", "]d", vim.diagnostic.goto_next, "Next Diagnostic")

	-- Disable inlay hints by default
	if vim.lsp.inlay_hint and client.server_capabilities.inlayHintProvider then
		vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
	end
end

-- =============================================================================
-- PLUGINS
-- =============================================================================

require("lazy").setup({
	-- =========================================================================
	-- THEMES
	-- =========================================================================

	-- Custom local themes
	{
		"nickkadutskyi/jb.nvim",
		"karoliskoncevicius/distilled-vim",
		"kvrohit/rasmus.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
	{
		dir = "/Users/jerrylu/Documents/Projects/BetterTheme",
		lazy = false,
		priority = 1000,
		config = function()
			require("bettertheme").setup({
				background = "#303030",
				lighter_background = "#3f3f3f",
				standard_text = "#dbdbdb",
				keywords = "#8fbf7a",
				type_names = "#ebebeb",
				syntax = "#c9c9c9",
				comments = "#AAAAAA",
				variables = "#b8b8b8",
			})
		end,
	},
	{
		"alligator/accent.vim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.accent_colour = "green"
		end,
	},

	-- =========================================================================
	-- CORE UTILITIES
	-- =========================================================================

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
			{
				"<leader>fr",
				function()
					Snacks.picker.recent()
				end,
				desc = "Recent Files",
			},
			{
				"<leader>fc",
				function()
					Snacks.picker.colorschemes()
				end,
				desc = "Colorschemes",
			},

			-- Search
			{
				"<leader>sb",
				function()
					Snacks.picker.lines()
				end,
				desc = "Search Buffer Lines",
			},
			{
				"<leader>sg",
				function()
					Snacks.picker.grep()
				end,
				desc = "Live Grep",
			},
			{
				"<leader>sw",
				function()
					Snacks.picker.grep_word()
				end,
				desc = "Grep Word",
				mode = { "n", "x" },
			},

			-- LSP pickers
			{
				"gd",
				function()
					Snacks.picker.lsp_definitions()
				end,
				desc = "Goto Definition",
			},
			{
				"gD",
				function()
					Snacks.picker.lsp_declarations()
				end,
				desc = "Goto Declaration",
			},
			{
				"gr",
				function()
					Snacks.picker.lsp_references()
				end,
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
				desc = "Goto Type Definition",
			},
			{
				"<leader>ss",
				function()
					Snacks.picker.lsp_symbols()
				end,
				desc = "LSP Symbols",
			},

			-- Git
			{
				"<leader>gs",
				function()
					Snacks.picker.git_status()
				end,
				desc = "Git Status",
			},
			{
				"<leader>gl",
				function()
					Snacks.picker.git_log()
				end,
				desc = "Git Log",
			},
			{
				"<leader>gb",
				function()
					Snacks.picker.git_branches()
				end,
				desc = "Git Branches",
			},

			-- UI toggles
			{
				"<leader>uz",
				function()
					Snacks.zen()
				end,
				desc = "Zen Mode",
			},
			{
				"<leader>ns",
				function()
					Snacks.notifier.show_history()
				end,
				desc = "Notification History",
			},
		},
		init = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "VeryLazy",
				callback = function()
					-- Debug helpers
					_G.dd = function(...)
						Snacks.debug.inspect(...)
					end
					_G.bt = function()
						Snacks.debug.backtrace()
					end
					vim.print = _G.dd

					-- Toggle mappings
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

	-- =========================================================================
	-- TREESITTER
	-- =========================================================================

	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			pcall(require("nvim-treesitter.install").update({ with_sync = true }))
		end,
		opts = {
			ensure_installed = {
				"c",
				"cpp",
				"c_sharp",
				"lua",
				"vim",
				"vimdoc",
				"markdown",
				"markdown_inline",
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

	-- =========================================================================
	-- LSP & COMPLETION
	-- =========================================================================

	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		opts = {},
	},

	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig", "hrsh7th/cmp-nvim-lsp" },
		opts = function()
			local lspconfig = require("lspconfig")
			local util = require("lspconfig.util")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local base_opts = { on_attach = lsp_on_attach, capabilities = capabilities }

			local servers = {
				-- C++ Configuration
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

				-- C# Configuration
				omnisharp = {
					cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
					enable_roslyn_analyzers = true,
					organize_imports_on_format = true,
					enable_import_completion = true,
					settings = {
						FormattingOptions = {
							EnableEditorConfigSupport = true,
							OrganizeImports = true,
						},
						RoslynExtensionsOptions = {
							EnableAnalyzersSupport = true,
							EnableImportCompletion = true,
						},
					},
					handlers = {
						["textDocument/definition"] = function(...)
							return require("omnisharp_extended").definition_handler(...)
						end,
						["textDocument/typeDefinition"] = function(...)
							return require("omnisharp_extended").type_definition_handler(...)
						end,
						["textDocument/references"] = function(...)
							return require("omnisharp_extended").references_handler(...)
						end,
						["textDocument/implementation"] = function(...)
							return require("omnisharp_extended").implementation_handler(...)
						end,
					},
				},

				-- Lua for config editing
				lua_ls = {
					settings = {
						Lua = {
							workspace = { checkThirdParty = false },
							diagnostics = { globals = { "vim" } },
						},
					},
				},
			}

			return {
				ensure_installed = { "clangd", "omnisharp", "lua_ls" },
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
	{ "Hoffs/omnisharp-extended-lsp.nvim", lazy = true },

	-- Completion
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

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
				},
			})
		end,
	},

	-- =========================================================================
	-- FORMATTING
	-- =========================================================================

	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				cpp = { "clang_format" },
				c = { "clang_format" },
				cs = { "csharpier" },
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

	-- =========================================================================
	-- DEBUGGING
	-- =========================================================================

	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"jay-babu/mason-nvim-dap.nvim",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			require("mason-nvim-dap").setup({ ensure_installed = { "codelldb", "netcoredbg" } })
			dapui.setup()

			-- Auto-open/close DAP UI
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
			vim.keymap.set("n", "<F5>", dap.continue, { desc = "DAP Continue" })
			vim.keymap.set("n", "<F10>", dap.step_over, { desc = "DAP Step Over" })
			vim.keymap.set("n", "<F11>", dap.step_into, { desc = "DAP Step Into" })
			vim.keymap.set("n", "<F12>", dap.step_out, { desc = "DAP Step Out" })
			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
			vim.keymap.set("n", "<leader>dB", function()
				dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end, { desc = "Conditional Breakpoint" })

			-- C/C++ Adapter (codelldb)
			local mason_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/"
			local codelldb = mason_path .. "adapter/codelldb"
			dap.adapters.codelldb = {
				type = "server",
				port = "${port}",
				executable = { command = codelldb, args = { "--port", "${port}" } },
			}

			-- C/C++ Configuration
			dap.configurations.cpp = {
				{
					name = "Launch (build & run)",
					type = "codelldb",
					request = "launch",
					program = function()
						-- Auto-build with make or cmake
						vim.fn.jobstart({ "bash", "-c", "make -j || cmake -S . -B build && cmake --build build -j" })
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/build/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
				},
			}
			dap.configurations.c = dap.configurations.cpp

			-- C# / .NET Adapter
			dap.adapters.coreclr = {
				type = "executable",
				command = "netcoredbg",
				args = { "--interpreter=vscode" },
			}

			-- C# Configuration
			dap.configurations.cs = {
				{
					type = "coreclr",
					name = "Launch .NET",
					request = "launch",
					program = function()
						return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
					end,
				},
			}
		end,
	},

	-- =========================================================================
	-- UI & NAVIGATION
	-- =========================================================================

	{
		"stevearc/oil.nvim",
		dependencies = { "echasnovski/mini.icons" },
		lazy = false,
		opts = {
			default_file_explorer = true,
			columns = { "icon", "permissions", "size", "mtime" },
			view_options = {
				show_hidden = true,
				natural_order = true,
				sort = { { "type", "asc" }, { "name", "asc" } },
			},
			float = {
				padding = 2,
				max_width = 0.95,
				max_height = 0.90,
				border = border,
			},
			delete_to_trash = true,
			skip_confirm_for_simple_edits = true,
		},
		keys = {
			{ "<leader>o", "<cmd>Oil<CR>", desc = "Open Oil" },
			{ "<leader>of", "<cmd>Oil --float<CR>", desc = "Open Oil (float)" },
		},
	},

	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				theme = "auto",
				section_separators = "",
				component_separators = "",
			},
		},
	},

	{
		"cbochs/grapple.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = { scope = "git_branch" },
		keys = {
			{ "<leader>m", "<cmd>Grapple toggle<cr>", desc = "Grapple Toggle" },
			{ "<leader>M", "<cmd>Grapple toggle_tags<cr>", desc = "Grapple Menu" },
			{ "<leader>n", "<cmd>Grapple cycle_tags next<cr>", desc = "Grapple Next" },
			{ "<leader>p", "<cmd>Grapple cycle_tags prev<cr>", desc = "Grapple Prev" },
		},
	},

	{
		"folke/trouble.nvim",
		opts = {},
		cmd = "Trouble",
		keys = {
			{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{ "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
		},
	},

	-- =========================================================================
	-- MISC ESSENTIALS
	-- =========================================================================

	{ "lewis6991/gitsigns.nvim", event = { "BufReadPre", "BufNewFile" }, opts = {} },
	{ "numToStr/Comment.nvim", opts = {} },
	{ "folke/which-key.nvim", opts = {} },
	{ "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
	{ "rmagatti/auto-session", lazy = false, opts = { suppressed_dirs = { "~/Downloads" } } },
}, { ui = { border = border } })

-- =============================================================================
-- DIAGNOSTICS & INLAY HINTS (HOVER-BASED)
-- =============================================================================

-- Configure diagnostics: no virtual text, show in floating window on hover
vim.diagnostic.config({
	virtual_text = false,
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = border,
		source = "always",
		header = "",
		prefix = "",
	},
})

-- Show diagnostics in floating window after 1 second hover
vim.api.nvim_create_autocmd("CursorHold", {
	group = vim.api.nvim_create_augroup("float_diagnostic", { clear = true }),
	callback = function()
		vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
	end,
})

-- Show inlay hints in floating window after 1 second hover (if enabled)
local inlay_hint_float_ns = vim.api.nvim_create_namespace("inlay_hint_float")
vim.api.nvim_create_autocmd("CursorHold", {
	group = vim.api.nvim_create_augroup("float_inlay_hints", { clear = true }),
	callback = function()
		local bufnr = vim.api.nvim_get_current_buf()

		-- Only show if inlay hints are enabled for this buffer
		if not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }) then
			return
		end

		local pos = vim.api.nvim_win_get_cursor(0)
		local line = pos[1] - 1
		local col = pos[2]

		-- Get LSP clients that support inlay hints
		local clients = vim.lsp.get_clients({ bufnr = bufnr })
		for _, client in ipairs(clients) do
			if client.server_capabilities.inlayHintProvider then
				-- Request inlay hints for current line
				local params = {
					textDocument = vim.lsp.util.make_text_document_params(),
					range = {
						start = { line = line, character = 0 },
						["end"] = { line = line + 1, character = 0 },
					},
				}

				client.request("textDocument/inlayHint", params, function(err, result)
					if err or not result or vim.tbl_isempty(result) then
						return
					end

					-- Build hint text
					local hints = {}
					for _, hint in ipairs(result) do
						local label = type(hint.label) == "string" and hint.label
							or table.concat(
								vim.tbl_map(function(part)
									return part.value
								end, hint.label),
								""
							)
						table.insert(hints, label)
					end

					if #hints > 0 then
						local hint_text = table.concat(hints, " ")
						-- Show in a minimal floating window
						local lines = { hint_text }
						local buf = vim.api.nvim_create_buf(false, true)
						vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

						vim.api.nvim_open_win(buf, false, {
							relative = "cursor",
							width = #hint_text,
							height = 1,
							row = 1,
							col = 0,
							style = "minimal",
							border = border,
						})

						-- Auto-close after a short delay
						vim.defer_fn(function()
							if vim.api.nvim_buf_is_valid(buf) then
								vim.api.nvim_buf_delete(buf, { force = true })
							end
						end, 2000)
					end
				end, bufnr)
				break
			end
		end
	end,
})

-- =============================================================================
-- LANGUAGE-SPECIFIC SETTINGS
-- =============================================================================

-- C# specific settings and keymaps
vim.api.nvim_create_autocmd("FileType", {
	pattern = "cs",
	callback = function()
		vim.opt_local.tabstop = 4
		vim.opt_local.shiftwidth = 4
		vim.opt_local.expandtab = true

		local map = function(keys, cmd, desc)
			vim.keymap.set("n", keys, cmd, { buffer = true, silent = true, desc = desc })
		end

		map("<leader>cb", ":!dotnet build<CR>", "C# Build")
		map("<leader>ct", ":!dotnet test<CR>", "C# Test")
		map("<leader>cr", ":!dotnet run<CR>", "C# Run")
	end,
})

-- C/C++ specific settings
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c", "cpp" },
	callback = function()
		vim.opt_local.tabstop = 4
		vim.opt_local.shiftwidth = 4
		vim.opt_local.expandtab = true
		vim.opt_local.colorcolumn = "81"
	end,
})

-- =============================================================================
-- THEME PERSISTENCE
-- =============================================================================

local theme_file = vim.fn.stdpath("config") .. "/last_theme.txt"

-- Save theme on exit
vim.api.nvim_create_autocmd("VimLeavePre", {
	callback = function()
		local file = io.open(theme_file, "w")
		if file then
			file:write(vim.g.colors_name or "default")
			file:close()
		end
	end,
})

-- Restore theme on startup
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		local file = io.open(theme_file, "r")
		if file then
			local saved_theme = file:read("*line")
			file:close()
			if saved_theme and saved_theme ~= "" then
				vim.schedule(function()
					pcall(vim.cmd.colorscheme, saved_theme)
				end)
			end
		end
	end,
})

-- =============================================================================
-- KEYMAPS
-- =============================================================================

local map = vim.keymap.set

-- Window management
map("n", "<leader>wv", "<cmd>vsplit<CR>", { desc = "Vertical Split" })
map("n", "<leader>wh", "<cmd>split<CR>", { desc = "Horizontal Split" })

-- Tab management
map("n", "<leader>tt", "<cmd>tabnew<CR>", { desc = "New Tab" })
map("n", "<leader>tc", "<cmd>tabclose<CR>", { desc = "Close Tab" })
map("n", "<leader>tn", "<cmd>tabnext<CR>", { desc = "Next Tab" })
map("n", "<leader>tp", "<cmd>tabprevious<CR>", { desc = "Previous Tab" })

-- Quick config access
vim.api.nvim_create_user_command("Config", function()
	vim.cmd("cd ~/.config/nvim")
	vim.cmd("e init.lua")
end, {})

-- Which-key groups
require("which-key").add({
	{ "<leader>u", group = "UI/Toggles" },
	{ "<leader>w", group = "Window" },
	{ "<leader>t", group = "Tab" },
	{ "<leader>f", group = "Find" },
	{ "<leader>s", group = "Search" },
	{ "<leader>g", group = "Git" },
	{ "<leader>c", group = "Code/C#" },
	{ "<leader>d", group = "Debug" },
	{ "<leader>x", group = "Trouble" },
	{ "<leader>n", group = "Notifications" },
	{ "<leader>o", group = "Oil" },
})
