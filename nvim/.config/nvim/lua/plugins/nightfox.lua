return {
  "EdenEast/nightfox.nvim",
  config = function()
    local config = require("nightfox")
    config.setup({
      options = {
        transparent = false,     -- Disable setting background
        terminal_colors = true,  -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
        dim_inactive = false,    -- Non focused panes set to alternative background
        module_default = true,   -- Default enable value for modules
        colorblind = {
          enable = false,        -- Enable colorblind support
          simulate_only = false, -- Only show simulated colorblind colors and not diff shifted
          severity = {
            protan = 0,          -- Severity [0,1] for protan (red)
            deutan = 0,          -- Severity [0,1] for deutan (green)
            tritan = 0,          -- Severity [0,1] for tritan (blue)
          },
        },
        inverse = { -- Inverse highlight for different types
          match_paren = false,
          visual = false,
          search = false,
        },
      },
      groups = {
        -- BufferLineFill = { bg = "base" }
      },
    })

    -- setup must be called before loading
    -- vim.cmd("colorscheme dayfox")
  end
}
