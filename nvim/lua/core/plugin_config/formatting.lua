local conform = require("conform")
conform.setup {
  formatters_by_ft = {
    javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },
    svelte = { "prettier" },
    css = { "prettier" },
    html = { "prettier" },
    json = { "prettier" },
    yaml = { "prettier" },
    toml = { "taplo" },
    markdown = { "prettier" },
    graphql = { "prettier" },
    lua = { "stylua" },
    python = { "ruff_format" },
    terraform = { "terraform_fmt" },
    sql = { "sqlfluff" },
    docker = { "prettier" },
    bash = { "beautysh" },
  },
  format_on_save = nil,
  formatters = {
    ruff = {
      prepend_args = { "format", "--config", "/Users/vadim/.config/nvim/pyproject.toml" },
    },
    sqlfluff = {
      command = "sqlfluff",
      args = { "fix", "--config", "/Users/vadim/.config/nvim/pyproject.toml" },
      stdin = true,
    },
  },
}

local wk = require("which-key")

-- stylua: ignore
wk.add {
  {
    "ff",
    function() conform.format { lsp_fallback = true, async = true, timeout_ms = 1000 } end,
    desc = "Format file or range (in visual mode)",
    mode = { "n", "v" },
  },
}
