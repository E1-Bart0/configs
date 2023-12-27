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
    python = { "isort", "black" },
    terraform = { "terraform_fmt" },
    sql = { "sql_formatter" },
    docker = { "prettier" },
    bash = { "beautysh" },
  },
  format_on_save = nil,
}

vim.keymap.set({ "n", "v" }, "<leader>ff", function()
  conform.format {
    lsp_fallback = true,
    async = true,
    timeout_ms = 1000,
  }
end, { desc = "Format file or range (in visual mode)" })