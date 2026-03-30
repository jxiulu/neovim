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
	{ "<leader>c", group = "Code" },
	{ "<leader>d", group = "Debug" },
	{ "<leader>x", group = "Trouble" },
	{ "<leader>n", group = "Notifications" },
	{ "<leader>o", group = "Oil" },
})
