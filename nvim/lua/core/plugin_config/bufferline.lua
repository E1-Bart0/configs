vim.opt.termguicolors = true
local bufferline = require("bufferline")

bufferline.setup {
  options = {
    buffer_close_icon = "󰅖",
    modified_icon = "●",
    close_icon = "",
    mode = "buffers", -- set to "tabs" to only show tabpages instead
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
}
