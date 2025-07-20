return {
	"mason-org/mason-lspconfig.nvim",
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"neovim/nvim-lspconfig",
		"ray-x/lsp_signature.nvim",
	},
	config = function()
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"html",
				"emmet_ls",
				"cssls",
				"tailwindcss",
				"templ",
				"ts_ls",
				"lua_ls",
				"gopls",
				"bashls",
				"vue_ls",
			},
		})

		local server_settings = {
			ts_ls = {
				"ts_ls",
				{
					init_options = {
						plugins = {
							{
								name = "@vue/typescript-plugin",
								location = vim.fn.stdpath("data")
									.. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
								languages = { "vue" },
							},
						},
					},
					filetypes = {
						"vue",
					},
				},
			},
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
			tailwindcss = {
				"tailwindcss",
				{
					filetypes = { "templ" },
				},
			},
		}

		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		-- local lsp_signature = require("lsp_signature")

		-- Templ formatting
		local custom_format = function()
			if vim.bo.filetype == "templ" then
				local bufnr = vim.api.nvim_get_current_buf()
				local filename = vim.api.nvim_buf_get_name(bufnr)
				local cmd = "templ fmt " .. vim.fn.shellescape(filename)

				vim.fn.jobstart(cmd, {
					on_exit = function()
						-- Reload the buffer only if it's still the current buffer
						if vim.api.nvim_get_current_buf() == bufnr then
							vim.cmd("e!")
						end
					end,
				})
			else
				vim.lsp.buf.format()
			end
		end

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
			map("<leader>lf", custom_format, "Format buffer")
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
