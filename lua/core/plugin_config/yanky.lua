require("yanky").setup({
  ring = {
    history_length = 50,
    storage = "shada",
    storage_path = "/Users/vadim/.config/nvim/.data/yanky.db"
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
})

vim.keymap.set({"n","x"}, "p", "<Plug>(YankyPutAfter)")
vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")
vim.keymap.set("n", "[y", "<Plug>(YankyCycleForward)")
vim.keymap.set("n", "]y", "<Plug>(YankyCycleBackward)")
