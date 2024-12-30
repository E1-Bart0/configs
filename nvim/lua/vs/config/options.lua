-- tabs & indentation
vim.opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
vim.opt.shiftwidth = 2 -- 2 spaces for indent width
vim.opt.expandtab = true -- expand tab to spaces
vim.opt.autoindent = true -- copy indent from current line when starting new one

-- line wrapping
vim.opt.wrap = false -- disable line wrapping

-- Vertical Line
vim.opt.colorcolumn = "100"

-- search settings
vim.opt.ignorecase = true -- ignore case when searching
vim.opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitiv

-- cursor line
vim.opt.cursorline = true -- highlight the current cursor line

vim.cmd([[ set noswapfile ]])

-- backspace
vim.opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- Line numbers
vim.wo.relativenumber = true -- show relative line numbers
vim.wo.number = true -- shows absolute line number on cursor line (when relative number is on)

-- clipboard
vim.opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- autoread
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})

-- split windows
vim.opt.splitright = true -- split vertical window to the right
vim.opt.splitbelow = true -- split horizontal window to the bottom

vim.opt.iskeyword:append("-") -- consider string-string as whole word

-- UndoTree plugin
vim.o.undofile = true -- Keep undo between sessions

-- which-key plugin
vim.o.timeout = true
vim.o.timeoutlen = 300
