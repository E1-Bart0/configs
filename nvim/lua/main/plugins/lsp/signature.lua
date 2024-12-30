return {
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    config = function()
      local signature = require("lsp_signature")
      signature.setup {}

      local wk = require("which-key")

      wk.add {
        {
          "<leader>k",
          function()
            require('lsp_signature').toggle_float_win()
          end,
          desc = "Signature help",
          mode = { "n" },
        },
      }
    end,
  },
}
