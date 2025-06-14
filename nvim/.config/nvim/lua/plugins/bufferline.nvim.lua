return {
	"akinsho/bufferline.nvim",
	config = function()
		local ok, bufferline = pcall(require, "bufferline")
		if not ok then
			return
		end

		bufferline.setup({
			options = {
				numbers = function(opts)
					return string.format("%s", opts.ordinal)
				end,
				diagnostics = false,
				show_buffer_close_icons = false,
				show_close_icon = false,
				max_name_length = 80,
			},
		})
	end,
}
