return {
	"mason-org/mason-lspconfig.nvim",
	dependencies = {
		"mason-org/mason.nvim",
		"neovim/nvim-lspconfig",
	},
	config = function()
		require("mason").setup()
		require("mason-lspconfig").setup({

			automatic_enable = {
				exclude = { "jdtls" },
			},

			ensure_installed = {
				"html",
				"emmet_ls",
				"cssls",
				"tailwindcss",
				"ts_ls",
				"lua_ls",
			},
		})

		local servers = {
			-- HTML
			html = {},

			-- Typescript
			ts_ls = {},

			-- Lua
			lua_ls = {
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
					},
				},
			},

			-- CSS
			cssls = {
				settings = {
					css = {
						lint = {
							unknownAtRules = "ignore",
						},
					},
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
			map("gr", require("telescope.builtin").lsp_references, "Goto references")
			map("K", vim.lsp.buf.hover, "Hover documentation")
			map("<leader>la", vim.lsp.buf.code_action, "Code action")
			map("<leader>ld", vim.diagnostic.setqflist, "List diagnostics")
			map("<leader>lf", vim.lsp.buf.format, "Format buffer")
			map("<leader>li", "<cmd>LspInfo<cr>", "LSP information")
			map("<leader>lr", vim.lsp.buf.rename, "Rename current symbol")
			map("<leader>ls", require("telescope.builtin").lsp_document_symbols, "Search document symbols")
			map("<leader>lw", require("telescope.builtin").lsp_workspace_symbols, "Search workspace symbols")
			map("[d", "<cmd>lua vim.diagnostic.jump({ count = 1, float = true })<cr>", "Next diagnostic")
			map("]d", "<cmd>lua vim.diagnostic.jump({ count = -1, float = true })<cr>", "Previous diagnostic")
		end

		for name, config in pairs(servers) do
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
