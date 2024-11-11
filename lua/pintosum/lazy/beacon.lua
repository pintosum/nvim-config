return {
  'danilamihailov/beacon.nvim',
  config = function()
    require("beacon").setup({
      speed = 2,
      winblend = 50,
      highlight = { bg = '#92E3BC', fg = '#92E3BC' },
    })
  end,
}
