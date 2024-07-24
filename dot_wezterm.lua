-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "terafox"
config.enable_scroll_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.font = wezterm.font("JetBrains Mono")
config.font_size = 10.0
config.use_resize_increments = true
-- config.front_end = "WebGpu"
config.freetype_load_target = "HorizontalLcd" -- and finally, return the configuration to wezterm
return config
