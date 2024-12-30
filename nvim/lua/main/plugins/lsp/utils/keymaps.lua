local keymap = vim.keymap -- for conciseness
local opts = { noremap = true, silent = true }

local signature_setup = {
  bind = true, -- This is mandatory, otherwise border config won't get registered.
  floating_window = false,
  handler_opts = {
    border = "rounded",
  },
}

return {
  on_attach = function(client, bufnr)
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

    opts.desc = "Previous diagnostic"
    keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

    opts.desc = "Next diagnostic"
    keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

    opts.desc = "Show documentation for what is under cursor"
    keymap.set("n", "<leader>K", vim.lsp.buf.hover, opts)

    opts.desc = "Restart LSP"
    keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
  end,
}
