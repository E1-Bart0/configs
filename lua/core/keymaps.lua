vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local keymap = vim.keymap

-- Navigate vim panes better
-- keymap.set('n', '<C-k>', '<cmd>TmuxNavigatorUp<CR>')
-- keymap.set('n', '<C-j>', '<cmd>TmuxNavigatorDown<CR>')
-- keymap.set('n', '<C-h>', '<cmd>TmuxNavigatorRight<CR>')
-- keymap.set('n', '<C-l>', '<cmd>TmuxNavigatorLeft<CR>')

keymap.set('n', '<leader>nh', ':nohlsearch<CR>')
keymap.set('n', 'x', '"_x')

keymap.set('n', '<leader>+', '<C-a>') -- Increment number
keymap.set('n', '<leader>-', '<C-x>') -- Decrement number

-- Splitting windows
keymap.set('n', '<leader>sv', '<C-w>v')     -- Split window vertically
keymap.set('n', '<leader>sh', '<C-w>s')     -- Split window horizontally
keymap.set('n', '<leader>se', '<C-w>=')     -- Make split window equal width
keymap.set('n', '<leader>sq', ':close<CR>') -- Close current split window
