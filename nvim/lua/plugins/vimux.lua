return {
  {
    "christoomey/vim-tmux-navigator",
    event = "VeryLazy",
  },
  {
    "preservim/vimux",
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")

      wk.add {
        { "<leader>v", group = "Vimux" },
        { "<leader>vcl", "<cmd>VimuxClearTerminalScreen<CR>", desc = "Clear the terminal screen" },
        { "<leader>vi", "<cmd>VimuxInspectRunner<CR>", desc = "Inspect runner pane" },
        { "<leader>vl", "<cmd>VimuxRunLastCommand<CR>", desc = "Run last command" },
        { "<leader>vo", "<cmd>VimuxOpenRunner<CR>", desc = "Open tmux runner" },
        {
          "<leader>vp",
          '<cmd>VimuxRunCommand("clear;python -m " . substitute(substitute(expand("%:.") , "/", ".", "g"), ".py", "", "g"))<CR>',
          desc = "Python run current file",
        },
        { "<leader>vq", "<cmd>VimuxCloseRunner<CR>", desc = "Close tmux runner" },
        { "<leader>vr", "<cmd>VimuxPromptCommand<CR>", desc = "Prompt a command to run" },
        { "<leader>vx", "<cmd>VimuxInterruptRunner<CR>", desc = "Interrupt command in the runner" },
        { "<leader>vz", "<cmd>VimuxZoomRunner<CR>", desc = "Zoom" },
      }
    end,
  },
}
