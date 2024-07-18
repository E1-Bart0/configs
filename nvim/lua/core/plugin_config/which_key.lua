local wk = require("which-key")

wk.setup {}

-- Keymaping
wk.add {
  {
    "<leader>dt",
    function()
      vim.diagnostic.enable(not vim.diagnostic.is_enabled())
    end,
    desc = "Toggle diagnosis",
  },
}

-- Keymaping
wk.add {
  { "<leader>+", "<C-a>", desc = "Increment number" },
  { "<leader>-", "<C-x>", desc = "Decrement number" },
  { "x", '"_x', desc = "Not save in clipboard" },
}

-- Keymaping
wk.add {
  { "<leader>nh", ":nohlsearch<CR>", desc = "Clear highlights" },
  { -- fmt: skip
    "<leader>nn",
    function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end,
    desc = "Toggle inline hints",
  },
}

-- Splitting windows
wk.add {
  { "<leader>s", group = "Split Window" },
  { "<leader>se", "<C-w>=", desc = "Make split window equal width" },
  { "<leader>sh", "<C-w>s", desc = "Split window horizontally" },
  { "<leader>sq", ":close<CR>", desc = "Close current split window" },
  { "<leader>sv", "<C-w>v", desc = "Split window vertically" },
}
