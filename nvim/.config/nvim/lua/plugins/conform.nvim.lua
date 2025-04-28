return {
	"stevearc/conform.nvim",
	opts = {
		notify_on_error = true,
		notify_no_formatters = true,
		format_on_save = false,
		formatters_by_ft = {
			lua = { "stylua" },
			rust = { "rustfmt", lsp_format = "fallback" },
			c = { "clang-format" },
			cpp = { "clang-format" },
			proto = { "clang-format" },
			python = function(bufnr)
				if require("conform").get_formatter_info("ruff_format", bufnr).available then
					return { "ruff_format" }
				else
					return { "black" }
				end
			end,
		},
		formatters = {
			rustfmt = {
				prepend_args = { "--edition=2021" },
			},
		},
	},
	config = function()
		local ok, conform = pcall(require, "conform")
		if not ok then
			return
		end

		vim.keymap.set("n", "<leader>cf", function()
			local success = conform.format({ async = true })
		end, { desc = "Format File" })

		vim.keymap.set("v", "<leader>cf", function()
			local success = conform.format({ async = true })
		end, { desc = "Format File" })
	end,
}
