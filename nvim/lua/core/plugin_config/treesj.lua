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
wk.register({
  b = {
    name = "Split/Join Block",
    m = { function() require('treesj').toggle({ split = { recursive = true } }) end, "Toggle block" },
    M = { treesj.toggle, "Toggle block" },
    j = { treesj.join, "Join block" },
    s = { treesj.split, "Split block" },
  },
}, { prefix = "<leader>" })
