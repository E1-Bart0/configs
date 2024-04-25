local wk = require("which-key")

wk.register({
  v = {
    name = "Vimux",
    o = { "<cmd>VimuxOpenRunner<CR>", "Open tmux runner" },
    r = { "<cmd>VimuxPromptCommand<CR>", "Prompt a command to run" },
    l = { "<cmd>VimuxRunLastCommand<CR>", "Run last command" },
    i = { "<cmd>VimuxInspectRunner<CR>", "Inspect runner pane" },
    q = { "<cmd>VimuxCloseRunner<CR>", "Close tmux runner" },
    x = { "<cmd>VimuxInterruptRunner<CR>", "Interrupt command in the runner" },
    z = { "<cmd>VimuxZoomRunner<CR>", "Zoom" },
    cl = { "<cmd>VimuxClearTerminalScreen<CR>", "Clear the terminal screen" },
  },
}, { prefix = "<leader>" })
