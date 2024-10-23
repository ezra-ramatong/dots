return{
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", opt = true },
  event = "VeryLazy",
  config = function()
    -- local custom_catppuccin = require("lualine.themes.catppuccin-frappe")
    -- custom_catppuccin.normal.c.bg = "#303446"
    require("lualine").setup({
      options = {
        disabled_filetypes = { "dashboard", "NvimTree", "Outline" },
        ignore_focus = { "dashboard", "NvimTree", "Outline", "undotree", "netrw" },
        icons_enabled = true,
        component_separators = "",
        section_separators = "",
        -- theme = custom_catppuccin,
      },
      sections = {
        lualine_c = { " " },
        lualine_x = { " " },
        lualine_y = {
          { "filetype", icon_only = false, separator = "", padding = { left = 1, right = 0 } },
          "progress",
        },
      },
      -- tabline = {
      -- 	lualine_c = {
      -- 		{
      -- 			"buffers",
      -- 			show_filename_only = true, -- Shows shortened relative path when set to false.
      -- 			hide_filename_extension = false, -- Hide filename extension when set to true.
      -- 			show_modified_status = true, -- Shows indicator when the buffer is modified.
      --
      -- 			mode = 0, -- 0: Shows buffer name
      -- 			-- 1: Shows buffer index
      -- 			-- 2: Shows buffer name + buffer index
      -- 			-- 3: Shows buffer number
      -- 			-- 4: Shows buffer name + buffer number
      --
      -- 			-- it can also be a function that returns
      -- 			-- the value of `max_length` dynamically.
      -- 			filetype_names = {
      -- 				TelescopePrompt = "Telescope",
      -- 				dashboard = "Dashboard",
      -- 				packer = "Packer",
      -- 				fzf = "FZF",
      -- 				alpha = "Alpha",
      -- 				NvimTree = "File Explorer",
      -- 			}, -- Shows specific buffer name for that filetype ( { `filetype` = `buffer_name`, ... } )
      --
      -- 			-- Automatically updates active buffer color to match color of other components (will be overidden if buffers_color is set)
      -- 			use_mode_colors = false,
      --
      -- 			symbols = {
      -- 				modified = " ●", -- Text to show when the buffer is modified
      -- 				alternate_file = "", -- Text to show to identify the alternate file
      -- 				directory = "", -- Text to show when the buffer is a directory
      -- 			},
      -- 		},
      -- 	},
      -- 	lualine_a = { "" },
      -- },
    })
  end,
}
