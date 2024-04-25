require("yanky").setup {
  ring = {
    history_length = 50,
    storage = "shada",
    storage_path = "/Users/vadim/.config/nvim/.data/yanky.db",
  },
  preserve_cursor_position = {
    enabled = false,
  },
  picker = {
    select = {
      action = nil, -- nil to use default put action
    },
    telescope = {
      mappings = nil, -- nil to use default mappings
    },
  },
}

local wk = require("which-key")

wk.register {
  ["[y"] = { "<Plug>(YankyCycleForward)", "Next YankyHistory" },
  ["]y"] = { "<Plug>(YankyCycleForward)", "Previous YankyHistory" },
  ["p"] = { "<Plug>(YankyPutAfter)", "Put After Cursor", mode = { "n", "x" } },
  ["P"] = { "<Plug>(YankyPutBefore)", "Put Before Cursor", mode = { "n", "x" } },
  ["gp"] = { "<Plug>(YankyGPutAfter)", "Put After Cursor and leave the Cursor", mode = { "n", "x" } },
  ["gP"] = { "<Plug>(YankyGPutBefore)", "Put Before Cursor and leave the Cursor", mode = { "n", "x" } },
}
