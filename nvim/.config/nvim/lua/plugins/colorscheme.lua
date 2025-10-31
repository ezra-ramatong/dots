return {
	{
		"catppuccin/nvim",
		enabled = true,
		lazy = false,
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				highlight_overrides = {
					mocha = function(mocha)
						return {
							BufferLineFill = { bg = mocha.base },
						}
					end,
				},
				float = {
					solid = true,
				},
				integrations = {
					cmp = true,
					gitsigns = true,
					harpoon = true,
					mini = {
						enabled = true,
					},
					telescope = {
						style = "nvchad_outlined",
					},
				},
			})
			-- light mode
			-- vim.cmd([[colorscheme catppuccin-latte]])

			-- dark mode
			vim.cmd([[colorscheme catppuccin]])
		end,
	},
	{
		"olimorris/onedarkpro.nvim",
		enabled = false,
		lazy = false,
		priority = 1000,
		config = function()
			local color = require("onedarkpro.helpers")
			require("onedarkpro").setup({
				colors = {
					dark = {
						telescope_prompt = color.darken("bg", 1, "vaporwave"),
						telescope_results = color.darken("bg", 4, "vaporwave"),
						telescope_preview = color.darken("bg", 6, "vaporwave"),
						telescope_selection = color.darken("bg", 8, "vaporwave"),
					},
				},
				highlights = {
					BufferLineFill = { bg = "${bg}" },
					FloatBorder = { fg = "${blue}", bg = "${bg}" },

					-- Telescope highlights
					TelescopeBorder = {
						fg = "${telescope_results}",
						bg = "${telescope_results}",
					},
					TelescopePromptBorder = {
						fg = "${telescope_prompt}",
						bg = "${telescope_prompt}",
					},
					TelescopePromptCounter = { fg = "${fg}" },
					TelescopePromptNormal = { fg = "${fg}", bg = "${telescope_prompt}" },
					TelescopePromptPrefix = {
						fg = "${purple}",
						bg = "${telescope_prompt}",
					},
					TelescopePromptTitle = {
						fg = "${telescope_prompt}",
						bg = "${purple}",
					},
					TelescopePreviewTitle = {
						fg = "${telescope_results}",
						bg = "${purple}",
					},
					TelescopeResultsTitle = {
						fg = "${telescope_results}",
						bg = "${telescope_results}",
					},
					TelescopeMatching = { fg = "${blue}" },
					TelescopeNormal = { bg = "${telescope_results}" },
					TelescopeSelection = { fg = "${purple}", bg = "${telescope_selection}" },
					TelescopePreviewNormal = { bg = "${telescope_preview}" },
					TelescopePreviewBorder = { fg = "${telescope_preview}", bg = "${telescope_preview}" },
				},
			})
			vim.cmd([[colorscheme onedark]])
		end,
	},
}
