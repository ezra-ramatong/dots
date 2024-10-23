return {
	"catppuccin/nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			highlight_overrides = {
				frappe = function(frappe)
					return {
						BufferLineFill = { bg = frappe.base },
					}
				end,
			},
		})
		vim.cmd([[colorscheme catppuccin-frappe]])
	end,
}
