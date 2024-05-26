local awful = require("awful")
local beautiful = require("beautiful")

local utils = require("utils")

-- Set wallpaper
screen.connect_signal("property::geometry", function(s)
  if beautiful.wallpaper then
    gears.wallpaper.maximized(beautiful.wallpaper, s, true)
  end
end)

-- Ensure client is on screen
client.connect_signal("manage", function(c)
  if awesome.startup
    and not c.size_hints.user_position
    and not c.size_hints.program_position
  then
    awful.placement.no_offscreen(c)
  end
end)

-- Use sloppy focus for clients
client.connect_signal("mouse::enter", function(c)
  c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

-- Set border color based on focus status
client.connect_signal("focus", function(c)
  if tag_only_has_floating() then
    awful.client.focus.byidx(1)
  else
    t = 0
    repeat
      awful.client.focus.byidx(-1)
      t = t + 1
    until not client.focus.floating or t > 5
  end
  c.border_color = beautiful.border_focus
end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

client.connect_signal("unminimize", function(c) c.unminize() end)

client.connect_signal("manage", function (c)
  if c.floating then
    c.ontop = true
  end
end)
