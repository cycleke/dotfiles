return {
	"folke/which-key.nvim",
	config = function()
		local ok, which_key = pcall(require, "which-key")
		if not ok then
			return
		end

		vim.opt.timeout = true
		vim.opt.timeoutlen = 300
		which_key.setup()
	end,
}
