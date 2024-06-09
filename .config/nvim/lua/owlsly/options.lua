local options = {
	autoindent = true,
	smartindent = true,
	tabstop = 2,
	shiftwidth = 2,
	expandtab = true,
	showtabline = 0,

	number = true,
	relativenumber = true,
	numberwidth = 4,
	incsearch = true,
	hlsearch = true,
	ignorecase = true,
	smartcase = true,

	splitbelow = true,
	splitright = true,

	termguicolors = true,
	hidden = true,
	signcolumn = "yes",
	showmode = false,
	errorbells = false,
	wrap = false,
	cursorline = true,
	fileencoding = "utf-8",
  clipboard = 'unnamedplus',

	backup = false,
	writebackup = false,
	swapfile = false,

	scrolloff = 5,
	scrolljump = 5,
  mouse = "a",
  guicursor = "a:block",

  title = true

	}


for option, value in pairs(options) do 
  vim.opt[option] = value 
end
