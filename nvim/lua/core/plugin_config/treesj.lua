local treesj = require("treesj")
treesj.setup {
  use_default_keymaps = false,
  check_syntax_error = false,
  max_join_length = 400,
  cursor_behavior = "hold",
  notify = true,
  langs = {
    lua = require("treesj.langs.lua"),
    json = require("treesj.langs.json"),
    toml = require("treesj.langs.toml"),
    yaml = require("treesj.langs.yaml"),
    python = require("treesj.langs.python"),
    bash = require("treesj.langs.bash"),
    sql = require("treesj.langs.sql"),
  },
  dot_repeat = true,
}

local wk = require("which-key")

-- stylua: ignore
wk.add {
  { "<leader>b", group = "Split/Join Block" },
  { "<leader>bM", treesj.toggle, desc = "Toggle block" },
  { "<leader>bj", treesj.join, desc = "Join block" },
  {
    "<leader>bm", function() treesj.toggle { split = { recursive = true } } end,
    desc = "Toggle block",
  },
  { "<leader>bs", treesj.split, desc = "Split block" },
}
