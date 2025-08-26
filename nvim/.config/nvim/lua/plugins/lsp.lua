return {
	"mason-org/mason-lspconfig.nvim",
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"neovim/nvim-lspconfig",
	},
	config = function()
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"html",
				"emmet_ls",
				"cssls",
				"tailwindcss",
				"ts_ls",
				"lua_ls",
				"gopls",
				"bashls",
			},
		})

		local server_settings = {
			ts_ls = {},
			lua_ls = {
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
					},
				},
			},
			gopls = {
				settings = {
					gofumpt = true,
				},
			},
		}

		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		local on_attach = function(_, bufnr)
			vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

			-- LSP Mappings
			local map = function(keys, func, desc)
				if desc then
					desc = "LSP: " .. desc
				end
				vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
			end
			map("gd", vim.lsp.buf.definition, "Goto definition")
			map("gD", vim.lsp.buf.declaration, "Goto declaration")
			map("<leader>gr", require("telescope.builtin").lsp_references, "Search references")
			map("gI", vim.lsp.buf.implementation, "Goto implementation")
			map("gT", vim.lsp.buf.type_definition, "Type definition")
			map("K", vim.lsp.buf.hover, "Hover documentation")
			map("<leader>la", vim.lsp.buf.code_action, "Code action")
			map("<leader>ld", vim.diagnostic.setqflist, "List diagnostics")
			map("<leader>li", "<cmd>LspInfo<cr>", "LSP information")
			map(
				"<leader>lih",
				"<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<cr>",
				"Toggle inlay hints"
			)
			map("<leader>lr", vim.lsp.buf.rename, "Rename current symbol")
			map("<leader>ls", require("telescope.builtin").lsp_document_symbols, "Search document symbols")
			map("<leader>lw", require("telescope.builtin").lsp_workspace_symbols, "Search workspace symbols")
			map("[d", vim.diagnostic.goto_prev, "Previous diagnostic")
			map("]d", vim.diagnostic.goto_next, "Next diagnostic")
		end

		for name, config in pairs(server_settings) do
			config.on_attach = on_attach
			config.capabilities = capabilities
			vim.lsp.config[name] = config
		end

		local x = vim.diagnostic.severity

		local config = {
			severity_sort = true,
			virtual_text = { prefix = "" },
			signs = { text = { [x.ERROR] = "󰅙", [x.WARN] = "", [x.INFO] = "󰋼", [x.HINT] = "󰌵" } },
			underline = true,
		}

		vim.diagnostic.config(config)
	end, -- config end
}
