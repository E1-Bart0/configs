local dbee = require("dbee")

dbee.setup()

vim.keymap.set("n", "<leader>dbo", dbee.open)
vim.keymap.set("n", "<leader>dbc", dbee.close)
