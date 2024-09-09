return {
  {
    'tpope/vim-eunuch',
    config = function()
      vim.cmd 'cnoreabbrev rename Rename'
    end,
  },
}
