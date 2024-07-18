local dbee = require("dbee")

dbee.setup()

local wk = require("which-key")

wk.add {
  { "<leader>db", group = "DBee" },
  { "<leader>dbc", dbee.close, desc = "DBee Close" },
  { "<leader>dbo", dbee.open, desc = "Dbee Open" },
}
