return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", opt = true },
	event = "VeryLazy",
	config = function()
		-- local custom_catppuccin = require("lualine.themes.catppuccin-frappe")
		-- custom_catppuccin.normal.c.bg = "#303446"
		require("lualine").setup({
			options = {
				disabled_filetypes = { "dashboard", "NvimTree", "Outline" },
				ignore_focus = { "dashboard", "NvimTree", "Outline", "undotree", "netrw" },
				icons_enabled = true,
				component_separators = "",
				section_separators = "",
				-- theme = custom_catppuccin,
			},
			sections = {
				lualine_c = { " " },
				lualine_x = { " " },
				lualine_y = {
					{ "filetype", icon_only = false, separator = "", padding = { left = 1, right = 0 } },
					"progress",
				},
			},
		})
	end,
}
