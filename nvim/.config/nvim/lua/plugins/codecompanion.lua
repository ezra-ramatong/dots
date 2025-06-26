return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"j-hui/fidget.nvim",
		"ravitemer/codecompanion-history.nvim",
		--[[ {
			"MeanderingProgrammer/render-markdown.nvim",
			ft = { "markdown", "codecompanion" },
		}, ]]
		{
			"OXY2DEV/markview.nvim",
			lazy = false,
			opts = {
				preview = {
					filetypes = { "codecompanion" },
					ignore_buftypes = { "markdown" },
				},
			},
		},
		{
			"echasnovski/mini.diff",
			config = function()
				local diff = require("mini.diff")
				diff.setup({
					-- Disabled by default
					source = diff.gen_source.none(),
				})
			end,
		},
	},
	opts = {
		extensions = {
			history = {
				enabled = true,
				opts = {
					keymap = "gh",
					save_chat_keymap = "sc",
					auto_save = false,
					auto_generate_title = true,
					continue_last_chat = false,
					delete_on_clearing_chat = false,
					picker = "snacks",
					enable_logging = false,
					dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
				},
			},
		},
		adapters = {
			ollama = function()
				return require("codecompanion.adapters").extend("ollama", {
					schema = {
						model = {
							default = "gemma2:2b",
						},
						num_ctx = {
							default = 20000,
						},
					},
				})
			end,
		},
	},
	config = function()
		require("codecompanion").setup({
			strategies = {
				chat = {
					adapter = "copilot",
				},
				inline = {
					adapter = "copilot",
				},
			},
		})
	end,
}
