-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)
-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = "<Space>"
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		{ "LazyVim/LazyVim", import = "lazyvim.plugins" },
		-- add your plugins here
		{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
		{ "ThePrimeagen/vim-be-good" },
		-- {
		-- 	"sainnhe/gruvbox-material",
		-- 	lazy = false,
		-- 	priority = 1000,
		-- 	config = function()
		-- 		-- Optionally configure and load the colorscheme
		-- 		-- directly inside the plugin declaration.
		-- 		vim.g.gruvbox_material_enable_italic = true
		-- 		vim.cmd.colorscheme("gruvbox-material")
		-- 	end,
		-- },
		{
			"folke/trouble.nvim",
			opts = {}, -- for default options, refer to the configuration section for custom setup.
			cmd = "Trouble",
			keys = {
				{
					"<leader>xx",
					"<cmd>Trouble diagnostics toggle<cr>",
					desc = "Diagnostics (Trouble)",
				},
				{
					"<leader>xX",
					"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
					desc = "Buffer Diagnostics (Trouble)",
				},
				{
					"<leader>cs",
					"<cmd>Trouble symbols toggle focus=false<cr>",
					desc = "Symbols (Trouble)",
				},
				{
					"<leader>cl",
					"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
					desc = "LSP Definitions / references / ... (Trouble)",
				},
				{
					"<leader>xL",
					"<cmd>Trouble loclist toggle<cr>",
					desc = "Location List (Trouble)",
				},
				{
					"<leader>xQ",
					"<cmd>Trouble qflist toggle<cr>",
					desc = "Quickfix List (Trouble)",
				},
			},
		},
		{
			"kylechui/nvim-surround",
			version = "*", -- Use for stability; omit to use `main` branch for the latest features
			event = "VeryLazy",
			config = function()
				require("nvim-surround").setup({
					-- Configuration here, or leave empty to use defaults
				})
			end,
		},

		{
			"numToStr/Comment.nvim",
			opts = {
				-- add any options here
			},
		},
		{
			"mrcjkb/rustaceanvim",
			version = "^4", -- Recommended
			lazy = false, -- This plugin is already lazy
		},
		{
			"epwalsh/obsidian.nvim",
			version = "*", -- recommended, use latest release instead of latest commit
			lazy = true,
			ft = "markdown",
			-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
			-- event = {
			--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
			--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
			--   "BufReadPre path/to/my-vault/**.md",
			--   "BufNewFile path/to/my-vault/**.md",
			-- },
			dependencies = {
				-- Required.
				"nvim-lua/plenary.nvim",

				-- see below for full list of optional dependencies 👇
			},
			opts = {
				workspaces = {
					{
						name = "notes",
						path = "~/Notes",
					},
				},

				-- see below for full list of options 👇
			},
		},
		{
			"AlexvZyl/nordic.nvim",
			lazy = false,
			priority = 1000,
			config = function()
				require("nordic").load()
			end,
		},

		opts = {
			colorscheme = "nordic",
		},
	},
	colorscheme = "nordic",
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "nordic" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})

require("lspconfig")["gdscript"].setup({
	name = "godot",
	cmd = vim.lsp.rpc.connect("127.0.0.1", "6005"),
})

local dap = require("dap")
dap.adapters.godot = { type = "server", host = "127.0.0.1", port = 6006 }
dap.configurations.gdscript = {
	{
		type = "godot",
		request = "launch",
		name = "Launch scene",
		project = "${workspaceFolder}",
		launch_scene = true,
	},
}

require("nvim-surround").setup()
