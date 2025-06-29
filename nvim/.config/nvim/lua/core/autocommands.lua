-- Disable automatic comment leader insertion
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	command = "set formatoptions-=cro",
})

-- Transparent Background
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	command = "highlight Normal guibg=NONE ctermbg=NONE",
})

--[[ vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = "*.mdx",
	command = "set filetype=mdx",
}) ]]
