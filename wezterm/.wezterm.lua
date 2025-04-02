local wezterm = require("wezterm")
local act = wezterm.action

local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

local LIGHT_COLOR_SCHEME = "Ef-Deuteranopia-Light"
local DARK_COLOR_SCHEME = "Ef-Deuteranopia-Dark"

local fallback_fonts = {}

if wezterm.target_triple:find("windows") then
	config.default_prog = { "nu.exe", "--login" }
	config.win32_system_backdrop = "Acrylic"

	fallback_fonts = {
		"Symbols Nerd Font",
		"Noto Color Emoji",
		"Noto Sans Symbols 2",
		"Noto Sans Symbols",
		"TH-Ming-P2",
		"Noto Unicode",
	}
elseif wezterm.target_triple:find("darwin") then
	config.default_prog = { "zsh", "--login" }
	config.macos_window_background_blur = 16
	config.native_macos_fullscreen_mode = true

	fallback_fonts = {
		"Symbols Nerd Font",
		"Apple Symbols",
		"Apple Color Emoji",
		"Apple Symbols",
		"TH-Ming-P2",
		"Noto Unicode",
	}
elseif wezterm.target_triple:find("linux") then
	config.default_prog = { "zsh", "--login" }

	fallback_fonts = {
		"Symbols Nerd Font",
		"Noto Color Emoji",
		"Noto Sans Symbols 2",
		"Noto Sans Symbols",
		"TH-Ming-P2",
		"Noto Unicode",
	}
end

local function fonts_with_fallback(fonts)
	for _, font in ipairs(fallback_fonts) do
		table.insert(fonts, font)
	end
	return wezterm.font_with_fallback(fonts)
end
local MONASPACE_ENABLE_FEATURES = {
	"calt",
	"ss01",
	"ss02",
	"ss03",
	"ss04",
	"ss07",
	"liga",
	"cv01=2",
}

local TERM_FONTS = fonts_with_fallback({
	{
		family = "Maple Mono NF CN",
		harfbuzz_features = { "liga", "cv02" },
	},
})
local CODE_FONTS = fonts_with_fallback({
	{
		family = "Monaspace Neon",
		harfbuzz_features = MONASPACE_ENABLE_FEATURES,
	},
	"KingHwa_OldSong",
})
local HANDWRITING_FONTS = fonts_with_fallback({
	{
		family = "Monaspace Radon",
		harfbuzz_features = MONASPACE_ENABLE_FEATURES,
	},
	"ToneOZ-Tsuipita-TC",
})

local PROFILES = {
	default = {},
	editor = {
		font = CODE_FONTS,
		font_size = 14,
		font_rules = {
			{
				italic = true,
				font = HANDWRITING_FONTS,
			},
		},
		-- hide_tab_bar_if_only_one_tab = true,
	},
}

config.check_for_updates = false
config.audible_bell = "Disabled"
config.selection_word_boundary = " \t\n{}[]()<>\"'`"

config.color_scheme = LIGHT_COLOR_SCHEME
config.default_cursor_style = "SteadyBlock"

config.font = TERM_FONTS
config.font_size = 15
config.adjust_window_size_when_changing_font_size = false

config.window_background_opacity = 0.9
config.text_background_opacity = 0.3

config.window_padding = {
	left = "0.5cell",
	right = "0.3cell",
	top = "0.3cell",
	bottom = "0.3cell",
}
config.window_frame = {
	font = wezterm.font({
		family = "Monaspace Krypton",
	}),
	font_size = 12,
}

config.enable_tab_bar = true
config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.show_tab_index_in_tab_bar = true
config.tab_bar_at_bottom = false
config.switch_to_last_active_tab_when_closing_tab = false
config.window_decorations = "INTEGRATED_BUTTONS | RESIZE"

