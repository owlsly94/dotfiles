require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "vim", "python", "css", "html", "javascript", "haskell" },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    disable = function(_, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local filename = vim.api.nvim_buf_get_name(buf)
        local handle = io.popen("stat -c %s " .. filename)
        if handle then
          local result = handle:read("*a")
          handle:close()
          if result and tonumber(result) > max_filesize then
            return true
          end
        end
        return false
    end,
    additional_vim_regex_highlighting = false,
  },
}
