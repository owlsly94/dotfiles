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

        -- Snippets
        { "L3MON4D3/LuaSnip", version = "2.*" },
        { "rafamadriz/friendly-snippets" },
        { "honza/vim-snippets" },
      },
    },

    -- Nice to have around
    { "numToStr/Comment.nvim" },
    { "windwp/nvim-autopairs" },
    { "nvim-ts-context-commentstring" },
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    { "nvim-treesitter/nvim-treesitter-context" },
    { "kylechui/nvim-surround" },

    -- File navigation
    {
      "nvim-tree/nvim-tree.lua",
      version = "*",
      lazy = false,
      dependencies = { { "nvim-tree/nvim-web-devicons" } },
    },
    { "ThePrimeagen/harpoon" },
    { "nvim-telescope/telescope.nvim" },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

    -- Git
    { "kdheepak/lazygit.nvim" },
    { "airblade/vim-gitgutter" },

    -- Debugging
    { "mfussenegger/nvim-dap" },
    { "rcarriga/nvim-dap-ui" },
    { "theHamsta/nvim-dap-virtual-text" },
    { "nvim-telescope/telescope-dap.nvim" },

    --Writting
    { "junegunn/goyo.vim" },
    { "preservim/vim-pencil" },

    -- Misc
    { "mbbill/undotree" },
    { "uga-rosa/ccc.nvim" },
    { "nvim-pack/nvim-spectre" },
    {
      "folke/noice.nvim",
      dependencies = { { "MunifTanjim/nui.nvim" }, { "rcarriga/nvim-notify" }, { "nvim-lua/plenary.nvim" }  },
    },
    { "norcalli/nvim-colorizer.lua" },

    -- Looks
    { "nvim-lualine/lualine.nvim"},
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    { "folke/tokyonight.nvim" },
    { "romgrk/barbar.nvim", dependencies = { "lewis6991/gitsigns.nvim" } },
    { "nvimdev/dashboard-nvim", event = 'VimEnter', },
})
