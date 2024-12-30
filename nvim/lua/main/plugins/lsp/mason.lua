-- Change the Diagnostic symbols in the sign column (gutter)
-- (not in youtube nvim video)
local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

local servers = {
  bashls = "auto",
  cssls = "auto",
  cucumber_language_server = "auto",
  docker_compose_language_service = "auto",
  dockerls = "auto",
  html = "auto",
  jsonls = "auto",
  lua_ls = "auto",
  svelte = "auto",
  yamlls = "auto",
  -- Python
  basedpyright = "configured",
  pylsp = "configured", -- :PylspInstall pylsp-mypy
  ruff = "configured",
  -- Go
  gopls = "configured",
}
local tools = {
  "eslint_d", -- js linter
  "prettier", -- prettier formatter
  "sqlfluff", -- sql
  "stylua", -- lua formatter
  "taplo", -- toml
  "vacuum", -- OPENAPI 3
  "xmlformatter", -- xml
}

return {
  { "neovim/nvim-lspconfig" },
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup {
        ensure_installed = servers,
        automatic_installation = true, -- auto-install configured servers (with lspconfig)
      }
      require("mason-tool-installer").setup {
        ensure_installed = tools,
      }

      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local on_attach = require("main.plugins.lsp.utils.keymaps").on_attach
      local lspconfig = require("lspconfig")

      -- Setup default keymaps for all servers
      for lsp, value in pairs(servers) do
        if value == "auto" then
          lspconfig[lsp].setup {
            on_attach = on_attach,
            capabilities = capabilities,
          }
        end
      end

      -- Custom configuration
      lspconfig.lua_ls.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = { -- custom settings for lua
          Lua = {
            -- make the language server recognize "vim" global
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              -- make language server aware of runtime files
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "/lua"] = true,
              },
            },
          },
        },
      }

      -- PYTHON
      -- Ruff
      lspconfig.ruff.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        init_options = {
          settings = {
            args = {
              "--config=/Users/vadim/.config/nvim/pyproject.toml",
            },
          },
        },
      }

      -- Pylsp
      local venv_path = os.getenv("VIRTUAL_ENV")
      local py_path = nil
      -- decide which python executable to use for mypy
      if venv_path ~= nil then
        py_path = venv_path .. "/bin/python3"
      else
        py_path = vim.g.python3_host_prog
      end

      lspconfig.pylsp.setup {
        on_attach = function(...) end,
        capabilities = capabilities,
        settings = {
          pylsp = {
            plugins = {
              -- formatter options
              black = {
                enabled = true,
                line_length = 100,
              },
              autopep8 = { enabled = false },
              yapf = { enabled = true },
              -- linter options
              flake8 = { enabled = false },
              pyflakes = { enabled = false },
              pycodestyle = { enabled = false },
              ruff = { enabled = false },
              -- type checker
              pylsp_mypy = {
                enabled = true,
                dmypy = false,
                overrides = { "--python-executable", py_path, true },
                live_mode = false,
              },
              -- auto-completion options
              jedi_completion = {
                fuzzy = true,
                enabled = true,
              },
              rename = {
                enabled = false,
              },
              rope = { enabled = true },
              rope_rename = { enabled = true },
              rope_completion = {
                enabled = true,
                eager = true,
              },
              rope_autoimport = { enabled = false },
              isort = { enabled = false },
            },
          },
        },
        flags = {
          debounce_text_changes = 200,
        },
      }

      -- Pyright
      lspconfig.basedpyright.setup {
        handlers = {
          ["textDocument/publishDiagnostics"] = function(...) end,
        },
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          pyright = {
            disableOrganizeImports = true,
          },
          python = {
            analysis = {
              autoSearchPaths = true,
              typeCheckingMode = "off",
              useLibraryCodeForTypes = true,
              ignore = { "*" },
            },
          },
        },
      }

      -- Go
      lspconfig.gopls.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        -- cmd = { "ya", "tool", "gopls" },
        filetypes = { "go", "gomod", "gowork", "hotmpl" },
        root_dir = require("lspconfig/util").root_pattern("go.work", "go.mod", ".git"),
        settings = {
          gopls = {
            -- directoryFilters = { "-", "+[/Users/starova1/arcadia/baremetal/]" },
            -- expandWorkspaceToModule = false,
            completeUnimported = true,
            usePlaceholders = false,
            analyses = {
              unusedvariable = true,
            },
          },
        },
      }
    end,
  },
}
