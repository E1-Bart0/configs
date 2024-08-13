return {
  {
    "Pocco81/auto-save.nvim",
    event = "VeryLazy",
    config = function()
      require("auto-save").setup {}
    end,
  },

  {
    "dstein64/nvim-scrollview",
    event = "VeryLazy",
    config = function()
      require("scrollview").setup {
        excluded_filetypes = { "nerdtree" },
        current_only = true,
        base = "buffer",
        column = 120,
        signs_on_startup = { "all" },
        diagnostics_severities = { vim.diagnostic.severity.ERROR },
      }
    end,
  },

  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = function()
      require("Comment").setup {}
    end,
  },

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
    "chentoast/marks.nvim",
    event = "VeryLazy",
    config = function()
      require("marks").setup {}
      -- mx              Set mark x
      -- m,              Set the next available alphabetical (lowercase) mark
      -- m;              Toggle the next available mark at the current line
      -- dmx             Delete mark x
      -- dm-             Delete all marks on the current line
      -- dm<space>       Delete all marks in the current buffer
      -- m]              Move to next mark
      -- m[              Move to previous mark
      -- m:              Preview mark. This will prompt you for a specific mark to
      --                 preview; press <cr> to preview the next mark.
      --
      -- m[0-9]          Add a bookmark from bookmark group[0-9].
      -- dm[0-9]         Delete all bookmarks from bookmark group[0-9].
      -- m}              Move to the next bookmark having the same type as the bookmark under
      --                 the cursor. Works across buffers.
      -- m{              Move to the previous bookmark having the same type as the bookmark under
      --                 the cursor. Works across buffers.
      -- dm=             Delete the bookmark under the cursor.
    end,
  },

  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      local notify = require("notify")

      notify.setup {
        -- Animation style
        stages = "fade_in_slide_out",
        -- Default timeout for notifications
        timeout = 1500,
        background_colour = "#2E3440",
      }

      vim.notify = notify
    end,
  },

  {
    "kevinhwang91/nvim-ufo", -- Folding
    dependencies = { "kevinhwang91/promise-async" },
    config = function()
      vim.o.foldcolumn = "1" -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      local ufo = require("ufo")

      local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = (" 󰁂 %d "):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, "MoreMsg" })
        return newVirtText
      end
      ufo.setup {
        fold_virt_text_handler = handler,
        provider_selector = function(bufnr, filetype, buftype)
          return { "treesitter", "indent" }
        end,
      }
      -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
      --
      local wk = require("which-key")

      wk.add {
        { "zM", ufo.closeAllFolds, desc = "Close All Folds" },
        { "zR", ufo.openAllFolds, desc = "Open All Folds" },
      }
    end,
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
        { "<leader>bM", treesj.toggle, desc = "Toggle block" },
        { "<leader>bj", treesj.join, desc = "Join block" },
        {
          "<leader>bm", function() treesj.toggle { split = { recursive = true } } end,
          desc = "Toggle block",
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
