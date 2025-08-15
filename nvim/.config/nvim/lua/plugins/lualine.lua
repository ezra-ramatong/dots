return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", opt = true },
	event = "VeryLazy",
	config = function()
		--light mode
		-- local custom_catppuccin = require("lualine.themes.catppuccin-latte")
		-- dark mode
		local custom_catppuccin = require("lualine.themes.catppuccin-mocha")
		custom_catppuccin.normal.c.bg = "#1E1E2E"
		require("lualine").setup({
			options = {
				disabled_filetypes = { "dashboard", "NvimTree", "Outline" },
				ignore_focus = { "dashboard", "NvimTree", "Outline", "undotree", "netrw" },
				icons_enabled = true,
				component_separators = "",
				section_separators = "",
				theme = custom_catppuccin,
			},
			inactive_winbar = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			sections = {
				lualine_c = { "filename" },
				lualine_x = { " " },
				lualine_y = {
					{ "filetype", icon_only = false, separator = "", padding = { left = 1, right = 0 } },
					"progress",
				},
			},
		})
	end,
}
