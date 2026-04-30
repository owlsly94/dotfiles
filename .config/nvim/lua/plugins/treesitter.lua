return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({
        ensure_installed = { "c", "lua", "vim", "python", "css", "html", "javascript", "haskell" },
        sync_install = false,
        auto_install = false,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
          disable = function(_, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local filename = vim.api.nvim_buf_get_name(buf)
            if not filename or filename == "" then return false end
            local ok, stats = pcall(vim.loop.fs_stat, filename)
            if ok and stats and stats.size > max_filesize then return true end
            return false
          end,
        },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("treesitter-context").setup()
    end,
  },
}