-- Keybindings
config.disable_default_key_bindings = true
config.keys = {
	{ key = "q", mods = "SUPER", action = act.QuitApplication },

	{ key = "p", mods = "CTRL|SHIFT", action = act.ActivateCommandPalette },

	{ key = "Copy", mods = "", action = act.CopyTo("Clipboard") },
	{ key = "Paste", mods = "", action = act.PasteFrom("Clipboard") },
	{ key = "c", mods = "SUPER", action = act.CopyTo("Clipboard") },
	{ key = "v", mods = "SUPER", action = act.PasteFrom("Clipboard") },
	{ key = "c", mods = "CTRL|SHIFT", action = act.CopyTo("Clipboard") },
	{ key = "v", mods = "CTRL|SHIFT", action = act.PasteFrom("Clipboard") },

	{ key = "n", mods = "SUPER", action = act.SpawnWindow },
	{ key = "n", mods = "CTRL|SHIFT", action = act.SpawnWindow },

	{ key = "n", mods = "ALT", action = act.ShowLauncher },

	{ key = "t", mods = "SUPER", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "t", mods = "CTRL|SHIFT", action = act.SpawnTab("CurrentPaneDomain") },

	{ key = "0", mods = "CTRL", action = act.ResetFontSize },
	{ key = "=", mods = "CTRL", action = act.IncreaseFontSize },
	{ key = "-", mods = "CTRL", action = act.DecreaseFontSize },
	{ key = "Enter", mods = "ALT", action = act.ToggleFullScreen },

	{
		key = "w",
		mods = "SUPER",
		action = act.CloseCurrentPane({ confirm = true }),
	},
	{
		key = "w",
		mods = "CTRL|SHIFT",
		action = act.CloseCurrentPane({ confirm = true }),
	},

	{ key = "Tab", mods = "CTRL", action = act.ActivateTabRelative(1) },
	{ key = "Tab", mods = "CTRL|SHIFT", action = act.ActivateTabRelative(-1) },

	{ key = "j", mods = "CTRL|SHIFT", action = act.ActivateTabRelative(-1) },
	{ key = "k", mods = "CTRL|SHIFT", action = act.ActivateTabRelative(1) },

	{ key = "{", mods = "CTRL|SHIFT", action = act.MoveTabRelative(-1) },
	{ key = "}", mods = "CTRL|SHIFT", action = act.MoveTabRelative(1) },

	{ key = "1", mods = "SUPER", action = act.ActivateTab(0) },
	{ key = "2", mods = "SUPER", action = act.ActivateTab(1) },
	{ key = "3", mods = "SUPER", action = act.ActivateTab(2) },
	{ key = "4", mods = "SUPER", action = act.ActivateTab(3) },
	{ key = "5", mods = "SUPER", action = act.ActivateTab(4) },
	{ key = "6", mods = "SUPER", action = act.ActivateTab(5) },
	{ key = "7", mods = "SUPER", action = act.ActivateTab(6) },
	{ key = "8", mods = "SUPER", action = act.ActivateTab(7) },
	{ key = "9", mods = "SUPER", action = act.ActivateTab(8) },
	{ key = "0", mods = "SUPER", action = act.ActivateTab(-1) },

	{ key = "1", mods = "CTRL|SHIFT", action = act.ActivateTab(0) },
	{ key = "2", mods = "CTRL|SHIFT", action = act.ActivateTab(1) },
	{ key = "3", mods = "CTRL|SHIFT", action = act.ActivateTab(2) },
	{ key = "4", mods = "CTRL|SHIFT", action = act.ActivateTab(3) },
	{ key = "5", mods = "CTRL|SHIFT", action = act.ActivateTab(4) },
	{ key = "6", mods = "CTRL|SHIFT", action = act.ActivateTab(5) },
	{ key = "7", mods = "CTRL|SHIFT", action = act.ActivateTab(6) },
	{ key = "8", mods = "CTRL|SHIFT", action = act.ActivateTab(7) },
	{ key = "9", mods = "CTRL|SHIFT", action = act.ActivateTab(8) },
	{ key = "0", mods = "CTRL|SHIFT", action = act.ActivateTab(-1) },
}

config.disable_default_mouse_bindings = true
config.mouse_bindings = {
	{
		event = { Down = { streak = 1, button = "Left" } },
		mods = "NONE",
		action = act.SelectTextAtMouseCursor("Cell"),
	},
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "NONE",
		action = act.ExtendSelectionToMouseCursor("Cell"),
	},
	{
		event = { Drag = { streak = 1, button = "Left" } },
		mods = "NONE",
		action = act.ExtendSelectionToMouseCursor("Cell"),
	},
	-- Double Left click will select a word
	{
		event = { Down = { streak = 2, button = "Left" } },
		mods = "NONE",
		action = act.SelectTextAtMouseCursor("Word"),
	},
	{
		event = { Drag = { streak = 2, button = "Left" } },
		mods = "NONE",
		action = act.ExtendSelectionToMouseCursor("Cell"),
	},
	-- Triple Left click will select a line
	{
		event = { Down = { streak = 3, button = "Left" } },
		mods = "NONE",
		action = act.SelectTextAtMouseCursor("Line"),
	},
	{
		event = { Drag = { streak = 3, button = "Left" } },
		mods = "NONE",
		action = act.ExtendSelectionToMouseCursor("Cell"),
	},
	-- Turn on the mouse wheel to scroll the screen
	{
		event = { Down = { streak = 1, button = { WheelUp = 1 } } },
		mods = "NONE",
		action = act.ScrollByCurrentEventWheelDelta,
	},
	{
		event = { Down = { streak = 1, button = { WheelDown = 1 } } },
		mods = "NONE",
		action = act.ScrollByCurrentEventWheelDelta,
	},
	-- Ctrl-click will open the link
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = act.OpenLinkAtMouseCursor,
	},
}

local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return DARK_COLOR_SCHEME
	else
		return LIGHT_COLOR_SCHEME
	end
end

