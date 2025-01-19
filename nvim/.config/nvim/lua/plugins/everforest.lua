return {
  "neanias/everforest-nvim",
  version = false,
  lazy = false,
  priority = 1000, -- make sure to load this before all the other start plugins
  -- Optional; default configuration will be used if setup isn't called.
  config = function()
    require("everforest").setup({
      background = "medium",
      on_highlights = function(hl, palette)
        hl.BufferLineFill = { bg = palette.bg0 }
      end
    })
  end,
}
