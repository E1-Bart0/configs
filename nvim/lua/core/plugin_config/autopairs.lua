require("nvim-autopairs").setup {
  check_ts = true,
  ts_config = {
    java = false,
    javascript = { "template_string" },
    lua = { "string" },
    python = { "string" },
  },
}
-- import nvim-autopairs completion functionality
local cmp_autopairs = require("nvim-autopairs.completion.cmp")

-- import nvim-cmp plugin (completions plugin)
local cmp = require("cmp")

-- make autopairs and completion work together
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
