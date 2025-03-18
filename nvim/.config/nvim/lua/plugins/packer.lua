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
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
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
		"miikanissi/modus-themes.nvim",
		config = function()
			require("modus-themes").setup({
				style = "auto",
				variant = "deuteranopia",
				styles = {
					comments = { italic = true },
				},
			})
			vim.cmd([[colorscheme modus]])
		end,
	})

	use({
		"stevearc/conform.nvim",
		config = function()
			local conform = require("conform")
			conform.setup({
				log_level = vim.log.levels.ERROR,
				notify_on_error = true,
				notify_no_formatters = true,
				format_on_save = false,
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "black" },
					rust = { "rustfmt" },
					javascript = { "prettier" },
					sh = { "shfmt" },
					c = { "clang-format" },
					cpp = { "clang-format" },
					proto = { "clang-format" },
				},
				formatters = {
					rustfmt = {
						prepend_args = { "--edition=2021" },
					},
				},
			})
			vim.keymap.set("n", "<leader>cf", function()
				local success = conform.format({ async = true })
			end, { desc = "Format File" })
			vim.keymap.set("v", "<leader>cf", function()
				local success = conform.format({ async = true })
			end, { desc = "Format File" })
		end,
	})

	-- 文件搜索
	use("nvim-telescope/telescope.nvim")
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

	if packer_bootstrap then
		require("packer").sync()
	end
end)
