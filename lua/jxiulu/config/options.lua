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

-- Fill entire window with colorscheme background (OSC 11), reset on exit
local function osc(seq)
	io.stdout:write(seq)
	io.stdout:flush()
end

local function set_term_bg()
	local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
	if normal.bg then
		osc(string.format("\027]11;#%06x\027\\", normal.bg))
	end
end

local group = vim.api.nvim_create_augroup("term_bg", { clear = true })
vim.api.nvim_create_autocmd({ "UIEnter", "ColorScheme", "VimResume" }, {
	group = group,
	callback = set_term_bg,
})
vim.api.nvim_create_autocmd({ "VimLeave", "VimSuspend" }, {
	group = group,
	callback = function()
		osc("\027]111\027\\")
	end,
})
