local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.default_prog = { 'C:/Program Files/Git/bin/bash.exe' }
config.color_scheme = 'AdventureTime'
config.default_cursor_style = 'BlinkingBar'
config.window_background_opacity = 0.6
config.win32_system_backdrop = 'Acrylic'
-- config.window_decorations = "RESIZE"

config.integrated_title_buttons = {}
config.hide_tab_bar_if_only_one_tab=true
config.font_size = 10.0
-- config.tab_bar_at_bottom = true
-- config.use_fancy_tab_bar = true

return config
