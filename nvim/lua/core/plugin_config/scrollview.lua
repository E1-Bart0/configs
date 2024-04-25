require("scrollview").setup {
  excluded_filetypes = { "nerdtree" },
  current_only = true,
  base = "buffer",
  column = 120,
  signs_on_startup = { "all" },
  diagnostics_severities = { vim.diagnostic.severity.ERROR },
}
