local wezterm = require("wezterm")
local act = wezterm.action

local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

local launch_menu = {}
local default_prog = {}
local fallback_fonts = {}

local light_theme = "Ef-Deuteranopia-Light"
local dark_theme = "Ef-Deuteranopia-Dark"

if wezterm.target_triple:find("windows") then
	-- default_prog = { "powershell" }
	default_prog = { "nu.exe", "--login" }

	fallback_fonts = {
		"Symbols Nerd Font",
		"Planschrift P1",
		"Planschrift P2",
		"Noto Color Emoji",
		"Noto Sans Symbols 2",
		"Noto Sans Symbols",
	}
elseif wezterm.target_triple:find("darwin") then
	default_prog = { "zsh", "--login" }
	config.macos_window_background_blur = 8
	config.front_end = "WebGpu"
	config.webgpu_power_preference = "HighPerformance"

	fallback_fonts = {
		"Symbols Nerd Font",
		"Planschrift P1",
		"Planschrift P2",
		"Apple Color Emoji",
		"Apple Symbols",
	}
elseif wezterm.target_triple:find("linux") then
	default_prog = { "zsh", "--login" }

	fallback_fonts = {
		"Symbols Nerd Font",
		"Planschrift P1",
		"Planschrift P2",
		"Noto Color Emoji",
		"Noto Sans Symbols 2",
		"Noto Sans Symbols",
	}
end

local function fonts_with_fallback(fonts)
	for _, font in ipairs(fallback_fonts) do
		table.insert(fonts, font)
	end
	return wezterm.font_with_fallback(fonts)
end

local monaspace_features = {
	"calt",
	"ss02",
	"ss03",
	"ss04",
	"ss06",
	"ss07",
	"ss08",
	"ss09",
	"liga",
}

local profiles = {
	Default = {},
	Editor = {
		font = fonts_with_fallback({
			-- { family = "Lilex", harfbuzz_features = { "zero", "cv03", "cv09" } },
			{
				family = "Monaspace Neon Var",
				harfbuzz_features = monaspace_features,
			},
			"LXGW Neo ZhiSong",
		}),
		font_size = 14,
		font_rules = {
			{
				italic = true,
				font = fonts_with_fallback({
					{
						family = "Monaspace Radon Var",
						harfbuzz_features = monaspace_features,
					},
					"LXGW WenKai TC",
				}),
			},
		},
		-- hide_tab_bar_if_only_one_tab = true,
	},
}

-- 基础配置
config.check_for_updates = false
config.audible_bell = "Disabled"
config.selection_word_boundary = " \t\n{}[]()<>\"'`"

-- UI
config.color_scheme = light_theme
config.default_cursor_style = "SteadyBlock"
config.foreground_text_hsb = {
	hue = 1.0,
	saturation = 1.2,
	brightness = 1.5,
}

-- Font
config.font = fonts_with_fallback({ "Maple Mono NF", "Huiwen-MinchoGBK" })
config.font_size = 14
config.freetype_load_target = "Normal"
config.enable_kitty_graphics = true

-- Window
config.native_macos_fullscreen_mode = true
config.adjust_window_size_when_changing_font_size = false
config.window_background_opacity = 0.9
config.text_background_opacity = 0.3
config.macos_window_background_blur = 10
config.window_padding = {
	left = "0.5cell",
	right = "0.3cell",
	top = "0.3cell",
	bottom = "0.3cell",
}
config.window_background_image_hsb = {
	brightness = 0.8,
	hue = 1.0,
	saturation = 1.0,
}

-- Tab Bar
config.enable_tab_bar = true
config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.show_tab_index_in_tab_bar = true
config.tab_bar_at_bottom = false
config.tab_max_width = 30
config.switch_to_last_active_tab_when_closing_tab = false
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

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

	{ key = "j", mods = "CTRL|SHIFT", action = act.ActivateTabRelative(-1) },
	{ key = "k", mods = "CTRL|SHIFT", action = act.ActivateTabRelative(1) },
	{ key = "{", mods = "CTRL|SHIFT", action = act.MoveTabRelative(-1) },
	{ key = "}", mods = "CTRL|SHIFT", action = act.MoveTabRelative(1) },

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
		return dark_theme
	else
		return light_theme
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

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local title_prefix = (tab.is_active and "🎸 ") or ""
	local pane = tab.active_pane

	local title_content = ""
	local tab_title = tab.tab_title
	if tab_title and #tab_title > 0 then
		title_content = tab_title
	end

	if pane.domain_name then
		if title_content and #title_content > 0 then
			title_content = title_content .. " - (" .. pane.domain_name .. ")"
		else
			title_content = pane.domain_name
		end
	end

	local index = tostring(tab.tab_index + 1) .. "."
	local title_content = " " .. wezterm.truncate_right(title_content, max_width)

	return {
		{ Attribute = { Intensity = "Bold" } },
		{ Text = title_prefix },
		{ Attribute = { Intensity = "Normal" } },
		{ Text = index },
		{ Attribute = { Intensity = "Bold" } },
		{ Text = title_content },
		{ Attribute = { Intensity = "Normal" } },
	}
end)

wezterm.on("format-window-title", function(tab, pane, tabs, panes, config)
	local status = ""
	if tab.active_pane.is_zoomed then
		status = status .. "Z,"
	end

	if #status > 0 then
		status = "[" .. status:sub(1, -2) .. "]"
	end

	local pane = tab.active_pane
	local title = "WezTerm(" .. pane.domain_name .. ")"
	local tab_title = tab.tab_title
	if #tab_title > 0 then
		title = "WezTerm(" .. tab_title .. ")"
	end

	return title .. " " .. status
end)

local act_change_profile_choices = {}
for key, _ in pairs(profiles) do
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
			wezterm.log_info("You selected profile: ", id, label)

			local profile = profiles[label]
			if profile ~= nil then
				window:set_config_overrides(profile)
			else
				wezterm.log_err("Unknown profile: ", id, label)
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

table.insert(config.keys, {
	key = "m",
	mods = "CTRL|SHIFT",
	action = act_rename_tab,
})

-- Custom begin
-- Custom end

config.launch_menu = launch_menu
config.default_prog = default_prog

return config
