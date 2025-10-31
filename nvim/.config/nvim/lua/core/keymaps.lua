local map = vim.keymap.set

map("", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "

--- Essentials ---

map("i", "jk", "<ESC>", { silent = true })
map("n", "<leader>w", ":w<cr>")
map("n", "<leader>wa", ":wall<cr>")
map("n", "<leader>q", ":close<cr>", { desc = "Close window" })
map("n", "<leader>qq", ":confirm qall<cr>", { desc = "Quit vim" })
map("n", "<leader>c", ":bd!<cr>", { desc = "Kill buffer" })
map("n", "<ESC>", ":noh<cr>")
map("t", "<leader>z", "<C-\\><C-n>")
map("n", "<leader>vs", "<cmd>tabnew | term code .<CR>", { desc = "Open VSCode in Current Project" })

--- Editing ---

-- Move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move line dbdown (normal)" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move line up (normal)" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move line down (insert)" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move line up (insert)" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move line down (visual)" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move line up (visual)" })

-- Yanking
map("n", "<leader>y", '"+y')
map("v", "<leader>y", '"+y')
map("n", "<leader>Y", '"+Y')
map("n", "<leader>yf", "<cmd>%y+<CR>", { desc = "Yank file to system clipboard" })

-- Pasting
map("n", "<leader>p", '"+p', { desc = "Paste from system clipboard (Normal Mode)" })
map("v", "<leader>p", '"+p', { desc = "Paste from system clipboard (Visual Mode)" })
map("n", "<leader>P", '"+P', { desc = "Paste before cursor from system clipboard" })

--- Navigation ---

-- Window Navigation
map("n", "<C-h>", "<C-w>h", { silent = true, desc = "Left window navigation" })
map("n", "<C-j>", "<C-w>j", { silent = true, desc = "Down window navigation" })
map("n", "<C-k>", "<C-w>k", { silent = true, desc = "Up window navigation" })
map("n", "<C-l>", "<C-w>l", { silent = true, desc = "Right window navigation" })
map("n", "<leader>d", "<C-w>d", { silent = true, desc = "Right window navigation" })

-- Tab Navigation
map("n", "<leader>i", ":tabN<cr>", { desc = "Previous tab" })
map("n", "<leader>o", ":tabn<cr>", { desc = "Next tab" })
map("n", "<leader>te", ":tabe<cr>", { desc = "New tab" })

-- Quickfix List Navigation
map("n", "<leader>n", "<cmd>cnext<cr>zz", { desc = "Forward quickfix list" })
map("n", "<leader>nn", "<cmd>cprev<cr>zz", { desc = "Backward quickfix list" })
map("n", "<leader>cc", "<cmd>cclose<cr>zz", { desc = "Close quickfix window" })

--- Plugin Specific ---

-- Terminal
map("n", "<leader>t", ":tabnew | :term<cr>")
map("n", "<leader>tt", ":hor term<cr>")
map("n", "<leader>v", ":55vsp | term<cr>")

-- Git
map("n", "<leader>gb", "<cmd>Git blame<cr>", { desc = "Git blame" })
map("n", "<leader>gbl", "<cmd>Git blame_line<cr>", { desc = "Git blame" })

-- Oil (File Explorer)
map("n", "<leader>e", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })

-- Telescope
map("n", "<leader>f", "<cmd>Telescope live_grep<cr>", { desc = "Find word in workspace" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find command history" })
map("n", "<leader>fc", "<cmd>Telescope commands<cr>", { desc = "Find command history" })
map("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", { desc = "Find workspace diagnostics" })
map("n", "<leader>ff", "<cmd>Telescope find_files hidden=true <cr>", { desc = "Find all files" })
map("n", "<leader>fg", "<cmd>Telescope git_files show_untracked=true<cr>", { desc = "Find git files" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Find Help" })
map("n", "<leader>fi", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Find in buffer" })
map("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Keymaps" })
map("n", "<leader>fm", "<cmd>Telescope man_pages<cr>", { desc = "Find Man Pages" })
map("n", "<leader>fr", "<cmd>Telescope resume<cr>", { desc = "Find command history" })
map("n", "<leader>fs", "<cmd>Telescope search_history<cr>", { desc = "Find command history" })
