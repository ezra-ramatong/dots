-- Disable automatic comment leader insertion
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	command = "set formatoptions-=cro",
})

-- Transparent Background
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	command = "highlight Normal guibg=NONE ctermbg=NONE",
})

-- Text yank on highlight
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("ez-highligh-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
