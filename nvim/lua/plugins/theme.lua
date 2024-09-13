return {
  {
    "Mofiqul/dracula.nvim",
    priority = 1000,
    config = function()
      require("dracula").setup {
        lualine_bg_color = "#44475a",
      }

      -- Set theme
      vim.cmd([[ colorscheme dracula ]])
    end,
  },

  -- Lualine
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup {
        options = {
          icons_enabled = true,
          theme = "dracula-nvim",
        },
        sections = {
          lualine_a = {
            {
              "filename",
              path = 1,
            },
          },
        },
      }
    end,
  },
}