wezterm.on("window-config-reloaded", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	local appearance = window:get_appearance()
	local scheme = scheme_for_appearance(appearance)
	if overrides.color_scheme ~= scheme then
		overrides.color_scheme = scheme
		window:set_config_overrides(overrides)
	end
end)

local function tab_title(tab_info)
	local title = tab_info.tab_title
	-- if the tab title is explicitly set, take that
	if title and #title > 0 then
		return title
	end
	-- Otherwise, use the title from the active pane in that tab
	return tab_info.active_pane.title
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local NORD_COLOR_SCHEME = wezterm.get_builtin_color_schemes()["nord"]

	local background = NORD_COLOR_SCHEME.ansi[1]
	local foreground = NORD_COLOR_SCHEME.ansi[6]
	local title_prefix = tostring(tab.tab_index + 1) .. "."

	if tab.is_active then
		-- Symbols: "🎸" "§ "
		title_prefix = "§ "

		background = NORD_COLOR_SCHEME.brights[1]
		foreground = NORD_COLOR_SCHEME.brights[4]
	elseif hover then
		background = NORD_COLOR_SCHEME.cursor_bg
		foreground = NORD_COLOR_SCHEME.cursor_fg
	end

	local title_content = tab_title(tab)
	local pane = tab.active_pane

	if pane.domain_name then
		local domain_suffix = pane.domain_name

		if domain_suffix == "devcloud" then
			domain_suffix = " ☁️"
		elseif domain_suffix == "bastion" then
			domain_suffix = " 🔗"
		elseif domain_suffix == "local" then
			domain_suffix = " 🖥️"
		else
			domain_suffix = " - (" .. domain_suffix .. ")"
		end

		if title_content and #title_content > 0 then
			title_content = title_content .. domain_suffix
		else
			title_content = "∅" .. domain_suffix
		end
	end

	title_content = wezterm.truncate_right(title_content, max_width)

	return {
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },

		{ Attribute = { Intensity = "Normal" } },
		{ Text = title_prefix },

		{ Attribute = { Intensity = "Bold" } },
		{ Text = title_content },

		{ Attribute = { Intensity = "Normal" } },
	}
end)

wezterm.on("format-window-title", function(tab, pane, tabs, panes, config)
	-- local status = ""
	-- if tab.active_pane.is_zoomed then
	-- 	status = status .. "Z,"
	-- end

	-- if #status > 0 then
	-- 	status = "[" .. status:sub(1, -2) .. "]"
	-- end

	-- return title .. " " .. status

	local pane = tab.active_pane
	local title = pane.domain_name .. " - WezTerm"
	local tab_title = tab.tab_title
	if #tab_title > 0 then
		title = tab_title .. " - WezTerm"
	end

	return title
end)

local act_change_profile_choices = {}
for key, _ in pairs(PROFILES) do
	table.insert(act_change_profile_choices, { label = key })
end

local act_change_profile = act.InputSelector({
	title = wezterm.format({
		{ Attribute = { Intensity = "Bold" } },
		{ Foreground = { AnsiColor = "Fuchsia" } },
		{ Text = "Change Window Profile." },
	}),

	choices = act_change_profile_choices,

	action = wezterm.action_callback(function(window, pane, id, label)
		if not id and not label then
			wezterm.log_info("Profile change cancelled")
		else
			wezterm.log_info("You selected profile: ", label)

			local profile = PROFILES[label]
			if profile ~= nil then
				window:set_config_overrides(profile)
			else
				wezterm.log_error("Unknown profile: ", id, label)
			end
		end
	end),
})

local act_rename_tab = act.PromptInputLine({
	description = wezterm.format({
		{ Attribute = { Intensity = "Bold" } },
		{ Foreground = { AnsiColor = "Fuchsia" } },
		{ Text = "Enter new name for this tab:" },
	}),
	action = wezterm.action_callback(function(window, pane, line)
		if line and #line > 0 then
			window:active_tab():set_title(line)
		end
	end),
})

wezterm.on("augment-command-palette", function(window, pane)
	return {
		{
			brief = "Change Window Profile.",
			icon = "md_format_font",
			action = act_change_profile,
		},
		{
			brief = "Rename tab",
			icon = "md_rename_box",
			action = act_rename_tab,
		},
	}
end)

wezterm.on("trigger-editor-profile", function(window, pane)
	local old_overrides = window:get_config_overrides() or {}
	local new_overrides = nil
	if old_overrides.font == nil then
		new_overrides = PROFILES["editor"]
	else
		new_overrides = PROFILES["default"]
	end

	new_overrides.color_scheme = old_overrides.color_scheme
	window:set_config_overrides(new_overrides)
end)

table.insert(config.keys, {
	key = "m",
	mods = "CTRL|SHIFT",
	action = act_rename_tab,
})
table.insert(config.keys, {
	key = "?",
	mods = "CTRL|SHIFT",
	action = act.EmitEvent("trigger-editor-profile"),
})

-- Custom Begin
-- Custom End

return config
