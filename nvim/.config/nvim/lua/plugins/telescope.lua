local ok, telescope = pcall(require, "telescope")
if not ok then
	return
end

telescope.setup({
	defaults = {
		mappings = {
			i = {
				["<C-h>"] = "which_key",
			},
		},
	},

	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "respect_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
	},
})

telescope.load_extension("fzf")

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = "Telescope fuzzy find current buffer" })
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fs", builtin.grep_string, { desc = "Telescope grep string" })
