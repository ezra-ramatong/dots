local opt = vim.opt
local o = vim.o
local g = vim.g

-- Indenting
o.expandtab = true
o.shiftwidth = 2
o.smartindent = true
o.tabstop = 2
o.softtabstop = 2

o.showmode = false
o.cursorline = true
o.cursorlineopt = "both"
o.guicursor = "n-v-c:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor20-Cursor"
-- o.colorcolumn = "80"
o.textwidth = 100
o.wrap = true -- Enable line wrapping
o.linebreak = true
opt.fillchars = { eob = " " }
o.ignorecase = true
o.smartcase = true
o.mouse = "a"

-- Folds
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldcolumn = "0"
vim.opt.foldtext = ""
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldnestmax = 4

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

-- Disable some default providers
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

-- Netrw options
g.netrw_banner = 0
g.netrw_keepdir = 0
g.netrw_menu = 0
g.netrw_winsize = 20
g.loaded_netrwPlugin = 1
g.loaded_netrw = 1
