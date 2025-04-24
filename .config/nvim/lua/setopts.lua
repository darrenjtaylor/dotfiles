vim.opt.guicursor = ""
vim.opt.updatetime = 50

-- Indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Line numbers, signs and layout
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- Text wrap scrolling and colors
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.colorcolumn = "80"
vim.opt.cursorline = true
vim.opt.termguicolors = true

-- Swap and backup files
vim.opt.swapfile = false
vim.opt.backup = false

-- Undos
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Clipboard
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- Highlights and searching
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Configure diagnostics
vim.diagnostic.config({
	virtual_text = false,
	float = {
		header = false,
		border = "rounded",
		focusable = true,
	},
})
