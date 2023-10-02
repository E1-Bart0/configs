local keymap = vim.keymap
keymap.set("n", "<leader>v", "<cmd>VimuxOpenRunner<CR>")


-- Prompt for a command to run
keymap.set("n", "<leader>vp", "<cmd>VimuxPromptCommand<CR>")

-- Run last command executed by VimuxRunCommand
keymap.set("n", "<leader>vl", "<cmd>VimuxRunLastCommand<CR>")

-- Inspect runner pane
keymap.set("n", "<leader>vi", "<cmd>VimuxInspectRunner<CR>")

-- Close vim tmux runner opened by VimuxRunCommand
keymap.set("n", "<leader>vq", "<cmd>VimuxCloseRunner<CR>")

-- Interrupt any command running in the runner pane
keymap.set("n", "<leader>vx", "<cmd>VimuxInterruptRunner<CR>")

-- Zoom the runner pane (use <bind-key> z to restore runner pane)
keymap.set("n", "<leader>vz", "<cmd>VimuxZoomRunner<CR>")

-- Clear the terminal screen of the runner pane.
keymap.set("n", "<leader>vcl", "<cmd>VimuxClearTerminalScreen<CR>")
