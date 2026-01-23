local status, configs = pcall(require, "nvim-treesitter.configs")

if not status then
    return
end

configs.setup {
  ensure_installed = { "c", "lua", "vim", "python", "css", "html", "javascript", "haskell" },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    disable = function(_, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local filename = vim.api.nvim_buf_get_name(buf)

        if not filename or filename == "" then
            return false
        end

        local ok, stats = pcall(vim.loop.fs_stat, filename)
        if ok and stats and stats.size > max_filesize then
            return true
        end

        return false
    end,
    additional_vim_regex_highlighting = false,
  },
}
