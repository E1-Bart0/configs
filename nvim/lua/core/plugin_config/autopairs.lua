require("nvim-autopairs").setup {
  check_ts = true,
  ts_config = {
    lua = { "string" },
    javascript = { "template_string" },
    java = false,
    python = true,
  },
}
-- import nvim-autopairs completion functionality
local cmp_autopairs = require("nvim-autopairs.completion.cmp")

-- import nvim-cmp plugin (completions plugin)
local cmp = require("cmp")

-- make autopairs and completion work together
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
