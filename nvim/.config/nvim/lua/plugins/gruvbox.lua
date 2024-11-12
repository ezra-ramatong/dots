return {
	"ellisonleao/gruvbox.nvim",
	priority = 1000,
	config = function()
		require("gruvbox").setup({
			overrides = {
				BufferLineFill = { bg = "#282828" },
				SignColumn = { bg = "#282828" },
			},
		})
	end,
	opts = ...,
}
