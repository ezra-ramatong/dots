--  OPTIONS 
local opt = vim.opt
local o = vim.o
local g = vim.g

-- [indenting]
o.expandtab = true
o.shiftwidth = 2
o.smartindent = true
o.tabstop = 2
o.softtabstop = 2
o.showmode = false
o.cursorline = true
o.cursorlineopt = "both"
o.guicursor = "n-v-c:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor20-Cursor"
o.colorcolumn = "80"
o.textwidth = 100
o.wrap = true -- Enable line wrapping
o.linebreak = true
opt.fillchars = { eob = " " }
o.ignorecase = true
o.smartcase = true
o.mouse = "a"
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldcolumn = "0"
vim.opt.foldtext = ""
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldnestmax = 4

-- [numbers]
o.number = true
o.numberwidth = 2
o.relativenumber = true
o.ruler = false
o.signcolumn = "yes"
o.splitbelow = true
o.splitright = true
o.timeoutlen = 400
o.undofile = true
o.updatetime = 250
opt.whichwrap:append("<>[]hl")
o.termguicolors = true

-- [disable some default providers]
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

-- [netrw options]
g.netrw_banner = 0
g.netrw_keepdir = 0
g.netrw_menu = 0
g.netrw_winsize = 20
g.loaded_netrwPlugin = 1
g.loaded_netrw = 1

-- KEYMAPS
local map = vim.keymap.set

map("", "<Space>", "<Nop>", { silent = true })
g.mapleader = " "

-- [essential]
map("i", "jk","<ESC>", { silent = true })
map("n", "<leader>w",":w<cr>")
map("n", "<leader>q",":confirm q<cr>")
map("n", "<leader>x",":close<cr>")
map("t", "<ESC>", "<C-\\><C-n>")
map("n", "<leader>yf", "<cmd>%y+<CR>", { desc = "Yank file to system clipboard" })
map("n", "<space>x", "<cmd>source %<cr>", { desc = "Source current file" })
--[[ map('i', '<cr>', function()
  return vim.fn.pumvisible() == 1 and '<c-y>' or '<cr>'
end, { expr = true }) ]]
vim.cmd("inoremap <expr> <cr> pumvisible() ? '<c-y>' : '<cr>'")

-- [move lines]
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move line dbdown (normal)" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move line up (normal)" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move line down (insert)" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move line up (insert)" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move line down (visual)" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move line up (visual)" })

-- [window management]
map("n", "<C-h>", "<C-w>h", { silent = true, desc = "Left window navigation" })
map("n", "<C-j>", "<C-w>j", { silent = true, desc = "Down window navigation" })
map("n", "<C-k>", "<C-w>k", { silent = true, desc = "Up window navigation" })
map("n", "<c-l>", "<c-w>l", { silent = true, desc = "Right window navigation" })
map("n", "<leader>wb", "<C-w>o", { silent = true, desc = "Make Window Bigger" })

-- [yank to system clipboard]
map("n", "<leader>y", '"+y')
map("v", "<leader>y", '"+y')
map("n", "<leader>Y", '"+Y')

-- [paste from system clipboard]
map("n", "<leader>p", '"+p')
map("v", "<leader>p", '"+p')
map("n", "<leader>P", '"+P')

-- [quickfix list navigation]
map("n", "<leader>j", "<cmd>cnext<cr>zz", { desc = "Forward quickfix list" })
map("n", "<leader>k", "<cmd>cprev<cr>zz", { desc = "Backward quickfix list" })
map("n", "<leader>cc", "<cmd>cclose<cr>zz", { desc = "Close quickfix window" })

-- [file explorer (Oil)]
map("n", "<leader>e", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })

-- [telescope]
map("n", "<leader>ff", "<cmd>Telescope find_files hidden=true <cr>", { desc = "Find all files" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Find Help" })
map("n", "<leader>fm", "<cmd>Telescope man_pages<cr>", { desc = "Find Man Pages" })
map("n", "<leader>fi", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Find in buffer" })
map("n", "<leader>fw", "<cmd>Telescope live_grep<cr>", { desc = "Find word in workspace" })
map("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Keymaps" })
map("n", "<leader>fg", "<cmd>Telescope git_files show_untracked=true<cr>", { desc = "Find git files" })
map("n", "<leader>fc", "<cmd>Telescope commands<cr>", { desc = "Find command history" })
map("n", "<leader>tc", "<cmd>Telescope colorscheme<cr>", { desc = "Select colorscheme" })

-- [lazy - package manager]
map("n", "<leader>lz", "<cmd>Lazy<cr>", { desc = "Open Lazy" })

-- [mason - language tooling manager] 
map("n", "<leader>ma", "<cmd>Mason<cr>", { desc = "Open Mason" })

-- AUTOCOMMANDS

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

-- PLUGIN MANAGER (LAZY)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
	change_detection = {
		notify = false,
	},
	install = { colorscheme = { "catppuccin" } },
})
