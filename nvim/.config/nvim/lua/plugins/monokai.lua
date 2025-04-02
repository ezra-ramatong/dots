return {
  "loctvl842/monokai-pro.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("monokai-pro").setup({
      styles = {
        comment = { italic = false },
        keyword = { italic = false },       -- any other keyword
        type = { italic = false },          -- (preferred) int, long, char, etc
        storageclass = { italic = false },  -- static, register, volatile, etc
        structure = { italic = false },     -- struct, union, enum, etc
        parameter = { italic = false },     -- parameter pass in function
        annotation = { italic = false },
        tag_attribute = { italic = false }, -- attribute of tag in reactjs
      },
      override = function(c)
        return {
          --[[ BufferLineFill = { bg = "#000000" },
          FloatBorder = { fg = "#000000", bg = "#000000" },
          Pmenu = { bg = "#000000", fg = "#000000" },
          NormalFloat = { bg = "#000000", fg = "#000000" }, ]]
          IndentBlanklineChar = { fg = c.base.dimmed4 },
          NeoTreeStatusLine = { link = "StatusLine" },
        }
      end,
      overridePalette = function(filter)
        return {
          --     dark2 = "#101014",
          --     dark1 = "#16161E",
          -- background = "#000000",
          --     text = "#C0CAF5",
          --     accent1 = "#f7768e",
          --     accent2 = "#7aa2f7",
          --     accent3 = "#e0af68",
          --     accent4 = "#9ece6a",
          --     accent5 = "#0DB9D7",
          --     accent6 = "#9d7cd8",
          --     dimmed1 = "#737aa2",
          --     dimmed2 = "#787c99",
          --     dimmed3 = "#363b54",
          --     dimmed4 = "#363b54",
          --     dimmed5 = "#16161e",
        }
      end,
    })
    -- vim.cmd([[colorscheme monokai-pro]])
  end,
}
