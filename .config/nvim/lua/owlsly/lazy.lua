local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if vim.fn.empty(vim.fn.glob(lazypath)) > 0 then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
    dependencies = {
      -- LSP Support
      { "neovim/nvim-lspconfig" },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      { "jay-babu/mason-nvim-dap.nvim" },

      -- Autocompletion
      { "hrsh7th/nvim-cmp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "saadparwaiz1/cmp_luasnip" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lua" },
      { "onsails/lspkind.nvim" },
      { "windwp/nvim-ts-autotag" },
      { "gelguy/wilder.nvim" },
      { "windwp/nvim-autopairs", config = function()
        require("nvim-autopairs").setup {}
      end },

      -- Snippets
      { "L3MON4D3/LuaSnip", version = "2.*" },
      { "rafamadriz/friendly-snippets" },
      { "honza/vim-snippets" },
    },
  },

  -- Nice to have around
  { "numToStr/Comment.nvim" },
  { "nvim-ts-context-commentstring" },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "nvim-treesitter/nvim-treesitter-context" },
  { "kylechui/nvim-surround" },
  { "folke/trouble.nvim" },

  -- File navigation
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
  },
  { "ThePrimeagen/harpoon" },
  { "nvim-telescope/telescope.nvim", lazy = true },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },

  -- Git
  { "kdheepak/lazygit.nvim", lazy = true },
  { "airblade/vim-gitgutter" },
  { "lewis6991/gitsigns.nvim", lazy = true },

  -- Debugging
  { "mfussenegger/nvim-dap", lazy = true },
  { "rcarriga/nvim-dap-ui", lazy = true },
  { "theHamsta/nvim-dap-virtual-text", lazy = true },
  { "nvim-telescope/telescope-dap.nvim", lazy = true },

  -- Writing
  { "junegunn/goyo.vim", lazy = true },
  { "preservim/vim-pencil", lazy = true },

  -- Misc
  { "mbbill/undotree", lazy = true },
  { "uga-rosa/ccc.nvim", lazy = true },
  { "nvim-pack/nvim-spectre", lazy = true },
  { "norcalli/nvim-colorizer.lua", lazy = true },

  -- Looks
  { "nvim-lualine/lualine.nvim" },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { "folke/tokyonight.nvim" },
  { "romgrk/barbar.nvim", dependencies = { "lewis6991/gitsigns.nvim" } },
  { "nvimdev/dashboard-nvim", event = "VimEnter" },
})
