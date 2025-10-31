vim.api.nvim_create_autocmd({ "BufEnter" }, {
	desc = "Disable automatic comment leader insertion",
	command = "set formatoptions-=cro",
})

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("ez-highligh-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "xml",
	callback = function()
		vim.opt_local.shiftwidth = 4
		vim.opt_local.tabstop = 4
		vim.opt_local.softtabstop = 4
		vim.opt_local.expandtab = true
	end,
})
