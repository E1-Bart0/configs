vim.opt.termguicolors = true
local bufferline = require("bufferline")

bufferline.setup {
  options = {
    buffer_close_icon = '󰅖',
    modified_icon = '●',
    close_icon = '',
    mode = "buffers",     -- set to "tabs" to only show tabpages instead
    offsets = {
      {
        filetype = "NvimTree",
      }
    },
  }
}


vim.keymap.set('n', 'L', ':BufferLineCycleNext<CR>')
vim.keymap.set('n', 'H', ':BufferLineCyclePrev<CR>')
