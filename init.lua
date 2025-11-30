-- Neovim Configuration

-- Enable loader if available
if vim.loader then vim.loader.enable() end

-- =============================================================================
-- OPTIONS & GLOBALS
-- =============================================================================
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt
opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.updatetime = 200
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

-- Indentation & Wrapping
opt.wrap = true
opt.linebreak = true
opt.breakindent = true
opt.breakindentopt = "shift:2"
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true

-- Filetype specific options
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function() vim.wo.conceallevel = 2 end,
})

-- =============================================================================
-- LAZY.NVIM BOOTSTRAP
-- =============================================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- =============================================================================
-- LSP ATTACH & HELPERS
-- =============================================================================
local function lsp_on_attach(client, bufnr)
    local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, noremap = true, desc = desc })
    end

    map("n", "K", vim.lsp.buf.hover, "LSP Hover")
    map("n", "gd", vim.lsp.buf.definition, "Goto Definition")
    map("n", "gr", vim.lsp.buf.references, "References")
    map("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")
    map("n", "gi", vim.lsp.buf.implementation, "Goto Implementation")
    map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
    map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")

    -- Diagnostics
    map("n", "gl", vim.diagnostic.open_float, "Line Diagnostics")
    map("n", "[d", vim.diagnostic.goto_prev, "Prev Diagnostic")
    map("n", "]d", vim.diagnostic.goto_next, "Next Diagnostic")

    -- Disable inlay hints by default (toggle with <leader>uh)
    if vim.lsp.inlay_hint and client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
    end
end

-- Border option for floating windows
local borderopt = "none"

