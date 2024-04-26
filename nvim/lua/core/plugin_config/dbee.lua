local dbee = require("dbee")

dbee.setup()

local wk = require("which-key")

wk.register({
  db = {
    name = "DBee",
    o = { dbee.open, "Dbee Open" },
    c = { dbee.close, "DBee Close" },
  },
}, { prefix = "<leader>" })
