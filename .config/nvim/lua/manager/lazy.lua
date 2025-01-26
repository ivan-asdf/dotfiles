-- Bootrstrap
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

-- Lazy, unlike Packer, is unable to use plugins installed by nix.
local plugins = {
  -- Colorschemes
  --'Ivan-Asdf/onedark.nvim',
  'catppuccin/nvim',
  'ellisonleao/gruvbox.nvim',
  'folke/tokyonight.nvim',
  'rebelot/kanagawa.nvim',

  -- Misc
  'brenoprata10/nvim-highlight-colors',
  'lewis6991/gitsigns.nvim',
  'nvim-lualine/lualine.nvim',

  -- Tree - file navigator
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      --tag = 'nightly' } -- optional, for file icons
    },
  },

  -- Mason
  {
    'williamboman/mason.nvim',
    lazy = false,
  },
  "williamboman/mason-lspconfig.nvim", -- for usage with nvim-lspconfig

  -- Treesitter(highlighting)
  'nvim-treesitter/nvim-treesitter', -- run= ':TSUpdate'
  'windwp/nvim-ts-autotag',

  -- Lsp config(suggestions, diagnostics, formating)
  'neovim/nvim-lspconfig', -- Configurations for Nvim LSP

  -- Autocompletion/suggestions(I gues ui side for autocomplete)
  'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'hrsh7th/nvim-cmp',         -- Autocompletion plugin

  'saadparwaiz1/cmp_luasnip', -- Snippets source for nvim-cmp
  'L3MON4D3/LuaSnip',         -- Snippets plugin

  -- Null ls(Lsp config for python)
  'jose-elias-alvarez/null-ls.nvim',

  -- Telescope
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    -- or                              , branch = '0.1.1',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },

  -- Fugitive (vim)
  'tpope/vim-fugitive',

  -- Bufferline
  'akinsho/bufferline.nvim',
  'moll/vim-bbye', -- Adds :Bdelete that closes buffer without closing window

  -- -- Commentary
  -- 'tpope/vim-commentary',
  {
    'numToStr/Comment.nvim',
    opts = {
      -- add any options here
    },
    lazy = false,
  },

  -- kdl file format - basic vim file type(required to be able to Comment.nvim)
  { "imsnif/kdl.vim", event = "BufReadPre *.kdl" },

  -- hightlights in red trailing whitespace, adds :StripWhitespace
  'ntpeters/vim-better-whitespace'

}

require("lazy").setup(plugins)
