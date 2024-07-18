local cmp = require("cmp")

local lspkind = require("lspkind")
require("luasnip.loaders.from_vscode").lazy_load()

vim.opt.completeopt = "menu,menuone,noselect"

cmp.setup {
  mapping = cmp.mapping.preset.insert {
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["ç"] = cmp.mapping.complete(), -- show completion suggersion ALT + C
    ["<C-e>"] = cmp.mapping.abort(), -- close complete window
    ["<CR>"] = cmp.mapping.confirm { select = false },
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
    { name = "path" },
  }),
  -- configure lspkind for vs-code like icons
  formatting = {
    format = lspkind.cmp_format {
      maxwidth = 50,
      ellipsis_char = "...",
    },
  },
}

cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = { { name = "buffer" } },
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    {
      name = "cmdline",
      option = {
        ignore_cmds = { "Man", "!" },
      },
    },
  }),
})
