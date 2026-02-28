return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
      transparent_background = true,
      integrations = {
        nvimtree = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        barbar = true,
        gitsigns = true,
        indent_blankline = { enabled = true },
        which_key = true,
        lsp_trouble = true,
        mason = true,
        harpoon = true,
        dap = true,
        dap_ui = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors      = { "underline" },
            hints       = { "underline" },
            warnings    = { "underline" },
            information = { "underline" },
          },
        },
      },
    })
    vim.cmd.colorscheme("catppuccin")
  end,
}
