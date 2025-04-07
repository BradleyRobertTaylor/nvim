return {
  'anuvyklack/windows.nvim',
  dependencies = { 'anuvyklack/middleclass' },
  config = function()
    require('windows').setup {
      autowidth = {
        enable = false,
      },
      animation = {
        enable = false,
      },
    }

    local set = require('bradleytaylor.utils').keymap

    set('n', '<C-w>m', vim.cmd.WindowsMaximize, 'Toggle window maximizer')
  end,
}
