local wezterm = require("wezterm")

local default_prog = {}

-- Using shell
if wezterm.target_triple:find("windows") then
	default_prog = { "pwsh.exe", "-NoLogo" }
elseif wezterm.target_triple:find("darwin") or wezterm.target_triple:find("linux") then
	default_prog = { "zsh", "--login" }
end

function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Ef-Deuteranopia-Dark"
	else
		return "Ef-Deuteranopia-Light"
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
		title_prefix = "∯ "
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

return {
	check_for_updates = false,

	-- Window
	native_macos_fullscreen_mode = true,
	adjust_window_size_when_changing_font_size = true,
	window_background_opacity = 0.95,
	window_padding = {
		left = 5,
		right = 5,
		top = 5,
		bottom = 5,
	},
	window_background_image_hsb = {
		brightness = 0.8,
		hue = 1.0,
		saturation = 1.0,
	},

	-- Keybindings
	keys = {
		{ key = "j", mods = "CMD|SHIFT", action = wezterm.action({ ActivateTabRelative = -1 }) },
		{ key = "k", mods = "CMD|SHIFT", action = wezterm.action({ ActivateTabRelative = 1 }) },
		{ key = ",", mods = "CMD|SHIFT", action = wezterm.action({ MoveTabRelative = -1 }) },
		{ key = ".", mods = "CMD|SHIFT", action = wezterm.action({ MoveTabRelative = 1 }) },
		{ key = "F2", mods = "", action = wezterm.action.ShowLauncher },
	},

	-- Tab bar
	enable_tab_bar = true,
	use_fancy_tab_bar = true,
	hide_tab_bar_if_only_one_tab = false,
	show_tab_index_in_tab_bar = true,
	tab_bar_at_bottom = false,
	tab_max_width = 30,
	switch_to_last_active_tab_when_closing_tab = false,

	-- Font
	font = wezterm.font_with_fallback({
		"IosevkaTerm Nerd Font Mono",
		{ family = "LXGW WenKai Mono GB", scale = 1 },
		"Apple Symbols",
	}),
	font_size = 14,

	freetype_load_target = "Normal",
	enable_kitty_graphics = true,

	-- misc
	default_prog = default_prog,
	audible_bell = "Disabled",
}
