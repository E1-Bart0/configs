-- Installing Lazy if it wasn't installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)
--

-- Specifying plugins
local plugins = {
  -- Themes
  { "dracula/vim", priority = 1000 },

  -- NvimTree
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-lua/plenary.nvim",
    },
  },

  -- Lualine
  "nvim-lualine/lualine.nvim",

  -- Treesitter
  "nvim-treesitter/nvim-treesitter",

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
  },

  -- Git
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "nvim-telescope/telescope.nvim", -- optional
      "sindrets/diffview.nvim", -- optional
      "ibhagwan/fzf-lua", -- optional
      "lewis6991/gitsigns.nvim", -- optional
    },
    config = true,
  },

  -- Tmux integration
  "preservim/vimux",
  "christoomey/vim-tmux-navigator",

  -- Helpers
  "tpope/vim-commentary",
  { "stevearc/dressing.nvim", event = "VeryLazy" },
  { "kylechui/nvim-surround", event = "VeryLazy" },
  "vim-scripts/ReplaceWithRegister",
  {
    "gbprod/yanky.nvim",
    dependencies = { "kkharji/sqlite.lua" },
  },
  "windwp/nvim-autopairs",
  "windwp/nvim-ts-autotag",
  "Pocco81/auto-save.nvim",
  "chentoast/marks.nvim",
  "rcarriga/nvim-notify",
  {
    "kevinhwang91/nvim-ufo", -- Folding
    dependencies = { "kevinhwang91/promise-async" },
  },
  { "lukas-reineke/indent-blankline.nvim", version="3.3.3"},
  "Wansmer/treesj",

  -- Pytest
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-python",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
    },
  },

  -- completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
      "onsails/lspkind.nvim",
    },
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts)
      require("lsp_signature").setup(opts)
    end,
  },

  -- formatting
  { "stevearc/conform.nvim", lazy = true },

  -- mason and lsp servers
  "neovim/nvim-lspconfig",
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
  },

  -- buffers
  {
    "akinsho/bufferline.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },

  -- DB
  {
    "kndndrj/nvim-dbee",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    event = "VeryLazy",
    build = function()
      require("dbee").install()
    end,
  },

  -- Others
  "vim-test/vim-test",
}

local opts = {}

require("lazy").setup(plugins, opts)
