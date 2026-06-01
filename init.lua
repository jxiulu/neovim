if vim.loader then
	vim.loader.enable()
end

require("jxiulu.config.options")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
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


require("lazy").setup("jxiulu.plugins", { ui = { border = "rounded" } })

require("jxiulu.config.autocmds")
require("jxiulu.config.keymaps")
