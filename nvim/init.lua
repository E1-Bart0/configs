local prefix = "main"
if vim.g.vscode then
  prefix = "vs"
end

require(prefix .. ".config.options")
require(prefix .. ".config.keymaps")
require(prefix .. ".config.plugins")
