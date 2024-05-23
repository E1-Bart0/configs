local venv_path = os.getenv("VIRTUAL_ENV")

local py_path = nil
-- decide which python executable to use for pytest
if venv_path ~= nil then
  py_path = venv_path .. "/bin/python3"
else
  py_path = vim.g.python3_host_prog
end

local neotest = require("neotest")
neotest.setup {
  adapters = {
    require("neotest-python") {
      -- Extra arguments for nvim-dap configuration
      -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
      dap = { justMyCode = false },
      -- Command line arguments for runner
      -- Can also be a function to return dynamic values
      args = { "-vvv" },
      -- Runner to use. Will use pytest if available by default.
      -- Can be a function to return dynamic value.
      runner = "pytest",
      -- Custom python path for the runner.
      -- Can be a string or a list of strings.
      -- Can also be a function to return dynamic value.
      -- If not provided, the path will be inferred by checking for
      -- virtual envs in the local directory and for Pipenev/Poetry configs
      python = py_path,
      -- Returns if a given file path is a test file.
      -- NB: This function is called a lot so don't perform any heavy tasks within it.
      -- !!EXPERIMENTAL!! Enable shelling out to `pytest` to discover test
      -- instances for files containing a parametrize mark (default: false)
      pytest_discover_instances = true,
    },
  },
}

local wk = require("which-key")

-- stylua: ignore
wk.register(
  {
    t = {
      name = "Neotest",
      t = { function() require("neotest").run.run(vim.fn.expand("%")) end, "Run File" },
      T = { function() require("neotest").run.run(vim.uv.cwd()) end, "Run All Test Files" },
      r = { function() require("neotest").run.run() end, "Run Nearest" },
      a = { function() require("neotest").run.attach() end, "Attach" },
      l = { function() require("neotest").run.run_last() end, "Run Last" },
      s = { function() require("neotest").summary.toggle() end, "Toggle Summary" },
      o = { function() require("neotest").output.open({ enter = true, auto_close = true }) end, "Show Output" },
      O = { function() require("neotest").output_panel.toggle() end, "Toggle Output Panel" },
      x = { function() require("neotest").run.stop() end, "Stop" },
    },
  }, { prefix = "<leader>" }
)
