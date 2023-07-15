-- 自动更新文件
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
	pattern = { "*" },
	command = "checktime",
})
vim.opt.autoread = true
vim.opt.updatetime = 300

-- 设置 leader 键为逗号
vim.g.mapleader = ","

-- 提升 Lua 加载速度
vim.loader.enable()

-- 避免失败
vim.opt.hidden = true

-- 各种文件设置
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = false
vim.opt.autowrite = true

-- 剪切板设置
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.mouse = "a"

-- 补全增强
vim.opt.wildmenu = true

-- 缩进设置
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.autoindent = true

vim.opt.list = true
vim.opt.listchars:append("trail:»")
vim.opt.listchars:append("tab:»-")

-- 搜索设置
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.smartcase = true
vim.opt.ignorecase = true

-- UI 设置
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.showmode = false
-- vim.opt.colorcolumn = "80,100,120"

-- 编码设置
vim.opt.encoding = "utf-8"
vim.opt.fileencodings = "utf-8,gb2312,gbk,gb18030,ucs-bom,cp936,big5,euc-jp,euc-kr,latin1"
vim.opt.fileformats = "unix,dos,mac"

-- 插入模式下用绝对行号, 普通模式下用相对
vim.opt.number = true
vim.opt.relativenumber = true
vim.api.nvim_create_autocmd({ "FocusLost", "InsertEnter" }, {
	pattern = { "*" },
	command = "set norelativenumber number",
})
vim.api.nvim_create_autocmd({ "FocusGained", "InsertLeave" }, {
	pattern = { "*" },
	command = "set relativenumber",
})
