return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-ui-select.nvim' },
  },
  config = function()
    require('telescope').setup {
      defaults = {
        sorting_strategy = 'ascending',
        layout_config = {
          horizontal = {
            prompt_position = 'top',
          },
        },
      },
      -- pickers = {
      --   find_files = {
      --     hidden = true,
      --   },
      -- },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }

    require('telescope').load_extension 'ui-select'
    require('telescope').load_extension 'fzf'

    local keymap = require('bradleytaylor.utils').keymap
    local builtin = require 'telescope.builtin'

    keymap('n', '<leader>dl', builtin.diagnostics, 'Show diagnostics list')
    keymap('n', '<leader>sh', builtin.help_tags, 'Search help')
    keymap('n', '<leader>sk', builtin.keymaps, 'Search keymaps')
    keymap('n', '<C-p>', builtin.find_files, 'Search all files')
    keymap('n', '<leader>sw', builtin.grep_string, 'Search word under cursor')
    keymap('n', '<leader>fg', builtin.live_grep, 'Grep all files')
    keymap('n', '<leader><leader>', builtin.buffers, 'Search existing buffers')
    keymap('n', '<space>en', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, 'Search config files')
  end,
}
