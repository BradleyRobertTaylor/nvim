return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require('harpoon'):setup {}
    local keymap = require('bradleytaylor.utils').keymap

    keymap('n', '<leader>a', function()
      harpoon:list():add()
    end, 'Add file to Harpoon list')

    keymap('n', '<leader>h', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, 'Toggle Harpoon list')

    for i = 1, 9 do
      keymap('n', string.format('<space>%d', i), function()
        harpoon:list():select(i)
      end, string.format('Go to Harpoon List %s', i))
    end
  end,
}
