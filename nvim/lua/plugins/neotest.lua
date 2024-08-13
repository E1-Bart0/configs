return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-python",
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    event = "VeryLazy",
    config = function()
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
      wk.add(
      {
          { "<leader>t", group = "Neotest" },
          { "<leader>tO", function() neotest.output_panel.toggle() end, desc = "Toggle Output Panel" },
          { "<leader>tT", function() neotest.run.run(vim.uv.cwd()) end, desc = "Run All Test Files" },
          { "<leader>ta", function() neotest.run.attach() end, desc = "Attach" },
          { "<leader>tl", function() neotest.run.run_last() end, desc = "Run Last" },
          { "<leader>to", function() neotest.output.open({ enter = true, auto_close = true }) end, desc = "Show Output" },
          { "<leader>tr", function() neotest.run.run() end, desc = "Run Nearest" },
          { "<leader>ts", function() neotest.summary.toggle() end, desc = "Toggle Summary" },
          { "<leader>tt", function() neotest.run.run(vim.fn.expand("%")) end, desc = "Run File" },
          { "<leader>tx", function() neotest.run.stop() end, desc = "Stop" },
        }
      )
    end,
  },
}
