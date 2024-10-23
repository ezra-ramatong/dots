return {
	"akinsho/bufferline.nvim",
	version = "*",
	event = "BufEnter",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local bufferline = require("bufferline")
		bufferline.setup({
			options = {
				themable = true,
				close_command = "bdelete! %d",
				diagnostics = "nvim_lsp",
				indicator = "none",
				offsets = {
					{
						filetype = "netrw",
						text = "File Explorer",
						highlight = "Directory",
						text_align = "center",
						padding = 2,
						separator = false,
					},
				},
				tab_size = 20,
				separator_style = " thin ",
				always_show_bufferline = true,
				style_preset = {
					bufferline.style_preset.no_italic,
				},
			},
		})
	end,
}
