require("tokyonight").setup({
  style = "night",
  transparent = true,
  styles = {
    functions = {},
  },
})

vim.cmd[[colorscheme tokyonight]]
vim.cmd[[hi Normal guibg=NONE ctermbg=NONE]]
