return {
  "rebelot/kanagawa.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("kanagawa").setup({
      theme = "lotus",
      overrides = function(colors)
        return {
          BufferLineFill = { bg = colors.palette.sumiInk3 },
          LineNr = { bg = colors.palette.sumiInk2 },
          SignColumn = { bg = colors.palette.sumiInk2 },
        }
      end
    })
    -- vim.cmd("colorscheme kanagawa")
  end,
}
