require("mason").setup()
require("mason-lspconfig").setup(
  {
    ensure_installed = {
      "bashls",
      "dockerls",
      "docker_compose_language_service",
      "tsserver",
      "julials",
      "lua_ls", -- Setup in Naviagot ??
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
      -- python.lua
      "pylsp", -- :PylspInstall pyls-flake8 pylsp-mypy pyls-isort, ...
      "pyright",
      "ruff_lsp",
      -- ltex.lua
      "ltex",
    }
  }
)

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")


local on_attach = function(client, bufnr)
  require("navigator.lspclient.mapping").setup({ client = client, bufnr = bufnr }) -- setup navigator keymaps here,
  require("navigator.dochighlight").documentHighlight(bufnr)
  require("navigator.codeAction").code_action_prompt(bufnr)
end

lspconfig.bashls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})
lspconfig.dockerls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})
lspconfig.docker_compose_language_service.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})
lspconfig.tsserver.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})
lspconfig.julials.setup({
  on_new_config = function(new_config, _)
    local julia = vim.fn.expand("~/.local/share/nvim/mason/.julia/environments/nvim-lspconfig/bin/julia")
    if require 'lspconfig'.util.path.is_file(julia) then
      vim.notify("Hello!")
      new_config.cmd[1] = julia
    end
  end
})
lspconfig.vimls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})
lspconfig.html.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})
lspconfig.jsonls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})
lspconfig.cssls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})
lspconfig.yamlls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})
lspconfig.sqlls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})
lspconfig.graphql.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})
lspconfig.dotls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})
lspconfig.terraformls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})
lspconfig.svelte.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})
lspconfig.clojure_lsp.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})
