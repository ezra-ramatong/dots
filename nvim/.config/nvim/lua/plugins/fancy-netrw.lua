return	{
  "prichrd/netrw.nvim",
  event = { "BufEnter" },
  config = function()
    require("netrw").setup({})
  end,
}

