return {
	"saghen/blink.cmp",
	dependencies = { "rafamadriz/friendly-snippets" },
	version = "*",
	opts = {
		keymap = {
			preset = "enter",
		},

		completion = {
			-- Show completions after tying a trigger character, defined by the source
			trigger = { show_on_trigger_character = true },
			documentation = {
				-- Show documentation automatically
				auto_show = true,
			},
		},

		-- Signature help when tying
		signature = { enabled = true },
	},
	opts_extend = { "sources.default" },
}
