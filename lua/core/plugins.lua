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
  "stevearc/dressing.nvim",
  "rcarriga/nvim-notify",
  -- Helpers
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
  },
  "vim-scripts/ReplaceWithRegister",
  {
    "gbprod/yanky.nvim",
    dependencies = {
      "kkharji/sqlite.lua"
    }
  },
  "windwp/nvim-autopairs",
  "windwp/nvim-ts-autotag",
  "Pocco81/auto-save.nvim",
  "chentoast/marks.nvim",

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
    dependencies = { { "nvim-lua/plenary.nvim", } }
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
  },
  -- buffers
  {
    "akinsho/bufferline.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
  },
  -- DB
  {
    "kndndrj/nvim-dbee",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    build = function()
    -- Install tries to automatically detect the install method.
    -- if it fails, try calling it with one of these parameters:
    --    "curl", "wget", "bitsadmin", "go"
    require("dbee").install()
  end,
  },
}

local opts = {}

require("lazy").setup(plugins, opts)
