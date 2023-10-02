require('nvim-treesitter.configs').setup {
  -- A list of parser names, or "all"
  ensure_installed = {
    "bash",
    "c",
    "css",
    "gitcommit",
    "gitignore",
    "html",
    "javascript",
    "json",
    "lua",
    "make",
    "markdown",
    "markdown_inline",
    "python",
    "rust",
    "soql",
    "sql",
    "toml",
    "vim",
    "xml",
    "yaml",
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
  },
  indent = {
    enable = true
  }
}

-- Folds
vim.cmd [[ set foldmethod=expr ]]
vim.cmd [[ set foldexpr=nvim_treesitter#foldexpr() ]]
vim.cmd [[ set nofoldenable  ]]
