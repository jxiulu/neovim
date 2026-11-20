vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt
opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.updatetime = 1000
opt.timeoutlen = 400
opt.smartindent = true
opt.splitbelow = true
opt.splitright = true
opt.ignorecase = true
opt.smartcase = true
opt.signcolumn = "yes"
opt.statuscolumn = "%s%=%{v:relnum?v:relnum:v:lnum} "
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
opt.textwidth = 0

-- Fill entire window with colorscheme background (OSC 11), restore on exit.
-- Some terminals (Terminal.app) ignore OSC 111, so remember the original
-- background by querying it and put it back explicitly.
local function osc(seq)
	io.stdout:write(seq)
	io.stdout:flush()
end

local original_bg

local function set_term_bg()
	local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
	if normal.bg then
		osc(string.format("\027]11;#%06x\027\\", normal.bg))
	end
end

local function restore_term_bg()
	if original_bg then
		osc(string.format("\027]11;%s\027\\", original_bg))
	end
	osc("\027]111\027\\\027[0m")
end

local group = vim.api.nvim_create_augroup("term_bg", { clear = true })

vim.api.nvim_create_autocmd("TermResponse", {
	group = group,
	callback = function(ev)
		local seq = type(ev.data) == "table" and ev.data.sequence or vim.v.termresponse
		local r, g, b = (seq or ""):match("\027%]11;rgb:(%x%x)%x*/(%x%x)%x*/(%x%x)%x*")
		if r and not original_bg then
			original_bg = string.format("#%s%s%s", r, g, b)
		end
	end,
})

vim.api.nvim_create_autocmd("UIEnter", {
	group = group,
	once = true,
	callback = function()
		osc("\027]11;?\027\\")
		vim.defer_fn(set_term_bg, 100) -- let the reply arrive before overwriting
	end,
})
vim.api.nvim_create_autocmd({ "ColorScheme", "VimResume" }, { group = group, callback = set_term_bg })
vim.api.nvim_create_autocmd({ "VimLeave", "VimSuspend" }, { group = group, callback = restore_term_bg })
