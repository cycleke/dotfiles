-- Auto Update Buffer
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
	pattern = { "*" },
	command = "checktime",
})
vim.opt.autoread = true
vim.opt.updatetime = 300

-- Enable Lua loader
vim.loader.enable()

-- Disable backup files
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = false
vim.opt.autowrite = true

-- Clipboard
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.mouse = "a"

-- Tab
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.autoindent = true

-- vim.opt.list = true
-- vim.opt.listchars:append("trail:»")
-- vim.opt.listchars:append("tab:»-")

-- Searching
vim.opt.incsearch = true
vim.opt.hlsearch = false
vim.opt.smartcase = true
vim.opt.ignorecase = true

-- UI
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.showmode = false
vim.opt.termguicolors = true
vim.opt.colorcolumn = "120"

vim.api.nvim_create_autocmd({ "FocusLost", "InsertEnter" }, {
	pattern = { "*" },
	command = "set norelativenumber number",
})
vim.api.nvim_create_autocmd({ "FocusGained", "InsertLeave" }, {
	pattern = { "*" },
	command = "set relativenumber",
})

-- Encoding
vim.opt.encoding = "utf-8"
vim.opt.fileencodings = "utf-8,gb2312,gbk,gb18030,ucs-bom,cp936,big5,euc-jp,euc-kr,latin1"
vim.opt.fileformats = "unix,dos,mac"
