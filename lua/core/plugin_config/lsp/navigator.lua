local navigator = require("navigator")
require("lsp_signature").setup({
  bind = true, -- This is mandatory, otherwise border config won't get registered.
  handler_opts = {
    border = "rounded"
  }
})

navigator.setup({
  mason = true,
  lsp_signature_help = true,
  lsp = {
    enable = true,
    disable_lsp = { "pyright", "pylsp", },
    format_on_save = false,
    format_options = { async = true },
  }
})
