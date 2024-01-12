require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = {
    "bashls",
    "dockerls",
    "docker_compose_language_service",
    "tsserver",
    "julials",
    "lua_ls",
    "vimls",
    "html",
    "jsonls",
    "cssls",
    "yamlls",
    "sqlls",
    "graphql",
    "dotls",
    "terraformls",
    "svelte",
    "clojure_lsp",
    -- Python
    "pylsp", -- :PylspInstall pyls-flake8 pylsp-mypy pyls-isort, ...
    "pyright",
    "ruff_lsp",
    -- IN ltex.lua
    "ltex",
  },
  -- auto-install configured servers (with lspconfig)
  automatic_installation = true, -- not the same as ensure_installed
}
require("mason-tool-installer").setup {
  ensure_installed = {
    "prettier", -- prettier formatter
    "stylua", -- lua formatter
    "isort", -- python formatter
    "pylint", -- python linter
    "eslint_d", -- js linter
    "sql-formatter", -- sql
    "taplo", -- toml
  },
}

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")

local keymap = vim.keymap -- for conciseness
local opts = { noremap = true, silent = true }

local signature_setup = {
  bind = true, -- This is mandatory, otherwise border config won't get registered.
  handler_opts = {
    border = "rounded",
  },
}

local on_attach = function(client, bufnr)
  -- LSP Signature
  require("lsp_signature").on_attach(signature_setup, bufnr)

  opts.buffer = bufnr

  -- set keybinds
  opts.desc = "Show LSP references"
  keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)

  opts.desc = "Go to declaration"
  keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

  opts.desc = "Show LSP definitions"
  keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

  opts.desc = "Show LSP implementations"
  keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

  opts.desc = "Show LSP type definitions"
  keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

  opts.desc = "See available code actions"
  keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

  opts.desc = "Smart rename"
  keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

  opts.desc = "Show buffer diagnostics"
  keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

  opts.desc = "Show line diagnostics"
  keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

  opts.desc = "Go to previous diagnostic"
  keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

  opts.desc = "Go to next diagnostic"
  keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

  opts.desc = "Show documentation for what is under cursor"
  keymap.set("n", "<leader>K", vim.lsp.buf.hover, opts)

  opts.desc = "Restart LSP"
  keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
end

-- Change the Diagnostic symbols in the sign column (gutter)
-- (not in youtube nvim video)
local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

lspconfig["lua_ls"].setup {
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

lspconfig.bashls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
lspconfig.dockerls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
lspconfig.docker_compose_language_service.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}
lspconfig.tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
lspconfig.julials.setup {
  on_new_config = function(new_config, _)
    local julia = vim.fn.expand("~/.local/share/nvim/mason/.julia/environments/nvim-lspconfig/bin/julia")
    if require("lspconfig").util.path.is_file(julia) then
      vim.notify("Hello!")
      new_config.cmd[1] = julia
    end
  end,
}
lspconfig.vimls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
lspconfig.html.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
lspconfig.jsonls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
lspconfig.cssls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
lspconfig.yamlls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
lspconfig.sqlls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
lspconfig.graphql.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
lspconfig.dotls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
lspconfig.terraformls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {
    "terraform",
    "tf",
    "hcl",
  },
}
lspconfig.svelte.setup {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)

    vim.api.nvim_create_autocmd("BufWritePost", {
      pattern = { "*.js", "*.ts" },
      callback = function(ctx)
        if client.name == "svelte" then
          client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
        end
      end,
    })
  end,
}
lspconfig.clojure_lsp.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

-- PYTHON

lspconfig.ruff_lsp.setup {
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
          report_progress = true,
          live_mode = false,
        },
        -- auto-completion options
        jedi_completion = {
          fuzzy = false,
          enabled = true,
        },
        rename = {
          enabled = false,
        },
        rope = { enabled = true },
        rope_rename = { enabled = false },
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

lspconfig.pyright.setup {
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
      },
    },
  },
}
