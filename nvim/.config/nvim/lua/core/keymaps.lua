local map = vim.keymap.set

-- Set space as leader key
map("", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "

-- Standard
map("i", "jk", "<ESC>", { silent = true, desc = "Exit insert mode" })
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
map("n", "<leader>q", "<cmd>confirm q<cr>", { silent = true, desc = "Quit" })
map("n", "<leader>x", "<cmd>close<cr>", { silent = true, desc = "Close" })
map("n", "<leader>yf", "<cmd>%y+<CR>", { desc = "Yank file to system clipboard" })
map("n", "<leader>ygg", '"+ygg', { desc = "Yank file to system clipboard" })
map("n", "<space><space>x", "<cmd>source %<cr>", { desc = "Source current file" })
map("n", "<space>x", "<cmd>.lua<cr>", { desc = "Lua - Execute current line" })
map("v", "<space>x", ":lua<cr>", { desc = "Lua - Visually Higlighted Line(s)" })

-- Move lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move line dbdown (normal)" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move line up (normal)" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move line down (insert)" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move line up (insert)" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move line down (visual)" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move line up (visual)" })

-- Window navigation
map("n", "<C-h>", "<C-w>h", { silent = true, desc = "Left window navigation" })
map("n", "<C-j>", "<C-w>j", { silent = true, desc = "Down window navigation" })
map("n", "<C-k>", "<C-w>k", { silent = true, desc = "Up window navigation" })
map("n", "<c-l>", "<c-w>l", { silent = true, desc = "Right window navigation" })

-- Make Window Bigger
map("n", "<leader>wb", "<C-w>o", { silent = true, desc = "Make Window Bigger" })

-- Yank to system clipboard
map("n", "<leader>y", '"+y')
map("v", "<leader>y", '"+y')
map("n", "<leader>Y", '"+Y')

-- Paste from system clipboard
map("n", "<leader>p", '"+p')
map("v", "<leader>p", '"+p')
map("n", "<leader>P", '"+P')

--[[ -- Netrw
map("n", "<leader>e", "<cmd>Lex<cr>", { desc = "Open Netrw" })
map("n", "<leader>ef", "<cmd>Lex %:p:h<cr>", { desc = "Open Netrw in directory of current file" }) ]]

-- Oil (File Explorer)
map("n", "<leader>e", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })

-- Navigate buffers
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>bs", "<cmd>BufferLinePick<cr>", { desc = "Pick buffer" })

-- Close buffer
map("n", "<leader>bc", "<cmd>bdelete!<cr>", { desc = "Buffer Close" })
map("n", "<leader>bcc", "<cmd>BufferLinePickClose<cr>", { desc = "BufferLine Pick Close" })
map("n", "<leader>bco", "<cmd>BufferLineCloseOthers<cr>", { desc = "BufferLine Close Others" })

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files hidden=true no_ignore=true<cr>", { desc = "Find all files" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Find Help" })
map("n", "<leader>fm", "<cmd>Telescope man_pages<cr>", { desc = "Find Man Pages" })
map("n", "<leader>fi", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Find in buffer" })
map("n", "<leader>fw", "<cmd>Telescope live_grep<cr>", { desc = "Find word in workspace" })
map("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Keymaps" })
map("n", "<leader>fg", "<cmd>Telescope git_files show_untracked=true<cr>", { desc = "Find git files" })
map("n", "<leader>fc", "<cmd>Telescope commands<cr>", { desc = "Find command history" })
map("n", "<leader>tc", "<cmd>Telescope colorscheme<cr>", { desc = "Select colorscheme" })

-- Quickfix list navigation
map("n", "<leader>j", "<cmd>cnext<cr>zz", { desc = "Forward quickfix list" })
map("n", "<leader>k", "<cmd>cprev<cr>zz", { desc = "Backward quickfix list" })
map("n", "<leader>cc", "<cmd>cclose<cr>zz", { desc = "Close quickfix window" })

-- Lazy (package manager)
map("n", "<leader>lz", "<cmd>Lazy<cr>", { desc = "Open Lazy" })

-- Mason (Editor tooling manager)
map("n", "<leader>ma", "<cmd>Mason<cr>", { desc = "Open Mason" })

-- Git
map("n", "<leader>gc", "<cmd>Telescope git_commits show_untracked=true<cr>", { desc = "Git commits" })
map("n", "<leader>gbc", "<cmd>Telescope git_bcommits<cr>", { desc = "Git commits for current buffer" })
map("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", { desc = "Git Branches" })
map("n", "<leader>gbl", "<cmd>Git blame<cr>", { desc = "Git blame/Git blame range" })
map("n", "<leader>gcl", "<cmd>Gclog<cr>", { desc = "Git log" })
map("n", "<leader>gd", "<cmd>Gdiffsplit<cr>", { desc = "Git diff" })
map("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "Git status" })
map("n", "<leader>gp", "<cmd>Git push<cr>", { desc = "Git push" })
map("n", "<leader>g", "<cmd>G<cr>", { desc = "Git fugitive" })

-- DAP
map("n", "<leader>db", "<cmd>DapToggleBreakpoint<cr>", { desc = "Add breakpoint at line" })
map("n", "<leader>dr", "<cmd>DapContinue<cr>", { desc = "Start or continue the debugger" })

-- Compile C++ files
--[[ map(
	"n",
	"<leader>cc",
	":!g++ -std=c++20 -Wall -Wextra -Wpedantic -Wshadow -g % -o %:r && ./%:r<CR>",
	{ desc = "Compile C++ File", noremap = true, silent = true }
) ]]
map("n", "<leader>m", ":make -C build<CR>", { desc = "Make", noremap = true, silent = true })
map("n", "<leader>mr", ":make run -C build<CR>", { desc = "Make run", noremap = true, silent = true })
map("n", "<leader>mc", ":make clean -C build<CR>", { desc = "Make clean", noremap = true, silent = true })

-- NPM
map("n", "<leader>nf", "<cmd>!npm run format<cr>", { desc = "npm run format" })
map("n", "<leader>nl", "<cmd>!npm run lint<cr>", { desc = "npm run lint" })
map("n", "<leader>nt", "<cmd>!npm test<cr>", { desc = "npm test" })
map("n", "<leader>nb", "<cmd>!npm run build<cr>", { desc = "npm run build" })
map("n", "<leader>nr", "<cmd>!node %<cr>", { desc = "Run current script with Node" })

-- Go
map("n", "<leader>gor", "<cmd>!go run %<cr>", { desc = "Run current Go file" })
map("n", "<leader>gob", "<cmd>!go build %<cr>", { desc = "Build current Go file" })
map("n", "<leader>got", "<cmd>!go test<cr>", { desc = "Go test" })

-- CodeCompanion
map("n", "<leader>cct", "<cmd>CodeCompanionChat toggle<cr>", { desc = "CodeCompanionChat Toggle" })
map("n", "<leader>cc", "<cmd>CodeCompanionChat<cr>", { desc = "CodeCompanionChat" })
map("n", "<leader>cco", "<cmd>CodeCompanionChat ollama<cr>", { desc = "CodeCompanionChat using Ollama" })
map("n", "<leader>cca", "<cmd>CodeCompanionActions<cr>", { desc = "CodeCompanionActions" })
