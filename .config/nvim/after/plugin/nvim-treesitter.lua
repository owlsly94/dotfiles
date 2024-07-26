require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "vim", "python", "css", "html", "javascript", "haskell" },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    disable = function(_, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local filename = vim.api.nvim_buf_get_name(buf)

        -- Ensure the filename is valid and not empty
        if not filename or filename == "" then
          return false
        end

        local handle = io.popen("stat -c %s " .. filename)
        if handle then
          local result = handle:read("*a")
          handle:close()

          -- Ensure the result is valid and convert to number
          local file_size = tonumber(result)
          -- Log only if file_size is nil
          if not file_size then
            print("Error: Unable to determine file size for " .. filename)
          elseif file_size > max_filesize then
            return true
          end
        else
          print("Error: Unable to open handle for " .. filename)
        end
        return false
    end,
    additional_vim_regex_highlighting = false,
  },
}

