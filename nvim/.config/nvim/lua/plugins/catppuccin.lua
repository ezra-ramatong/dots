return {
  "catppuccin/nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      highlight_overrides = {
        latte = function(latte)
          return {
            BufferLineFill = { bg = latte.base },
          }
        end,
      },
    })
    -- vim.cmd([[colorscheme catppuccin-latte]])
  end,
}
