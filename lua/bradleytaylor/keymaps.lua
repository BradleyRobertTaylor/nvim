vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local set = require('bradleytaylor.utils').keymap
local cmd = require('bradleytaylor.utils').cmd

-- cursor settings
set('n', 'J', 'mzJ`z') -- keep cursor in place when appending next line
set('n', '<C-d>', '<C-d>zz') -- keep cursor in the middle when jumping by page
set('n', '<C-u>', '<C-u>zz') -- keep cursor in the middle when jumping by page
set('n', 'n', 'nzzzv') -- keep search terms in the middle
set('n', 'N', 'Nzzzv') -- keep search terms in the middle

-- clipboard settings
set('x', '<leader>p', [["_dP]]) -- paste over without losing current register
set({ 'n', 'v' }, '<leader>y', [["+y]]) -- yank to system clipboard
set('n', '<leader>Y', [["+Y]]) -- yank to system clipboard
set({ 'n', 'v' }, '<leader>d', [["_d]]) -- delete to void register
set('n', 'x', '"_x') -- delete single character without copying into register

-- toggle word wrap
set('n', '<leader>ww', cmd 'set wrap!', 'Toggle word wrap')

set('n', 'H', '^', 'Move to first character')
set('n', 'L', '$', 'Move to last character')

vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true })

-- quickfix list commands
set('n', ']q', vim.cmd.cnext, 'Next quickfix')
set('n', '[q', vim.cmd.cprevious, 'Previous quickfix')

-- gives control c all behaviors of escape
set('i', '<C-c>', '<Esc>')

-- set('n', '<leader>x', '<cmd>.lua<CR>', 'Execute the current line')
-- set('n', '<leader><leader>x', '<cmd>source %<CR>', 'Execute the current file')
