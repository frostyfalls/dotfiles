local beautiful = require("beautiful")
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")

local dpi = xresources.apply_dpi

local theme = {}

-- Fonts
theme.font = "monospace 8"

-- Foreground colors
theme.fg_normal = "#aaaaaa"
theme.fg_focus = "#eeeeee"
theme.fg_urgent = "#000000"

-- Background colors
theme.bg_normal = "#222222"
theme.bg_focus = "#888888"
theme.bg_urgent = "#FFFFFF"

-- Border width and colors
theme.border_width = dpi(1)

theme.border_normal = "#444444"
theme.border_focus = "#aaaaaa"

-- Gap size
theme.useless_gap = dpi(4)

-- Taglist squares
local taglist_square_size = dpi(4)

theme.taglist_squares_sel = theme_assets.taglist_squares_sel(taglist_square_size, theme.fg_normal)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(taglist_square_size, theme.fg_normal)

-- Wallpaper path
theme.wallpaper = string.format("%s/wallpaper", os.getenv("XDG_DATA_HOME"))

return theme
