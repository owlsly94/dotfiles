local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Tree
map("n", "<leader>m", ":NvimTreeToggle<CR>", opts)

-- Telescope
map("n", "<leader>ff", ":Telescope find_files<CR>", opts)
map("n", "<leader>fh", ":Telescope help_tags<CR>", opts)

-- Select all
map("n", "<C-a>", "gg<S-v>G", opts)

-- Split window
map("n", "ss", ":split<Return>", opts)
map("n", "sv", ":vsplit<Return>", opts)

-- Move windows 
map("n", "sh", "<C-w>h", opts)
map("n", "sk", "<C-w>k", opts)
map("n", "sj", "<C-w>j", opts)
map("n", "sl", "<C-w>l", opts)

-- Lazy
map("n", "<leader>l", ":Lazy<Return>", opts)

-- Move between buffers
map("n", "<tab>", "<Cmd>BufferNext<CR>", opts)

-- Close buffers
map("n", "qq", "<Cmd>BufferClose<CR>", opts)
map("n", "qa", ":BufferCloseAllButCurrent<Return>", opts)
--map("n", "", "", opts)
--map("n", "", "", opts)
--map("n", "", "", opts)
--map("n", "", "", opts)
--map("n", "", "", opts)
--map("n", "", "", opts)
--map("n", "", "", opts)

