local telescope = require('telescope')
telescope.setup()
telescope.load_extension("fzf")
telescope.load_extension("yank_history")

local builtin = require('telescope.builtin')


vim.keymap.set('n', 'ff', builtin.find_files, {})
vim.keymap.set('n', 'ft', builtin.live_grep, {})
vim.keymap.set('n', '<Space><Space>', builtin.oldfiles, {})
vim.keymap.set('n', '<Space>fg', builtin.live_grep, {})
vim.keymap.set('n', '<Space>fh', builtin.help_tags, {})

vim.keymap.set('n', 'yh', "<cmd>Telescope yank_history<CR>", {})
vim.keymap.set('n', '<leader>ss', "<cmd>Telescope spell_suggest<CR>", {})
