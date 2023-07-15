local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end

cmp.setup({
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "buffer" },
		{ name = "path" },
		{
			name = "dictionary",
			keyword_length = 2,
		},
		{ name = "nvim_lua" },
	},
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
	},
})

cmp.setup.cmdline("/", {
	completion = { autocomplete = false },
	sources = {
		{ name = "buffer", opts = { keyword_pattern = [=[[^[:blank:]].*]=] } },
	},
})

cmp.setup.cmdline(":", {
	completion = { autocomplete = false },
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})
