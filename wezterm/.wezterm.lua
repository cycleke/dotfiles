local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action

local config = {}
local launch_menu = {}
local default_prog = {}

local light_theme = "Vs Code Light+ (Gogh)"
local dark_theme = "Vs Code Dark+ (Gogh)"

if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- 基础配置
config.check_for_updates = false
config.audible_bell = "Disabled"

-- UI
config.color_scheme = light_theme
config.default_cursor_style = "SteadyBlock"
config.foreground_text_hsb = {
	hue = 1.0,
	saturation = 1.2,
	brightness = 1.5,
}

-- Font
config.font = wezterm.font_with_fallback({
	"Iosvmata",
	"LXGW WenKai Mono",
	"HanaMinB",
	"Segoe UI Emoji",
	"Segoe UI Symbol",
})
config.font_size = 11
config.freetype_load_target = "Normal"
config.enable_kitty_graphics = true

-- Window
config.native_macos_fullscreen_mode = true
config.adjust_window_size_when_changing_font_size = true
config.window_background_opacity = 0.95
config.text_background_opacity = 0.3
config.window_padding = {
	left = 5,
	right = 5,
	top = 5,
	bottom = 5,
}
config.window_background_image_hsb = {
	brightness = 0.8,
	hue = 1.0,
	saturation = 1.0,
}

-- Tab Bar
config.enable_tab_bar = true
config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.show_tab_index_in_tab_bar = true
config.tab_bar_at_bottom = false
config.tab_max_width = 30
config.switch_to_last_active_tab_when_closing_tab = false

-- Keybindings
config.disable_default_key_bindings = true
config.keys = {
	{ key = "Copy", mods = "", action = act.CopyTo("Clipboard") },
	{ key = "Paste", mods = "", action = act.PasteFrom("Clipboard") },
	{ key = "c", mods = "CTRL|SHIFT", action = act.CopyTo("Clipboard") },
	{ key = "v", mods = "CTRL|SHIFT", action = act.PasteFrom("Clipboard") },

	{ key = "j", mods = "CTRL|SHIFT", action = act.ActivateTabRelative(-1) },
	{ key = "k", mods = "CTRL|SHIFT", action = act.ActivateTabRelative(1) },
	{ key = "{", mods = "CTRL|SHIFT", action = act.MoveTabRelative(-1) },
	{ key = "}", mods = "CTRL|SHIFT", action = act.MoveTabRelative(1) },

	{ key = "Tab", mods = "CTRL", action = act.ActivateTabRelative(1) },
	{ key = "Tab", mods = "CTRL|SHIFT", action = act.ActivateTabRelative(-1) },
	{ key = "j", mods = "SUPER|SHIFT", action = act.ActivateTabRelative(-1) },
	{ key = "k", mods = "SUPER|SHIFT", action = act.ActivateTabRelative(1) },
	{ key = "{", mods = "SUPER|SHIFT", action = act.MoveTabRelative(-1) },
	{ key = "}", mods = "SUPER|SHIFT", action = act.MoveTabRelative(1) },

	{ key = "t", mods = "CTRL|SHIFT", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "n", mods = "CTRL|SHIFT", action = act.ShowLauncher },
	{ key = "n", mods = "SUPER", action = act.SpawnWindow },
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
		event = { Up = { streak = 2, button = "Left" } },
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
		event = { Up = { streak = 3, button = "Left" } },
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

-- Default shell
if wezterm.target_triple:find("windows") then
	default_prog = { "nu.exe", "--login" }
elseif wezterm.target_triple:find("darwin") or wezterm.target_triple:find("linux") then
	default_prog = { "zsh", "--login" }
end

function scheme_for_appearance(appearance)
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

local function basename(s)
	return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local edge_background = "#D3D3E0"
	local background = "#999999"

	local foreground = "#1A1A2F"
	local edge_foreground = background

	local title_prefix = ""
	if tab.is_active then
		-- title_prefix = "∯ "
		title_prefix = "𝅘𝅥𝅲 "
		background = "#E8E8EA"
	elseif hover then
		background = "#FBB829"
	end

	local pane = tab.active_pane
	local process_name = pane.foreground_process_name
	local exec_name = basename(process_name)
	local title_with_icon = exec_name

	if pane.domain_name then
		if title_with_icon == "" then
			title_with_icon = pane.domain_name
		else
			title_with_icon = title_with_icon .. " - (" .. pane.domain_name .. ")"
		end
	end

	local id = tostring(tab.tab_index + 1)
	local title = " " .. title_prefix .. "" .. wezterm.truncate_right(title_with_icon, max_width)

	return {
		{ Attribute = { Intensity = "Bold" } },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = id },
		{ Text = title },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Attribute = { Intensity = "Normal" } },
	}
end)

wezterm.on("format-window-title", function(tab, pane, tabs, panes, config)
	local index = ""
	if #tabs > 1 then
		index = string.format("[%d/%d] ", tab.tab_index + 1, #tabs)
	end

	return index .. tab.active_pane.title
end)

function scheme_for_appearance(appearance)
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

config.launch_menu = launch_menu
config.default_prog = default_prog

return config
