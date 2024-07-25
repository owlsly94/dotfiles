require("tokyonight").setup({
  style = "night",
--  style = "storm",
--  style = "moon",
  transparent = true,
  styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
    functions = {}, -- Change the style of comments
  },
})

vim.cmd[[colorscheme tokyonight]]
vim.cmd[[hi Normal guibg=NONE ctermbg=NONE]]

--require("catppuccin").setup({
--  flavour = "mocha",
--  transparent_background = true,
--  styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
--    comments = { "italic" }, -- Change the style of comments
--  },
--})
--
--vim.o.termguicolors = true
--vim.o.background = "dark"
--vim.cmd[[colorscheme catppuccin]]
