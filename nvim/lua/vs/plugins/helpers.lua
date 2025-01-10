return {
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    config = function()
      require("dressing").setup()
    end,
  },

  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {}
    end,
  },

  {
    "vim-scripts/ReplaceWithRegister",
    event = "VeryLazy",
  },

  {
    "gbprod/yanky.nvim",
    event = "VeryLazy",
    dependencies = { "kkharji/sqlite.lua" },
    config = function()
      require("yanky").setup {
        ring = {
          history_length = 50,
          storage = "shada",
          storage_path = "/Users/vadim/.config/nvim/.data/yanky.db",
        },
        preserve_cursor_position = {
          enabled = false,
        },
        picker = {
          select = {
            action = nil, -- nil to use default put action
          },
          telescope = {
            mappings = nil, -- nil to use default mappings
          },
        },
      }

      local wk = require("which-key")

      wk.add {
        { "[y", "<Plug>(YankyCycleForward)", desc = "Next YankyHistory" },
        { "]y", "<Plug>(YankyCycleForward)", desc = "Previous YankyHistory" },
        {
          mode = { "n", "x" },
          { "P", "<Plug>(YankyPutBefore)", desc = "Put Before Cursor" },
          { "gP", "<Plug>(YankyGPutBefore)", desc = "Put Before Cursor and leave the Cursor" },
          { "gp", "<Plug>(YankyGPutAfter)", desc = "Put After Cursor and leave the Cursor" },
          { "p", "<Plug>(YankyPutAfter)", desc = "Put After Cursor" },
        },
      }
    end,
  },

  {
    "windwp/nvim-autopairs",
    dependencies = {
      "hrsh7th/nvim-cmp",
    },
    event = "VeryLazy",
    config = function()
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
    end,
  },

  {
    "windwp/nvim-ts-autotag",
    event = "VeryLazy",
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    config = function()
      require("ibl").setup()
    end,
  },

  {
    "Wansmer/treesj",
    event = "VeryLazy",
    config = function()
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
        { "<leader>bm", treesj.toggle, desc = "Toggle block" },
        { "<leader>bj", treesj.join, desc = "Join block" },
        {
          "<leader>bM", function() treesj.toggle { split = { recursive = true } } end,
          desc = "Toggle block recursive",
        },
        { "<leader>bs", treesj.split, desc = "Split block" },
      }
    end,
  },

  {
    "mbbill/undotree",
    event = "VeryLazy",
  },
}
