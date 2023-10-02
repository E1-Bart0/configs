local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  "wbthomason/packer.nvim",
  "ellisonleao/gruvbox.nvim",
  "rebelot/kanagawa.nvim",
  {
    "dracula/vim",
    lazy = false,
  },
  "nvim-tree/nvim-tree.lua",
  "nvim-tree/nvim-web-devicons",
  "nvim-lualine/lualine.nvim",
  "nvim-treesitter/nvim-treesitter",
  "bluz71/vim-nightfly-colors",
  "vim-test/vim-test",
  "lewis6991/gitsigns.nvim",
  "preservim/vimux",
  "christoomey/vim-tmux-navigator",
  "tpope/vim-fugitive",
  "tpope/vim-commentary",
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
  },
  "vim-scripts/ReplaceWithRegister",
  {
    "gbprod/yanky.nvim",
    dependencies = {
      "kkharji/sqlite.lua"
    }
  },
  "stevearc/dressing.nvim",
  "rcarriga/nvim-notify",
  "windwp/nvim-autopairs",
  "windwp/nvim-ts-autotag",
  "Pocco81/auto-save.nvim",

  -- python
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
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "L3MON4D3/LuaSnip",
  "saadparwaiz1/cmp_luasnip",
  "rafamadriz/friendly-snippets",
  -- mason (lsp servers)
  "williamboman/mason.nvim",
  "neovim/nvim-lspconfig",
  "onsails/lspkind.nvim",
  "williamboman/mason-lspconfig.nvim",
  {
    "ray-x/navigator.lua",
    dependencies = {
      {
        "ray-x/guihua.lua",
        run = "cd lua/fzy && make"
      },
      { "neovim/nvim-lspconfig" },
    },
  },
  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.0",
    dependencies = { { "nvim-lua/plenary.nvim", } }
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
  },
  -- buffers
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
  },
}

local opts = {}

require("lazy").setup(plugins, opts)
