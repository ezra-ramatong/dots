return {

	-- [Auto pairs]
	{
		"windwp/nvim-autopairs",
		opts = {
			fast_wrap = {},
			disable_filetype = { "TelescopePrompt", "vim" },
		},
		config = function(_, opts)
			require("nvim-autopairs").setup(opts)
		end,
	},

	-- [Auto tagging (Markup languages i.e HTML, JSX (eww))]
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},

	-- [Comments]
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},

	-- [Auto completions]
	{
		"saghen/blink.cmp",
		dependencies = { "rafamadriz/friendly-snippets" },
		enabled = true,
		version = "1.6.0",
		opts = {
			keymap = { preset = "enter" },
			signature = { enabled = false },
			completion = {
				documentation = { auto_show = true, auto_show_delay_ms = 500 },
			},
			sources = {
				default = { "lsp", "path", "snippets" },
			},
		},
	},

	-- [Formatting]
	{
		"stevearc/conform.nvim",
		lazy = false,
		keys = {
			{
				"<leader>fe",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				local disable_filetypes = { c = true, cpp = true }
				return {
					timeout_ms = 500,
					lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
				}
			end,
			formatters_by_ft = {
				javascript = { "prettierd" },
				javascriptreact = { "prettierd" },
				typescript = { "prettierd" },
				lua = { "stylua" },
				markdown = { "prettierd" },
				go = { "gofumpt" },
				html = { "prettierd" },
			},
		},
	},
}
