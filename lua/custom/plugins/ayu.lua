return {
  {
    'Shatur/neovim-ayu',
    name = 'ayu',
    priority = 1000,
    config = function()
      require('ayu').setup {}
      vim.cmd 'colorscheme ayu'
    end,
  },
}
