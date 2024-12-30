return {
  {
    "kndndrj/nvim-dbee",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    event = "VeryLazy",
    build = function()
      require("dbee").install()
    end,
    config = function()
      local dbee = require("dbee")

      dbee.setup()

      local wk = require("which-key")

      wk.add {
        { "<leader>db", group = "DBee" },
        { "<leader>dbc", dbee.close, desc = "DBee Close" },
        { "<leader>dbo", dbee.open, desc = "Dbee Open" },
      }
    end,
  },
}
