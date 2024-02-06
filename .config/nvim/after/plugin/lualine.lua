require("lualine").setup {
    options = {
      icons_enabled = true,
      theme = "catppuccin",
      section_separators = { left = "", right = "" },
    },
    selections = {
      lualine_a = {
        {
          "filename",
          path = 1,
        }
      }
    }
  }
