vim.o.guifont = "Pes Code,LXGW WenKai GB Screen,Apple Symbols:h10"

-- local alpha = function()
--     return string.format("%x", math.floor(255 * vim.g.transparency or 0.9))
-- end
-- vim.g.neovide_background_color = "#0f1117" .. alpha()

vim.g.neovide_transparency = 0.9
vim.g.transparency = 0.9

vim.g.neovide_floating_blur_amount_x = 2.0
vim.g.neovide_floating_blur_amount_y = 2.0
vim.g.neovide_fullscreen = false
