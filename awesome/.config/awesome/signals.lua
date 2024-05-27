local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")

local utils = require("utils")

-- Set wallpaper
screen.connect_signal("property::geometry", function(s)
  if beautiful.wallpaper then
    gears.wallpaper.maximized(beautiful.wallpaper, s, true)
  end
end)

-- Attach client to top of the slaves and ensure client is on screen
client.connect_signal("manage", function(c)
  if not awesome.startup then utils.attach_top(c) end

  if awesome.startup
    and not c.size_hints.user_position
    and not c.size_hints.program_position
  then
    awful.placement.no_offscreen(c)
  end

  if c.floating then
    c.ontop = true
  end
end)

-- Use sloppy focus for clients
client.connect_signal("mouse::enter", function(c)
  c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

-- Set border color based on focus status
client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

client.connect_signal("minimize", function(c) c.unminize() end)
