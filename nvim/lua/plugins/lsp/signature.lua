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
            vim.lsp.buf.signature_help()
          end,
          desc = "Format file or range (in visual mode)",
          mode = { "n" },
        },
      }
    end,
  },
}
