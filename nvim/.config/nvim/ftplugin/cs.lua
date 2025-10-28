vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
vim.opt_local.expandtab = true

local map = vim.keymap.set
local opts = { noremap = true, silent = true, buffer = true }
map("n", "gd", vim.lsp.buf.definition, opts)
map("n", "<leader>lR", require("telescope.builtin").lsp_references, opts)
map("n", "<leader>lr", vim.lsp.buf.rename, opts)
map("n", "<leader>ls", require("telescope.builtin").lsp_document_symbols, opts)
map("n", "<leader>lw", require("telescope.builtin").lsp_workspace_symbols, opts)
map("n", "<leader>la", vim.lsp.buf.code_action, opts)
map("n", "<leader>lf", vim.lsp.buf.format, opts)
map("n", "[d", vim.diagnostic.goto_prev, opts)
map("n", "]d", vim.diagnostic.goto_next, opts)
map("n", "<leader>li", "<cmd>LspInfo<cr>", opts)
map("n", "<leader>ld", vim.diagnostic.setqflist, opts)
map("n", "K", vim.lsp.buf.hover, opts)
