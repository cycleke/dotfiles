vim.opt.guifont = "Monaspace Neon Var,LXGW Neo ZhiSong,Symbols Nerd Font Mono:h12"

vim.g.neovide_title_background_color =
	string.format("%x", vim.api.nvim_get_hl(0, { id = vim.api.nvim_get_hl_id_by_name("Normal") }).bg)

vim.g.neovide_title_text_color = "pink"

vim.g.neovide_floating_blur_amount_x = 2.0
vim.g.neovide_floating_blur_amount_y = 2.0

vim.g.neovide_opacity = 0.9
vim.g.neovide_normal_opacity = 0.9

vim.g.neovide_hide_mouse_when_typing = true

vim.g.neovide_theme = "auto"
