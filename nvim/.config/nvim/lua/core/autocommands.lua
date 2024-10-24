-- Disable automatic comment leader insertion
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	command = "set formatoptions-=cro",
})
