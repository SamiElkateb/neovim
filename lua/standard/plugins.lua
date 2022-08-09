local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  vim.notify("packer not found!")
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  use { "wbthomason/packer.nvim" } -- Have packer manage itself

  -- Denpendencies plugins
  use { 'nvim-lua/popup.nvim', commit = "" } -- An implementation of the Popup API from vim in Neovim
  use { 'nvim-lua/plenary.nvim', commit = "" } -- Useful lua functions used ny lots of plugins
  use { 'windwp/nvim-autopairs', commit = "" } -- Autopairs, integrates with both cmp and treesitter
  use { 'kyazdani42/nvim-web-devicons', commit = "" }

  -- Colorschemes
  -- user { 'lunarvim/colorschemes', commit = "" } -- A bunch of colorschemes you can try out
  use { 'lunarvim/darkplus.nvim', commit = "" }
  use { 'folke/tokyonight.nvim', commit = "" }

  -- Auto-completion plugins
  use { 'hrsh7th/nvim-cmp', commit = "" } -- The completion plugin
  use { 'hrsh7th/cmp-buffer', commit = "" } -- buffer completions
  use { 'hrsh7th/cmp-path', commit = "" } -- path completions
  use { 'hrsh7th/cmp-cmdline', commit = "" } -- cmdline completions
  use { 'saadparwaiz1/cmp_luasnip', commit = "" } -- snippet completions
  use { 'hrsh7th/cmp-nvim-lsp', commit = "" }
  use { 'hrsh7th/cmp-nvim-lua', commit = "" }

  -- Snippets
  use { 'L3MON4D3/LuaSnip', commit = "" } --snippet engine
  use { 'rafamadriz/friendly-snippets', commit = "" } -- a bunch of snippets to use

  -- LSP
  use { 'neovim/nvim-lspconfig', commit = "" } -- enable LSP
  use { 'williamboman/nvim-lsp-installer', commit = "" } -- simple to use language server installer
  use { 'jose-elias-alvarez/null-ls.nvim', commit = "" } -- for formatters and linters


  -- Telescope
  use { 'nvim-telescope/telescope.nvim', commit = "" }
  use { 'nvim-telescope/telescope-media-files.nvim', commit = "" }
  use { 'ahmedkhalf/project.nvim', commit = "" } -- adds projects in Telescope

  -- Treesitter / code highlighting
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  use { 'JoosepAlviste/nvim-ts-context-commentstring', commit = "" }
  use { 'p00f/nvim-ts-rainbow', commit = "" }

  -- Comments
  use { 'numToStr/Comment.nvim', commit = "" } -- Easily comment stuff

  -- Git / Terminal
  use { 'lewis6991/gitsigns.nvim', commit = "" }
  use { 'akinsho/toggleterm.nvim', commit = "" }

  -- Nvim Tree
  use { 'kyazdani42/nvim-tree.lua', commit = "261a5c380c000e23c4a23dcd55b984c856cdb113" }

  -- Buffer and Statusline
  use { 'akinsho/bufferline.nvim', commit = "" }
  use { 'moll/vim-bbye', commit = "" }
  use { 'nvim-lualine/lualine.nvim', commit = "" }

  -- Home screen
  use { 'goolord/alpha-nvim', commit = "" }
  use { 'antoinemadec/FixCursorHold.nvim', commit = "" } -- This is needed to fix lsp doc highlight

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
