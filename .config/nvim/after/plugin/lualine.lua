require("lualine").setup {
    options = {
      icons_enabled = true,
      theme = "onedark"
    },
    selections = {
      lualine_a = {
        {
          "filename",
          path = 1
        }
      }
    }
  }
