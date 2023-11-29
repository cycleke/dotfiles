-- 基础配置
require("basic")
require("keybindings")

-- 插件
require("plugins.packer")
require("plugins.which-key")
require("plugins.cmp")
require("plugins.wilder")
require("plugins.indent-blankline")
require("plugins.bufferline")
require("plugins.telescope")

-- LSP
require("lsp.setup")
require("lsp.null-ls")

-- Neovide 配置
if vim.g.neovide then
	require("neovide")
end
