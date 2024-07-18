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

wk.add {
  { "[y", "<Plug>(YankyCycleForward)", desc = "Next YankyHistory" },
  { "]y", "<Plug>(YankyCycleForward)", desc = "Previous YankyHistory" },
  {
    mode = { "n", "x" },
    { "P", "<Plug>(YankyPutBefore)", desc = "Put Before Cursor" },
    { "gP", "<Plug>(YankyGPutBefore)", desc = "Put Before Cursor and leave the Cursor" },
    { "gp", "<Plug>(YankyGPutAfter)", desc = "Put After Cursor and leave the Cursor" },
    { "p", "<Plug>(YankyPutAfter)", desc = "Put After Cursor" },
  },
}
