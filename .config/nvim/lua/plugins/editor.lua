return {
  -- Git signs
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add          = { text = " " },
          change       = { text = " " },
          delete       = { text = "󰆴" },
          topdelete    = { text = "‾" },
          changedelete = { text = "~" },
          untracked    = { text = "┆" },
        },
        signcolumn = true,
        numhl      = false,
        linehl     = false,
        word_diff  = false,
        watch_gitdir     = { follow_files = true },
        auto_attach      = true,
        attach_to_untracked = false,
        current_line_blame = false,
        current_line_blame_opts = {
          virt_text     = true,
          virt_text_pos = "eol",
          delay         = 1000,
          ignore_whitespace = false,
          virt_text_priority = 100,
        },
        current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
        sign_priority  = 6,
        update_debounce = 100,
        max_file_length = 40000,
        preview_config = {
          border   = "single",
          style    = "minimal",
          relative = "cursor",
          row = 0, col = 1,
        },
      })
    end,
  },

  -- Lazygit
  {
    "kdheepak/lazygit.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- DAP (debugging)
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      { "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
      "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
      require("dapui").setup()
      require("nvim-dap-virtual-text").setup()
    end,
  },

  -- Trouble
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup({
        signs = {
          error       = "",
          warning     = "",
          information = "",
          other       = "",
        },
      })
      local trouble = require("trouble")
      local map = function(k, fn) vim.keymap.set("n", k, fn, { noremap = true, silent = true }) end
      map("<leader>xx", function() trouble.toggle() end)
      map("<leader>xw", function() trouble.toggle("workspace_diagnostics") end)
      map("<leader>xd", function() trouble.toggle("document_diagnostics") end)
      map("<leader>xq", function() trouble.toggle("quickfix") end)
      map("<leader>xl", function() trouble.toggle("loclist") end)
      map("gR",         function() trouble.toggle("lsp_references") end)
    end,
  },

  -- Surround
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end,
  },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true,
        ts_config = {
          lua        = { "string" },
          javascript = { "template_string" },
          java       = false,
        },
      })
    end,
  },

  -- Autotag
  {
    "windwp/nvim-ts-autotag",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

  -- Comment
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = function()
      require("Comment").setup()
    end,
  },

  -- Undotree
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
  },

  -- Harpoon (v1)
  {
    "ThePrimeagen/harpoon",
    branch = "master",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("harpoon").setup()
    end,
  },

  -- Spectre (find & replace)
  {
    "nvim-pack/nvim-spectre",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Spectre",
  },
}
