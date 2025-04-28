return {
	"miikanissi/modus-themes.nvim",
	config = function()
		local ok, modus = pcall(require, "modus-themes")
		if not ok then
			return
		end

		modus.setup({
			style = "auto",
			variant = "deuteranopia",
			styles = {
				comments = { italic = true },
			},
		})
		vim.cmd([[colorscheme modus]])
	end,
}
