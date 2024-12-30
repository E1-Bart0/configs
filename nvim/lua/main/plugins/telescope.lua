return {
  {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup()
      telescope.load_extension("fzf")
      telescope.load_extension("yank_history")

      local builtin = require("telescope.builtin")

      local wk = require("which-key")

      wk.add {
        { "<leader>f", group = "Telescope" },
        { "<leader>ff", builtin.find_files, desc = "Find by name" },
        { "<leader>fh", builtin.help_tags, desc = "Help" },
        { "<leader>fo", builtin.oldfiles, desc = "Find recent files by name" },
        { "<leader>fs", builtin.spell_suggest, desc = "Spell Suggest" },
        { "<leader>ft", builtin.live_grep, desc = "Find by text" },
        { "<leader>fy", "<cmd>Telescope yank_history<CR>", desc = "Yank History" },
      }
    end,
  },
}
