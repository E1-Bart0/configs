local lspconfig = require("lspconfig")

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local on_attach = function(client, bufnr)
  require("navigator.lspclient.mapping").setup({ client = client, bufnr = bufnr }) -- setup navigator keymaps here,
  require("navigator.dochighlight").documentHighlight(bufnr)
  require("navigator.codeAction").code_action_prompt(bufnr)
end


-- Pylsp
local venv_path = os.getenv("VIRTUAL_ENV")
local py_path = nil
-- decide which python executable to use for mypy
if venv_path ~= nil then
  py_path = venv_path .. "/bin/python3"
else
  py_path = vim.g.python3_host_prog
end


lspconfig.pylsp.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    pylsp = {
      plugins = {
        -- formatter options
        black = {
          enabled = true,
          line_length = 100,
        },
        autopep8 = { enabled = true },
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
          fuzzy = true,
          enabled = true,
        },
        rope = { enabled = true },
        rope_autoimport = { enabled = false },
        isort = { enabled = false },
      },
    },
  },
  flags = {
    debounce_text_changes = 200,
  }
})

lspconfig.pyright.setup({
  handlers = {
    ["textDocument/publishDiagnostics"] = function(...) end,
  },
  on_attach = function(client, bufnr)
    require("navigator.lspclient.mapping").setup({ client = client, bufnr = bufnr }) -- setup navigator keymaps here,
    require("navigator.dochighlight").documentHighlight(bufnr)
    require("navigator.codeAction").code_action_prompt(bufnr)
    client.server_capabilities.codeActionProvider = false
  end,
  settings = {
    pyright = {
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        autoSearchPaths = true,
        typeCheckingMode = "basic",
        useLibraryCodeForTypes = true,
      },
    },
  },
})

lspconfig.ruff_lsp.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    settings = {
      args = {
        "--config=/Users/vadim/.config/nvim/pyproject.toml"
      },
    }
  }
})
