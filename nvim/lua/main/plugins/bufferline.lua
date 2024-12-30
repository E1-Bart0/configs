return {
  {
    "akinsho/bufferline.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      vim.opt.termguicolors = true
      local bufferline = require("bufferline")

      bufferline.setup {
        options = {
          offsets = {
            {
              filetype = "NvimTree",
            },
          },
        },
      }

      local wk = require("which-key")

      wk.add {
        { "H", ":BufferLineCyclePrev<CR>", desc = "Next Buffer" },
        { "L", ":BufferLineCycleNext<CR>", desc = "Next Buffer" },
        { "<leader>bl", ":BufferLinePick<CR>", desc = "Pick Buffer" },
        { "<leader>bc", ":BufferLineCloseOthers<CR>", desc = "Close others Buffers" },
      }
    end,
  },
}
