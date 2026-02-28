return {
  -- File tree
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        sort = { sorter = "case_sensitive" },
        view = { width = 30 },
        renderer = { group_empty = true },
        filters = { dotfiles = false },
      })
    end,
  },

  -- Icons
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup()
      telescope.load_extension("fzf")
    end,
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "tokyonight",
          component_separators = { left = "", right = "" },
          section_separators   = { left = "◗", right = "◖" },
          disabled_filetypes = { statusline = {}, winbar = {} },
          always_divide_middle = true,
          globalstatus = false,
          refresh = { statusline = 1000, tabline = 1000, winbar = 1000 },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { "filename" },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_c = { "filename" },
          lualine_x = { "location" },
        },
      })
    end,
  },

  -- Bufferline (barbar)
  {
    "romgrk/barbar.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("barbar").setup()
    end,
  },

  -- Dashboard
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("dashboard").setup({
        theme = "hyper",
        config = {
          header = {
            "",
            "",
            "  ██████╗ ██╗    ██╗██╗     ███████╗██╗  ██╗   ██╗ ",
            " ██╔═══██╗██║    ██║██║     ██╔════╝██║  ╚██╗ ██╔╝ ",
            " ██║   ██║██║ █╗ ██║██║     ███████╗██║   ╚████╔╝  ",
            " ██║   ██║██║███╗██║██║     ╚════██║██║    ╚██╔╝   ",
            " ╚██████╔╝╚███╔███╔╝███████╗███████║███████╗██║    ",
            "  ╚═════╝  ╚══╝╚══╝ ╚══════╝╚══════╝╚══════╝╚═╝    ",
            "",
            "",
          },
          shortcut = {
            { desc = "  Files", group = "Label", action = "Telescope find_files", key = "f" },
            { desc = "󰗼  Exit",  group = "",      action = "exit",                 key = "q" },
          },
        },
      })
    end,
  },

  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup({
        indent = { char = "│", tab_char = "│" },
        scope = { enabled = true, show_start = true, show_end = false },
        exclude = {
          filetypes = { "help", "dashboard", "neo-tree", "trouble", "lazy", "mason", "notify", "toggleterm" },
          buftypes  = { "terminal", "nofile" },
        },
      })
    end,
  },

  -- Which-key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup()
    end,
  },

  -- Colorizer
  {
    "NvChad/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({
        filetypes = { "*", "!vim" },
        options = {
          parsers = {
            css     = true,
            css_fn  = true,
            names   = { enable = false },
          },
          display = { mode = "background" },
        },
      })
    end,
  },

  -- Wilder (command line suggestions)
  {
    "gelguy/wilder.nvim",
    config = function()
      local wilder = require("wilder")
      wilder.setup({ modes = { ":", "/", "?" } })
    end,
  },
}
