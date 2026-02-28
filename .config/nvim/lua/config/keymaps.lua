local map = function(mode, lhs, rhs, opts)
  opts = vim.tbl_extend("force", { noremap = true, silent = true }, opts or {})
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- NvimTree
map("n", "<leader>m", ":NvimTreeToggle<CR>")

-- Telescope
map("n", "<leader>ff", ":Telescope find_files<CR>")
map("n", "<leader>fh", ":Telescope help_tags<CR>")

-- Select all
map("n", "<C-a>", "gg<S-v>G")

-- Tabs
map("n", "te", ":tabedit")
map("n", "<tab>", "<Cmd>BufferNext<CR>")
map("n", "<S-tab>", ":tabprev<Return>")

-- Split window
map("n", "ss", ":split<Return>")
map("n", "sv", ":vsplit<Return>")

-- Move between windows
map("n", "sh", "<C-w>h")
map("n", "sk", "<C-w>k")
map("n", "sj", "<C-w>j")
map("n", "sl", "<C-w>l")

-- Buffers (barbar)
map("n", "qq", "<Cmd>BufferClose<CR>")
map("n", "qa", ":BufferCloseAllButCurrent<Return>")
