local ensure_lazy = function()
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
end

ensure_lazy()

return require('lazy').setup({
  {
    'nvim-telescope/telescope.nvim',
    version = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },

  { 'windwp/nvim-autopairs' },
  {
    'bluz71/vim-moonfly-colors',
    name = 'moonfly',
    config = function()
      vim.g.moonflyTransparent = true
      vim.cmd('colorscheme moonfly')
    end
  },

  {
    'nvim-treesitter/nvim-treesitter',
    build = function()
      require('nvim-treesitter.install').update({ with_sync = true })()
    end,
    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
  },

  {
    'theprimeagen/harpoon',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  {
    'theprimeagen/refactoring.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { "nvim-treesitter/nvim-treesitter" },
    },
  },

  {
    'epwalsh/obsidian.nvim',
    version = "*", -- use the latest commit
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope.nvim' },   -- Optional
      { 'hrsh7th/nvim-cmp' },                -- Optional
      { 'nvim-treesitter/nvim-treesitter' }, -- Optional
      -- { 'pomo.nvim' },                    -- Optional
    },
  },

  { 'lewis6991/gitsigns.nvim' },
  { 'mbbill/undotree' },
  { 'tpope/vim-fugitive' },
  { 'tpope/vim-commentary' },
  { 'tpope/vim-surround' },
  { 'tpope/vim-repeat' },
  { 'tpope/vim-speeddating' },
  { 'tpope/vim-sleuth' },
  { 'tpope/vim-unimpaired' },
  { 'folke/neodev.nvim' },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },
  {
    'chrisgrieser/nvim-genghis',
    dependencies = {
      'stevearc/dressing.nvim', -- Required
      'hrsh7th/nvim-cmp',       -- Optional
      'hrsh7th/cmp-omni',       -- Optional
    },
  },
  {
    'VonHeikemen/lsp-zero.nvim',
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },             -- Required
      { 'williamboman/mason.nvim' },           -- Optional
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional
      { 'mhartington/formatter.nvim' },        -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },         -- Required
      { 'hrsh7th/cmp-nvim-lsp' },     -- Required
      { 'hrsh7th/cmp-buffer' },       -- Optional
      { 'hrsh7th/cmp-path' },         -- Optional
      { 'saadparwaiz1/cmp_luasnip' }, -- Optional
      { 'hrsh7th/cmp-nvim-lua' },     -- Optional

      -- Snippets
      { 'L3MON4D3/LuaSnip' },             -- Required
      { 'rafamadriz/friendly-snippets' }, -- Optional
    }
  },
})
