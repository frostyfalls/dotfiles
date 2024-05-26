-- Handle any errors
require("errors")

-- Load LuaRocks if available
pcall(require, "luarocks.loader")

-- Base
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

-- Configurations
local config = require("config")

-- Initialize the theme
beautiful.init(string.format("%s/themes/%s/theme.lua", awesome.conffile:match("(.*/)"), config.theme_name))

-- Other definitions
local binds = require("binds")
local rules = require("rules")
local widgets = require("wibar")

-- Set layouts
awful.layout.layouts = config.layouts

-- Set up the tags and wibox for each screen
awful.screen.connect_for_each_screen(function(s)
  awful.tag(config.tags, s, awful.layout.layouts[config.default_layout])

  wibar_setup(s)
end)

-- Set root key binds
root.keys(binds.global_keys)

-- Apply rules
awful.rules.rules = rules

-- Connect signals
require("signals")

-- Always ensure a window is focused
require("awful.autofocus")
