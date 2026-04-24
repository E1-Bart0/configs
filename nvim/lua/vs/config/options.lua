-- ============================================================================
-- VS CODE INTEGRATION
-- ============================================================================
vim.notify = require("vscode").notify

-- ============================================================================
-- INDENTATION (Aligned with VS Code: 2 spaces)
-- ============================================================================
vim.opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
vim.opt.shiftwidth = 2 -- 2 spaces for indent width
vim.opt.expandtab = true -- expand tab to spaces
vim.opt.autoindent = true -- copy indent from current line when starting new one

-- ============================================================================
-- LINE WRAPPING (Aligned with VS Code: disabled)
-- ============================================================================
vim.opt.wrap = false -- disable line wrapping

-- ============================================================================
-- VISUAL GUIDES
-- ============================================================================
vim.opt.colorcolumn = "100" -- Matches VS Code ruler at 100

-- ============================================================================
-- SEARCH SETTINGS
-- ============================================================================
vim.opt.ignorecase = true -- ignore case when searching
vim.opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- ============================================================================
-- CURSOR & LINE NUMBERS
-- ============================================================================
vim.opt.cursorline = true -- highlight the current cursor line
vim.wo.relativenumber = true -- show relative line numbers
vim.wo.number = true -- shows absolute line number on cursor line (hybrid mode)

-- ============================================================================
-- FILE HANDLING
-- ============================================================================
vim.cmd([[ set noswapfile ]])
vim.opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- Auto-reload files when changed externally
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})

-- ============================================================================
-- CLIPBOARD
-- ============================================================================
vim.opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- ============================================================================
-- WINDOW SPLITS
-- ============================================================================
vim.opt.splitright = true -- split vertical window to the right
vim.opt.splitbelow = true -- split horizontal window to the bottom

-- ============================================================================
-- WORD BOUNDARIES
-- ============================================================================
vim.opt.iskeyword:append("-") -- treat kebab-case as one word

-- ============================================================================
-- UNDO PERSISTENCE
-- ============================================================================
vim.o.undofile = true -- Keep undo history between sessions

-- ============================================================================
-- WHICH-KEY PLUGIN
-- ============================================================================
vim.o.timeout = true
vim.o.timeoutlen = 300
