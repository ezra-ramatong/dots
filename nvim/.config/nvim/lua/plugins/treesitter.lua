return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufRead", "BufNewFile" },
	build = function()
		require("nvim-treesitter.install").update({ with_sync = true })()
	end,
	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			ensure_installed = {
				-- Mandatory
				"c",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"markdown",
				"markdown_inline",
				-- Mine
				"json",
				"javascript",
			},
			auto_install = false,
			sync_install = false,
			highlight = { enable = true },
			incremental_selection = { enable = true },
			indent = { enable = true, disable = { "html", "css" } },

			vim.treesitter.language.register("markdown", "mdx"),
		})
	end,
}
