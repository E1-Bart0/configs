return {
  {
    "stevearc/conform.nvim",
    event = "VeryLazy",
    config = function()
      local conform = require("conform")
      conform.setup {
        formatters_by_ft = {
          bash = { "beautysh" },
          css = { "prettier" },
          docker = { "prettier" },
          graphql = { "prettier" },
          html = { "prettier" },
          javascript = { "prettier" },
          javascriptreact = { "prettier" },
          json = { "prettier" },
          lua = { "stylua" },
          markdown = { "prettier" },
          python = { "ruff_format" },
          sql = { "sqlfluff" },
          svelte = { "prettier" },
          terraform = { "terraform_fmt" },
          toml = { "taplo" },
          typescript = { "prettier" },
          typescriptreact = { "prettier" },
          xml = { "xmlformat" },
          yaml = { "prettier" },
        },
        format_on_save = nil,
        formatters = {
          ruff = {
            prepend_args = { "format", "--config", "/Users/vadim/.config/nvim/pyproject.toml" },
          },
          sqlfluff = {
            command = "sqlfluff",
            args = { "fix", "--config", "/Users/vadim/.config/nvim/pyproject.toml", "$FILENAME" },
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
    end,
  },
}
