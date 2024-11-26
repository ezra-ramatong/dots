return {
	"neovim/nvim-lspconfig",
	lazy = true,
	config = function()
		-- Servers
		local servers = {
			lua_ls = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
			cssls = {},
			html = {},
			emmet_ls = {},
			ts_ls = {},
			gopls = {
				gofumpt = true,
			},
			clangd = {},
			pylsp = {},
		}

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

		-- LSP Mappings
		local on_attach = function(_, bufnr)
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
			map("<leader>lf", vim.lsp.buf.format, "Format buffer")
			map("<leader>li", "<cmd>LspInfo<cr>", "LSP information")
			map("<leader>lr", vim.lsp.buf.rename, "Rename current symbol")
			map("<leader>ls", require("telescope.builtin").lsp_document_symbols, "Search document symbols")
			map("<leader>lw", require("telescope.builtin").lsp_workspace_symbols, "Search workspace symbols")
			map("[d", vim.diagnostic.goto_prev, "Previous diagnostic")
			map("]d", vim.diagnostic.goto_next, "Next diagnostic")
		end

		local mason_lspconfig = require("mason-lspconfig")
		mason_lspconfig.setup({
			ensure_installed = vim.tbl_keys(servers),
		})

		mason_lspconfig.setup_handlers({
			function(server_name)
				require("lspconfig")[server_name].setup({
					capabilities = capabilities,
					on_attach = on_attach,
					settings = servers[server_name],
				})
			end,
		})

		local function border(hl_name)
			return {
				{ "┌", hl_name },
				{ "─", hl_name },
				{ "┐", hl_name },
				{ "│", hl_name },
				{ "┘", hl_name },
				{ "─", hl_name },
				{ "└", hl_name },
				{ "│", hl_name },
			}
		end

		vim.lsp.handlers["textDocument/hover"] =
			vim.lsp.with(vim.lsp.handlers.hover, { border = border("LspInfoBorder") })
		vim.lsp.handlers["textDocument/signatureHelp"] =
			vim.lsp.with(vim.lsp.handlers.signature_help, { border = border("LspInfoBorder") })

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
