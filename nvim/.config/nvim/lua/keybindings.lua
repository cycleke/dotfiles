local map = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true }

-- 切换 Tab
map("n", "<leader>1", "1gt<ct>", opt)
map("n", "<leader>2", "2gt<ct>", opt)
map("n", "<leader>3", "3gt<ct>", opt)
map("n", "<leader>4", "4gt<ct>", opt)
map("n", "<leader>5", "5gt<ct>", opt)

-- Visual 模式下缩进代码
map("v", "<", "<gv", opt)
map("v", ">", ">gv", opt)
