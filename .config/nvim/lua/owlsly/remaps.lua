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

-- Trouble
vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end)
vim.keymap.set("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end)
vim.keymap.set("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end)
vim.keymap.set("n", "<leader>xq", function() require("trouble").toggle("quickfix") end)
vim.keymap.set("n", "<leader>xl", function() require("trouble").toggle("loclist") end)
vim.keymap.set("n", "gR", function() require("trouble").toggle("lsp_references") end)

--map("n", "", "", opts)
--map("n", "", "", opts)
--map("n", "", "", opts)
--map("n", "", "", opts)
--map("n", "", "", opts)
--map("n", "", "", opts)
--map("n", "", "", opts)

