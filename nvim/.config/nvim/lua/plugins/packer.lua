-- 确保 Packer.nvim 安装
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end
local packer_bootstrap = ensure_packer()

vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	use("nvim-lua/plenary.nvim")

	-- 快捷键提示
	use("folke/which-key.nvim")

	-- 补全
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/cmp-nvim-lsp")
	use("gelguy/wilder.nvim")
	use("romgrk/fzy-lua-native")

	-- LSP
	use("neovim/nvim-lspconfig")
	use("jose-elias-alvarez/null-ls.nvim")

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})

	-- UI 设置
	use("kyazdani42/nvim-web-devicons")
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
		config = function()
			require("lualine").setup()
		end,
	})
	use("lukas-reineke/indent-blankline.nvim")
	use("akinsho/bufferline.nvim")
	use({
		"rose-pine/neovim",
		as = "rose-pine",
	})
	use({
		"f-person/auto-dark-mode.nvim",
		config = function()
			require("auto-dark-mode").setup({
				update_interval = 1000,
				set_dark_mode = function()
					vim.api.nvim_set_option("background", "dark")
					vim.cmd("colorscheme rose-pine")
				end,
				set_light_mode = function()
					vim.api.nvim_set_option("background", "light")
					vim.cmd("colorscheme rose-pine-dawn")
				end,
			})
			require("auto-dark-mode").init()
		end,
	})

	-- 文件搜索
	use("nvim-telescope/telescope.nvim")
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

	if packer_bootstrap then
		require("packer").sync()
	end
end)
