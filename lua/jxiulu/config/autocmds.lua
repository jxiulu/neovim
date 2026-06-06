-- =============================================================================
-- DIAGNOSTICS
-- =============================================================================

vim.diagnostic.config({
	virtual_text = false,
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = "always",
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

-- LANGUAGE-SPECIFIC SETTINGS

-- Disable treesitter for help files (nvim-treesitter vimdoc query bug on 0.12)
-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = "help",
-- 	callback = function() vim.treesitter.stop() end,
-- })
--
local function map(keys, cmd, desc)
	vim.keymap.set("n", keys, cmd, { buffer = true, silent = true, desc = desc })
end

-- Rust: cd to project root on enter
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = {"*.rs", "Cargo.toml"},
	callback = function()
		local root = vim.fs.root(0, "Cargo.toml")
		if root then
			vim.cmd.lcd(root)
		end
	end,
})

-- Rust
vim.api.nvim_create_autocmd("FileType", {
	pattern = "rust",
	callback = function()
		vim.opt_local.colorcolumn = "100"
		map("<leader>cb", ":!cargo build<CR>", "Cargo Build")
		map("<leader>cr", ":!cargo run<CR>", "Cargo Run")
		map("<leader>ct", ":!cargo test<CR>", "Cargo Test")
		map("<leader>cc", ":!cargo clippy<CR>", "Cargo Clippy")
	end,
})

-- Zig
vim.api.nvim_create_autocmd("FileType", {
	pattern = "zig",
	callback = function()
		vim.opt_local.colorcolumn = "100"
		map("<leader>cb", ":!zig build<CR>", "Zig Build")
		map("<leader>cr", ":!zig build run<CR>", "Zig Run")
		map("<leader>ct", ":!zig build test<CR>", "Zig Test")
	end,
})

-- Java
vim.api.nvim_create_autocmd("FileType", {
	pattern = "java",
	callback = function()
		vim.opt_local.colorcolumn = "120"
		map("<leader>cb", ":!javac %<CR>", "Compile File")
		map("<leader>cr", ":!java %:r<CR>", "Run File")
	end,
})

-- Markdown
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.opt_local.spell = true
		vim.opt_local.conceallevel = 2
		vim.opt_local.colorcolumn = ""
	end,
})

-- =============================================================================
-- THEME PERSISTENCE
-- =============================================================================

local theme_file = vim.fn.stdpath("config") .. "/last_theme.txt"

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
