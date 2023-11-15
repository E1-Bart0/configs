require("treesj").setup({
  -- Use default keymaps (<space>m - toggle, <space>j - join, <space>s - split)

  check_syntax_error = false,
  max_join_length = 120,
  cursor_behavior = 'hold',
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
})
