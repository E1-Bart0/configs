local navigator = require("navigator")
navigator.setup({
  mason = true,
  lsp = {
    disable_lsp = { "pyright", "pylsp", },
    format_on_save = false,
  }
})


