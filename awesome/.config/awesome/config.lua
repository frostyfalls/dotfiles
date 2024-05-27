local awful = require("awful")

local floating = require("floating")

local config = {}

-- Default programs
config.terminal = "st"
config.file_manager = "thunar"
config.browser = "firefox"
config.editor = "codium"

-- Theme name
config.theme_name = "default"

-- Layouts
config.layouts = {
  awful.layout.suit.tile,
  awful.layout.suit.max,
  floating,
}
config.default_layout = 1 -- Index of layout (1-indexed)

-- Tags
config.tags = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }

-- Resize corner
config.resize_corner = "bottom_right"

return config
