vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Navigate vim panes better
-- keymap.set('n', '<C-k>', '<cmd>TmuxNavigatorUp<CR>')
-- keymap.set('n', '<C-j>', '<cmd>TmuxNavigatorDown<CR>')
-- keymap.set('n', '<C-h>', '<cmd>TmuxNavigatorRight<CR>')
-- keymap.set('n', '<C-l>', '<cmd>TmuxNavigatorLeft<CR>')

local wk = require("which-key")

wk.register {
  x = { '"_x', "Not save in clipboard" },
  ["<leader>+"] = { "<C-a>", "Increment number" },
  ["<leader>-"] = { "<C-x>", "Decrement number" },
  ["<leader>nh"] = { ":nohlsearch<CR>", "Clear highlights" },
}

-- Splitting windows
wk.register({
  s = {
    name = "Split Window",
    v = { "<C-w>v", "Split window vertically" },
    h = { "<C-w>s", "Split window horizontally" },
    e = { "<C-w>=", "Make split window equal width" },
    q = { ":close<CR>", "Close current split window" },
  },
}, { prefix = "<leader>" })
