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

-- Fill entire window with colorscheme background
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
