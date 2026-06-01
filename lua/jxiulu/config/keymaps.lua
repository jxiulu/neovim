local map = vim.keymap.set

-- Window management
map("n", "<leader>wv", "<cmd>vsplit<CR>", { desc = "Vertical Split" })
map("n", "<leader>wh", "<cmd>split<CR>", { desc = "Horizontal Split" })

-- Tab management
map("n", "<leader>tt", "<cmd>tabnew<CR>", { desc = "New Tab" })
map("n", "<leader>tc", "<cmd>tabclose<CR>", { desc = "Close Tab" })
map("n", "<leader>tn", "<cmd>tabnext<CR>", { desc = "Next Tab" })
map("n", "<leader>tp", "<cmd>tabprevious<CR>", { desc = "Previous Tab" })

-- Reload colorscheme
map("n", "<leader>uR", function()
	if _G.reload_colorscheme then
		_G.reload_colorscheme()
	else
		vim.notify("No reload function available for current theme", vim.log.levels.WARN)
	end
end, { desc = "Reload Colorscheme" })

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
	{ "<leader>c", group = "Code" },
	{ "<leader>d", group = "Debug" },
	{ "<leader>x", group = "Trouble" },
{ "<leader>o", group = "Oil" },
})
