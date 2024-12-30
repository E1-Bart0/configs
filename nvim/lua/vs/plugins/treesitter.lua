return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup {
      -- A list of parser names, or "all"
      ensure_installed = {
        "bash",
        "c",
        "css",
        "gitcommit",
        "gitignore",
        "go",
        "html",
        "javascript",
        "json",
        "lua",
        "make",
        "markdown",
        "python",
        "sql",
        "terraform",
        "toml",
        "vim",
        "xml",
        "yaml",
      },

      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,
      auto_install = true,
      highlight = { enable = false },
      indent = { enable = false },
    }
  end,
}
