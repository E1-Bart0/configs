return {
  {
    "dracula/vim",
    priority = 1000,
  },

  -- Lualine
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup {
        options = {
          icons_enabled = true,
          theme = "dracula",
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
