-- diagnostics

vim.diagnostic.config({
	virtual_text = false,
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = true,
		header = "",
		prefix = "",
	},
})

vim.api.nvim_create_autocmd("CursorHold", {
	group = vim.api.nvim_create_augroup("float_diagnostic", { clear = true }),
	callback = function()
		vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
	end,
})

-- language-specific autocmds

local function map(keys, cmd, desc)
	vim.keymap.set("n", keys, cmd, { buffer = true, silent = true, desc = desc })
end

-- Run a shell command in a toggleterm terminal instead of blocking with :!
local function run(cmd)
	return function()
		vim.cmd({ cmd = "TermExec", args = { "cmd=" .. cmd } })
	end
end

-- cd to project root when a buffer of this type is opened
local function lcd_root(markers)
	local root = vim.fs.root(0, markers)
	if root and vim.fn.getcwd(0) ~= root then
		vim.cmd.lcd(vim.fn.fnameescape(root))
	end
end

local augroup = vim.api.nvim_create_augroup("language_settings", { clear = true })

local function ft(pattern, callback)
	vim.api.nvim_create_autocmd("FileType", { group = augroup, pattern = pattern, callback = callback })
end

-- C / C++
ft({ "c", "cpp" }, function()
	lcd_root({ "Makefile", "makefile", "GNUmakefile", "compile_commands.json", ".git" })
	vim.opt_local.colorcolumn = "80"
	vim.opt_local.path:append({ ".,**", "include", "inc" })
	map("<leader>cb", run("make"), "Make Build")
	map("<leader>cr", run("make run"), "Make Run")
	map("<leader>ct", run("make test"), "Make Test")
	map("<leader>cc", run("make clean"), "Make Clean")
end)

-- Rust (also active in Cargo.toml and other toml files inside a cargo project)
local function rust_maps()
	lcd_root("Cargo.toml")
	map("<leader>cb", run("cargo build"), "Cargo Build")
	map("<leader>cr", run("cargo run"), "Cargo Run")
	map("<leader>ct", run("cargo test"), "Cargo Test")
	map("<leader>cc", run("cargo clippy"), "Cargo Clippy")
end

ft("rust", function()
	vim.opt_local.colorcolumn = "100"
	rust_maps()
end)

ft("toml", function(args)
	local name = vim.fs.basename(vim.api.nvim_buf_get_name(args.buf))
	if name == "Cargo.toml" or name == "Cargo.lock" or vim.fs.root(args.buf, "Cargo.toml") then
		rust_maps()
	end
end)

-- Zig
ft("zig", function()
	vim.opt_local.colorcolumn = "100"
	map("<leader>cb", run("zig build"), "Zig Build")
	map("<leader>cr", run("zig build run"), "Zig Run")
	map("<leader>ct", run("zig build test"), "Zig Test")
end)

-- Java
ft("java", function()
	vim.opt_local.colorcolumn = "120"
	map("<leader>cb", run("javac " .. vim.fn.expand("%")), "Compile File")
	map("<leader>cr", run("java " .. vim.fn.expand("%:r")), "Run File")
end)

-- Markdown
ft("markdown", function()
	vim.opt_local.spell = true
	vim.opt_local.conceallevel = 2
	vim.opt_local.colorcolumn = ""
end)

-- theme persistence

local theme_file = vim.fn.stdpath("state") .. "/last_theme.txt"

vim.api.nvim_create_autocmd("VimLeavePre", {
	callback = function()
		local file = io.open(theme_file, "w")
		if file then
			file:write(vim.g.colors_name or "default")
			file:close()
		end
	end,
})

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		local file = io.open(theme_file, "r")
		if not file then
			return
		end
		local saved_theme = file:read("*line")
		file:close()
		if saved_theme and saved_theme ~= "" and saved_theme ~= vim.g.colors_name then
			pcall(vim.cmd.colorscheme, saved_theme)
		end
	end,
})
