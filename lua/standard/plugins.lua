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
  use { 'wbthomason/packer.nvim', commit = "afab89594f4f702dc3368769c95b782dbdaeaf0a" } -- Have packer manage itself

  -- Denpendencies plugins
  use { 'nvim-lua/popup.nvim', commit = "b7404d35d5d3548a82149238289fa71f7f6de4ac" } -- An implementation of the Popup API from vim in Neovim
  use { 'nvim-lua/plenary.nvim', commit = "31807eef4ed574854b8a53ae40ea3292033a78ea" } -- Useful lua functions used ny lots of plugins
  use { 'windwp/nvim-autopairs', commit = "ca89ab9e7e42aa9279f1cdad15398d6e18ccee86" } -- Autopairs, integrates with both cmp and treesitter
  use { 'kyazdani42/nvim-web-devicons', commit = "2d02a56189e2bde11edd4712fea16f08a6656944" }
  use {'tpope/vim-repeat', commit = "24afe922e6a05891756ecf331f39a1f6743d3d5a"}

  -- Colorschemes
  -- user { 'lunarvim/colorschemes', commit = "" } -- A bunch of colorschemes you can try out
  use { 'lunarvim/darkplus.nvim', commit = "bd8ab5fc71a3c85c41231b187a2add4a78129c4d" }
  use { 'folke/tokyonight.nvim', commit = "8223c970677e4d88c9b6b6d81bda23daf11062bb" }

  -- Auto-completion plugins
  use { 'hrsh7th/nvim-cmp', commit = "89df2cb22384f6a0f48695b3b8adbcd069e87036" } -- The completion plugin  + commit OK
  use { 'hrsh7th/cmp-buffer', commit = "62fc67a2b0205136bc3e312664624ba2ab4a9323" } -- buffer completions + commit OK
  use { 'hrsh7th/cmp-path', commit = "447c87cdd6e6d6a1d2488b1d43108bfa217f56e1" } -- path completions + commit OK
  use { 'hrsh7th/cmp-cmdline', commit = "9c0e331fe78cab7ede1c051c065ee2fc3cf9432e" } -- cmdline completions + commit OK
  use { 'saadparwaiz1/cmp_luasnip', commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36" } -- snippet completions
  use { 'hrsh7th/cmp-nvim-lsp', commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8" }

  -- Snippets
  use { 'L3MON4D3/LuaSnip', commit = "c599c560ed26f04f5bdb7e4498b632dc16fb9209" } --snippet engine
  use { 'rafamadriz/friendly-snippets', commit = "7339def34e46237eb7c9a893cb7d42dcb90e05e6" } -- a bunch of snippets to use

  -- LSP
  use { 'neovim/nvim-lspconfig', commit = "da7461b596d70fa47b50bf3a7acfaef94c47727d" } -- enable LSP
  use { 'williamboman/nvim-lsp-installer', commit = "d6f873754b7a5f50d4c70f76de1d7e8ea009bf56" } -- simple to use language server installer
  use { 'jose-elias-alvarez/null-ls.nvim', commit = "5b745e5fa2a18a2c0df8966080f4321fad4f42d7" } -- for formatters and linters


  -- Telescope
  use { 'nvim-telescope/telescope.nvim', commit = "8f80e821085bdb4583e78ea685e68dc34209d360" }
  use { 'nvim-telescope/telescope-media-files.nvim', commit = "513e4ee385edd72bf0b35a217b7e39f84b6fe93c" }
  use { 'ahmedkhalf/project.nvim', commit = "090bb11ee7eb76ebb9d0be1c6060eac4f69a240f" } -- adds projects in Telescope

  -- Treesitter / code highlighting
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    commit = "e9ab0341394b41ac9fbd197b0a6ceaff3c4d9e51"
  }
  use { 'JoosepAlviste/nvim-ts-context-commentstring', commit = "4befb8936f5cbec3b726300ab29edacb891e1a7b" }
  use { 'p00f/nvim-ts-rainbow', commit = "0c19f1eda263a1d44b6741e727fef223886c80a8" }

  -- Comments
  use { 'numToStr/Comment.nvim', commit = "fe9bbdbcd2f1b85cc8fccead68122873d94f8397" } -- Easily comment stuff

  -- Git / Terminal
  use { 'lewis6991/gitsigns.nvim', commit = "9c3ca027661136a618c82275427746e481c84a4e" }
  use { 'akinsho/toggleterm.nvim', commit = "623664233bbe305bf7c86060b95670bb1575534d" }

  -- Nvim Tree
  use { 'kyazdani42/nvim-tree.lua', commit = "261a5c380c000e23c4a23dcd55b984c856cdb113" }

  -- Buffer and Statusline
  use { 'akinsho/bufferline.nvim', commit = "2e5d92efacf40d488c4647a9e3e5100357b184cf" }
  use { 'moll/vim-bbye', commit = "25ef93ac5a87526111f43e5110675032dbcacf56" }
  use { 'nvim-lualine/lualine.nvim', commit = "c0510ddec86070dbcacbd291736de27aabbf3bfe" }

  -- Home screen
  use { 'goolord/alpha-nvim', commit = "d688f46090a582be8f9d7b70b4cf999b780e993d" }
  use { 'antoinemadec/FixCursorHold.nvim', commit = "5aa5ff18da3cdc306bb724cf1a138533768c9f5e" } -- This is needed to fix lsp doc highlight

  use {'ggandor/lightspeed.nvim', commit = "977ca1acdf8659ae0f7ac566d7fe06770661c9ce"}

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
