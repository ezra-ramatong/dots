return {
	"catppuccin/nvim",
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
			integrations = {
				telescope = {
					style = "nvchad",
				},
			},
		})
		-- light mode
		-- vim.cmd([[colorscheme catppuccin-latte]])

		-- dark mode
		vim.cmd([[colorscheme catppuccin]])
	end,
}
