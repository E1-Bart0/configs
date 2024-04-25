local telescope = require("telescope")
telescope.setup()
telescope.load_extension("fzf")
telescope.load_extension("yank_history")

local builtin = require("telescope.builtin")

local wk = require("which-key")

wk.register({
  f = {
    name = "Telescope",
    f = { builtin.find_files, "Find by name" },
    t = { builtin.live_grep, "Find by text" },
    o = { builtin.oldfiles, "Find recent files by name" },
    h = { builtin.help_tags, "Help" },
    y = { "<cmd>Telescope yank_history<CR>", "Yank History" },
    s = { builtin.spell_suggest, "Spell Suggest" },
  },
}, { prefix = "<leader>" })