-- =============================================================================
-- PLUGINS
-- =============================================================================
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
                base00 = "#212121", base01 = "#212121", base02 = "#6c6c6c",
                base03 = "#6c6c6c", base04 = "#9e9e9e", base05 = "#dadada",
                base06 = "#eeeeee", base07 = "#ffffff",
                base08 = "#ff5f87", -- cherry
                base09 = "#ffaf5f", -- amber
                base0A = "#d28b44", -- orange
                base0B = "#64af49", -- fartgreen
                base0C = "#b65493", -- burple
                base0D = "#875fff", -- violet
                base0E = "#d75fff", -- magenta
                base0F = "#dadada",
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
    {
        "nickkadutskyi/jb.nvim",
        "xiantang/darcula-dark.nvim",
        "idr4n/github-monochrome.nvim",
        "felipeagc/fleet-theme-nvim",
        "flazz/vim-colorschemes",
        priority = 1000,
    },

    -- UTILITIES
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
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
            zen = { hide_line_numbers = false },
            image = {},
        },
        keys = {
            { "<leader>e2", function() Snacks.explorer.reveal() end, desc = "Snacks Explorer" },
            { "<leader>ns", function() Snacks.notifier.show_history() end, desc = "Show History" },
            { "<leader>fp", function() Snacks.picker.projects() end, desc = "Find Projects" },
            { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
            { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
            { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
            { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
            { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
            { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
            { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
            { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff" },
            { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
            { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
            { "<leader>uz", function() Snacks.zen() end, desc = "Zen Toggle" },
            { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
            { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
            { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
            { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
            { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto Type Definition" },
            { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
            { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "Workspace Symbols" },
            { "<leader>fc", function() Snacks.picker.colorschemes() end, desc = "Find Colorschemes" },
            { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
            { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
            { "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
            { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Grep Word", mode = { "n", "x" } },
            { "<leader>cr", function() vim.lsp.buf.rename() end, desc = "Rename Symbol" },
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
                    Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
                    Snacks.toggle.treesitter():map("<leader>uT")
                    Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
                    Snacks.toggle.inlay_hints():map("<leader>uh")
                    Snacks.toggle.indent():map("<leader>ug")
                    Snacks.toggle.dim():map("<leader>uD")
                end,
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = function()
            pcall(require("nvim-treesitter.install").update({ with_sync = true }))
        end,
        opts = {
            ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "markdown", "markdown_inline", "python", "json", "bash" },
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
        config = function(_, opts) require("nvim-treesitter.configs").setup(opts) end,
    },

    -- LSP & MASON
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        opts = {},
        config = function(_, opts) require("mason").setup(opts) end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig", "hrsh7th/cmp-nvim-lsp" },
        opts = function()
            local lspconfig = require("lspconfig")
            local util = require("lspconfig.util")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport = false

            local base_opts = { on_attach = lsp_on_attach, capabilities = capabilities }
            local servers = {
                clangd = {
                    cmd = { "clangd", "--header-insertion=never", "--completion-style=detailed", "--background-index", "--offset-encoding=utf-16", "--function-arg-placeholders=false" },
                    init_options = { clangdFileStatus = true, fallbackFlags = { "-Xclang", "-code-completion-brief-comments" } },
                    flags = { debounce_text_changes = 150 },
                    root_dir = util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
                },
                lua_ls = {
                    settings = { Lua = { workspace = { checkThirdParty = false }, diagnostics = { globals = { "vim" } } } },
                },
                cmake = {},
                ts_ls = {
                    settings = { typescript = { preferences = { includeCompletionsForModuleExports = true, includeCompletionsForImportStatements = true } } },
                },
                rust_analyzer = {}, -- managed by rustaceanvim
            }
            local skip_servers = { rust_analyzer = true }

            return {
                ensure_installed = { "clangd", "lua_ls", "cmake", "ts_ls", "eslint", "biome", "rust_analyzer" },
                automatic_installation = false,
                handlers = {
                    function(server_name)
                        if skip_servers[server_name] then return end
                        if not lspconfig[server_name] then return end
                        lspconfig[server_name].setup(vim.tbl_deep_extend("force", {}, base_opts, servers[server_name] or {}))
                    end,
                },
            }
        end,
        config = function(_, opts) require("mason-lspconfig").setup(opts) end,
    },
    { "neovim/nvim-lspconfig" },
    {
        "mrcjkb/rustaceanvim",
        version = "^5",
        lazy = false,
        ft = { "rust" },
        opts = {
            server = {
                on_attach = lsp_on_attach,
                default_settings = {
                    ["rust-analyzer"] = {
                        checkOnSave = true,
                        cargo = { allFeatures = true, loadOutDirsFromCheck = true, buildScripts = { enable = true } },
                        procMacro = { enable = true, ignored = { ["async-trait"] = { "async_trait" }, ["napi-derive"] = { "napi" } } },
                        inlayHints = { typeHints = { enable = true }, parameterHints = { enable = true }, chainingHints = { enable = true } },
                    },
                },
            },
        },
        config = function(_, opts) vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {}) end,
    },
    {
        "saecki/crates.nvim",
        event = { "BufRead Cargo.toml" },
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = { completion = { cmp = { enabled = true } }, lsp = { enabled = true, actions = true, completion = true, hover = true } },
        config = function(_, opts)
            require("crates").setup(opts)
            local cmp_ok, cmp = pcall(require, "cmp")
            if cmp_ok then
                local config = cmp.get_config()
                table.insert(config.sources, { name = "crates" })
                cmp.setup(config)
            end
        end,
    },

    -- COMPLETION & FORMATTING
    {
        "hrsh7th/nvim-cmp",
        dependencies = { "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip", "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-path" },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            require("luasnip.loaders.from_vscode").lazy_load()
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

            cmp.setup({
                snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
                mapping = cmp.mapping.preset.insert({
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    ["<C-p>"] = cmp.mapping.select_prev_item(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then cmp.select_next_item() elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump() else fallback() end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then cmp.select_prev_item() elseif luasnip.jumpable(-1) then luasnip.jump(-1) else fallback() end
                    end, { "i", "s" }),
                }),
                sources = { { name = "nvim_lsp" }, { name = "luasnip" }, { name = "path" } },
            })
        end,
    },
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                c = { "clang_format" }, cpp = { "clang_format" }, lua = { "stylua" }, python = { "isort", "black" }, rust = { "rustfmt" },
                javascript = { "biome", "prettierd", "prettier" }, typescript = { "biome", "prettierd", "prettier" },
                javascriptreact = { "biome", "prettierd", "prettier" }, typescriptreact = { "biome", "prettierd", "prettier" },
            },
            formatters = { clang_format = { args = { "--style={BasedOnStyle: llvm, IndentWidth: 4}" } } },
            format_on_save = function(buf)
                local ignore_large = vim.api.nvim_buf_line_count(buf) > 5000
                return ignore_large and nil or { lsp_fallback = true, timeout_ms = 2000 }
            end,
        },
    },

    -- UI & NAVIGATION
    { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" }, config = true },
    {
        "stevearc/oil.nvim",
        dependencies = { { "echasnovski/mini.icons", opts = {} } },
        keys = { { "<leader>o", "<cmd>Oil<CR>", desc = "Open parent dir" } },
        lazy = false,
        opts = {
            default_file_explorer = true,
            columns = { "icon", "permissions", "size", "mtime" },
            view_options = { show_hidden = true, natural_order = true, sort = { { "type", "asc" }, { "name", "asc" } } },
            float = { padding = 2, max_width = 0.95, max_height = 0.90, border = borderopt, win_options = { winblend = 0 } },
            delete_to_trash = true, skip_confirm_for_simple_edits = true, use_default_keymaps = true,
        },
    },
    { "nvim-lualine/lualine.nvim", opts = { options = { theme = "auto", section_separators = "", component_separators = "" } } },
    { "lewis6991/gitsigns.nvim", event = { "BufReadPre", "BufNewFile" }, opts = {} },
    { "numToStr/Comment.nvim", opts = {} },
    { "folke/which-key.nvim" },
    { "nssteinbrenner/dart", branch = "master", tag = "v1.0.0", dependencies = { { "nvim-lua/plenary.nvim" } } },
    {
        "cbochs/grapple.nvim",
        dependencies = { { "nvim-tree/nvim-web-devicons", lazy = true } },
        opts = { scope = "git_branch" },
        event = { "BufReadPost", "BufNewFile" },
        cmd = "Grapple",
        keys = {
            { "<leader>rm", "<cmd>Grapple toggle<cr>", desc = "Grapple Toggle" },
            { "<leader>rM", "<cmd>Grapple toggle_tags<cr>", desc = "Grapple Tags" },
            { "<leader>rn", "<cmd>Grapple cycle_tags next<cr>", desc = "Grapple Next" },
            { "<leader>rp", "<cmd>Grapple cycle_tags prev<cr>", desc = "Grapple Prev" },
        },
    },

    -- DEBUGGING
    {
        "mfussenegger/nvim-dap",
        dependencies = { "rcarriga/nvim-dap-ui", "jay-babu/mason-nvim-dap.nvim", "nvim-neotest/nvim-nio" },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")
            require("mason-nvim-dap").setup({ ensure_installed = { "codelldb" } })
            dapui.setup()
            dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
            dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
            dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

            vim.keymap.set("n", "<F5>", dap.continue, { desc = "DAP Continue" })
            vim.keymap.set("n", "<F10>", dap.step_over, { desc = "DAP Step Over" })
            vim.keymap.set("n", "<F11>", dap.step_into, { desc = "DAP Step Into" })
            vim.keymap.set("n", "<F12>", dap.step_out, { desc = "DAP Step Out" })
            vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP Breakpoint" })
            vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "DAP REPL" })

            local mason_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/"
            local codelldb = mason_path .. "adapter/codelldb"
            pcall(function()
                dap.adapters.codelldb = { type = "server", port = "${port}", executable = { command = codelldb, args = { "--port", "${port}" }, detached = false } }
            end)
            dap.configurations.cpp = {
                {
                    name = "Launch (build and run)",
                    type = "codelldb",
                    request = "launch",
                    program = function()
                        vim.fn.jobstart({ "bash", "-lc", "make -j || cmake -S . -B build && cmake --build build -j" }, { stdout_buffered = true })
                        return vim.fn.input("Path to executable: ", "./build/main", "file")
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
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
            dap.configurations.javascript = {
                { type = "pwa-node", request = "launch", name = "Launch file", program = "${file}", cwd = "${workspaceFolder}" },
                { type = "pwa-node", request = "launch", name = "Launch npm script", runtimeExecutable = "npm", runtimeArgs = { "run", "debug" }, cwd = "${workspaceFolder}" },
            }
            dap.configurations.typescript = dap.configurations.javascript
            dap.configurations.javascriptreact = dap.configurations.javascript
            dap.configurations.typescriptreact = dap.configurations.javascript
        end,
    },

    -- MISC
    { "folke/neodev.nvim", opts = {} },
    { "altermo/ultimate-autopair.nvim", event = { "InsertEnter", "CmdlineEnter" }, branch = "v0.6", opts = {} },
    { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
    {
        "epwalsh/obsidian.nvim",
        version = "*",
        lazy = true,
        ft = "markdown",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            workspaces = { { name = "personal", path = "/Users/jerrylu/Library/Mobile Documents/iCloud~md~obsidian/Documents/myvault" } },
            ui = { enable = false },
        },
    },
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" },
        opts = { render_modes = true, anti_conceal = { enabled = true }, heading = { border = true, border_virtual = true } },
        ft = { "markdown" },
    },
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
        "ray-x/lsp_signature.nvim",
        event = "InsertEnter",
        opts = {
            bind = true,
            handler_opts = { border = borderopt, hint_enable = false, floating_window = true, toggle_key = "<leader>uls", floating_window_above_cur_line = true },
        },
    },
    {
        "folke/trouble.nvim",
        opts = {},
        cmd = "Trouble",
        keys = {
            { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
            { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
            { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
            { "<leader>xl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions (Trouble)" },
            { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
            { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
        },
    },
    {
        "rmagatti/auto-session",
        lazy = false,
        opts = { suppressed_dirs = { "~/Downloads" }, cwd_change_handling = { restore_upcoming_session = true } },
    },
}, { ui = { border = borderopt } })

-- =============================================================================
-- AUTOCOMMANDS & LOGIC
-- =============================================================================

-- Theme Persistence
local theme_file = vim.fn.stdpath("config") .. "/last_theme.txt"
vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = function()
        local file = io.open(theme_file, "w")
        if file then file:write(vim.g.colors_name or "default"); file:close() end
    end,
})
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        local file = io.open(theme_file, "r")
        if file then
            local saved_theme = file:read("*line")
            file:close()
            if saved_theme and saved_theme ~= "" then
                vim.schedule(function() pcall(vim.cmd.colorscheme, saved_theme) end)
            end
        end
    end,
})

-- Inline Diagnostics (Floating window on cursor hold)
vim.diagnostic.config({ virtual_text = false, signs = true, underline = true, update_in_insert = false, severity_sort = true, float = { border = borderopt, source = "if_many", focusable = false } })
vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        local win = vim.b._diag_float
        if win and vim.api.nvim_win_is_valid(win) then return end
        local _, float_win = vim.diagnostic.open_float(nil, { border = borderopt, focusable = false })
        if float_win and vim.api.nvim_win_is_valid(float_win) then vim.b._diag_float = float_win end
    end,
})
vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "InsertEnter", "BufHidden" }, {
    callback = function()
        local win = vim.b._diag_float
        if win and vim.api.nvim_win_is_valid(win) then pcall(vim.api.nvim_win_close, win, true) end
        vim.b._diag_float = nil
    end,
})

-- Rust Specific
vim.api.nvim_create_autocmd("FileType", {
    pattern = "rust",
    callback = function()
        vim.opt_local.colorcolumn = "100"
        vim.opt_local.textwidth = 99
        local map = function(keys, func, desc) vim.keymap.set("n", keys, func, { buffer = true, silent = true, desc = desc }) end
        map("<leader>rb", ":!cargo build<CR>", "Cargo Build")
        map("<leader>rt", ":!cargo test<CR>", "Cargo Test")
        map("<leader>rr", ":!cargo run<CR>", "Cargo Run")
        map("<leader>rc", ":!cargo check<CR>", "Cargo Check")
        map("<leader>rf", ":!cargo fmt<CR>", "Cargo Format")
        map("<leader>rl", ":!cargo clippy<CR>", "Cargo Clippy")
        map("<leader>ri", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 }) end, "Toggle Inlay Hints")

        if vim.g.rustaceanvim then
            map("<leader>rR", ":RustLsp runnables<CR>", "Rust Runnables")
            map("<leader>rd", ":RustLsp debuggables<CR>", "Rust Debug")
            map("<leader>re", ":RustLsp expandMacro<CR>", "Expand Macro")
            map("<leader>rC", ":RustLsp openCargo<CR>", "Open Cargo.toml")
            map("<leader>rp", ":RustLsp parentModule<CR>", "Parent Module")
            map("<leader>rh", ":RustLsp hover actions<CR>", "Hover Actions")
        end
    end,
})

-- Cargo.toml Keymaps
vim.api.nvim_create_autocmd("BufRead", {
    pattern = "Cargo.toml",
    callback = function()
        if not pcall(require, "crates") then return end
        local map = function(keys, cmd, desc) vim.keymap.set("n", keys, cmd, { buffer = true, silent = true, desc = desc }) end
        map("<leader>ct", ":lua require('crates').toggle()<CR>", "Crates Toggle")
        map("<leader>cu", ":lua require('crates').update_crate()<CR>", "Update Crate")
        map("<leader>cU", ":lua require('crates').upgrade_crate()<CR>", "Upgrade Crate")
        map("<leader>ca", ":lua require('crates').update_all_crates()<CR>", "Update All")
        map("<leader>cA", ":lua require('crates').upgrade_all_crates()<CR>", "Upgrade All")
        map("<leader>cH", ":lua require('crates').open_homepage()<CR>", "Homepage")
        map("<leader>cD", ":lua require('crates').open_documentation()<CR>", "Documentation")
    end,
})

-- =============================================================================
-- KEYMAPS (GENERAL)
-- =============================================================================
vim.api.nvim_create_user_command("Config", function()
    vim.cmd("cd ~/.config/nvim")
    vim.cmd("e init.lua")
    print("Changed directory to ~/.config/nvim")
end, {})

local map = vim.keymap.set
map("n", "<leader>wv", "<cmd>vsplit<CR>", { desc = "Vsplit" })
map("n", "<leader>wh", "<cmd>split<CR>", { desc = "Hsplit" })
map("n", "<leader>tt", "<cmd>tabnew<CR>", { desc = "New tab" })
map("n", "<leader>tc", "<cmd>tabclose<CR>", { desc = "Close tab" })
map("n", "<leader>to", "<cmd>tabonly<CR>", { desc = "Close other tabs" })
map("n", "<leader>tp", "<cmd>tabprevious<CR>", { desc = "Previous tab" })
map("n", "<leader>tn", "<cmd>tabnext<CR>", { desc = "Next tab" })
map("n", "<leader>tl", "<cmd>tablast<CR>", { desc = "Last tab" })
for i = 1, 9 do map("n", "<leader>t" .. i, i .. "gt", { desc = "Go tab " .. i }) end

-- Dart Keymaps
local dart = require("dart").setup()
map("n", "<leader>da", function() dart:list():add() end, { desc = "Dart Add" })
map("n", "<leader>dm", function() dart.ui:toggle_quick_menu(dart:list()) end, { desc = "Dart Menu" })
map("n", "<leader>dp", function() dart:list():prev() end, { desc = "Dart Prev" })
map("n", "<leader>dn", function() dart:list():next() end, { desc = "Dart Next" })
for i = 1, 4 do map("n", "<leader>d" .. i, function() dart:list():select(i) end, { desc = "Dart Select " .. i }) end

-- CWD & Root Management
local ROOT_MARKERS = { ".git", "compile_commands.json", "CMakeLists.txt", "Makefile", "pyproject.toml", "package.json" }
local function buf_dir()
    if vim.bo.filetype == "oil" then
        local ok, oil = pcall(require, "oil")
        if ok and oil.get_current_dir() then return oil.get_current_dir() end
    end
    local p = vim.api.nvim_buf_get_name(0)
    return p ~= "" and vim.fn.fnamemodify(p, ":p:h") or vim.loop.cwd()
end

local function set_cwd(dir)
    if dir and vim.loop.fs_stat(dir) and vim.loop.fs_stat(dir).type == "directory" then
        vim.cmd("noautocmd cd " .. vim.fn.fnameescape(dir))
        vim.notify("CWD >> " .. vim.loop.cwd(), vim.log.levels.INFO, { title = "CWD" })
    end
end

map("n", "<leader>ed", function() set_cwd(buf_dir()) end, { desc = "CWD: parent of current file" })
map("n", "<leader>es", function() vim.notify("Current CWD: " .. vim.loop.cwd()) end, { desc = "Print CWD" })
map("n", "<leader>or", "<cmd>Oil --float .<CR>", { desc = "Open project root in Oil" })
map("n", "<leader>er", function()
    local roots = vim.lsp.get_clients({ bufnr = 0 })
    local root = nil
    for _, c in ipairs(roots) do if c.config.root_dir then root = c.config.root_dir; break end end
    if not root then
        local dir = buf_dir()
        while dir and dir ~= "" and dir ~= "/" do
            for _, m in ipairs(ROOT_MARKERS) do if vim.fn.filereadable(dir .. "/" .. m) == 1 or vim.fn.isdirectory(dir .. "/" .. m) == 1 then root = dir; break end end
            if root then break end
            dir = vim.fn.fnamemodify(dir, ":h")
        end
    end
    if root then set_cwd(root) else vim.notify("No project root found", vim.log.levels.WARN) end
end, { desc = "CWD: Project Root" })

-- WhichKey Groups
require("which-key").add({
    { "<leader>u", group = "ui / toggles" },
    { "<leader>w", group = "window" },
    { "<leader>t", group = "tab" },
    { "<leader>r", group = "grapple/rust" },
    { "<leader>d", group = "dart/debug" },
    { "<leader>f", group = "find (Snacks)" },
    { "<leader>g", group = "git (Snacks)" },
    { "<leader>s", group = "search/symbols" },
    { "<leader>x", group = "trouble" },
})