local venv_path = os.getenv("VIRTUAL_ENV")
local py_path = nil
-- decide which python executable to use for mypy
if venv_path ~= nil then
  py_path = venv_path .. "/bin/python3"
else
  py_path = vim.g.python3_host_prog
end

local neotest = require("neotest")
neotest.setup({
  adapters = {
    require("neotest-python")({
      -- Extra arguments for nvim-dap configuration
      -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
      dap = { justMyCode = false },
      -- Command line arguments for runner
      -- Can also be a function to return dynamic values
      args = { "-vvv", "--log-level", "INFO", },
      -- Runner to use. Will use pytest if available by default.
      -- Can be a function to return dynamic value.
      runner = "pytest",
      -- Custom python path for the runner.
      -- Can be a string or a list of strings.
      -- Can also be a function to return dynamic value.
      -- If not provided, the path will be inferred by checking for
      -- virtual envs in the local directory and for Pipenev/Poetry configs
      python = py_path
      -- Returns if a given file path is a test file.
      -- NB: This function is called a lot so don't perform any heavy tasks within it.
    })
  }
})

vim.keymap.set("n", "tr", "<cmd>Neotest run<CR>")
vim.keymap.set("n", "ts", "<cmd>Neotest summary<CR>")
vim.keymap.set("n", "to", "<cmd>Neotest output<CR>")
