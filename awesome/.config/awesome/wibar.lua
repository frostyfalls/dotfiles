local awful = require("awful")
local wibox = require("wibox")

local binds = require("binds")

function wibar_setup(s)
  s.taglist = awful.widget.taglist {
    filter = awful.widget.taglist.filter.all,
    buttons = binds.taglist_buttons,
    screen = s,
  }

  s.wibox = awful.wibar {
    screen = s,
  }

  s.wibox:setup {
    layout = wibox.layout.align.horizontal,
    {
      layout = wibox.layout.fixed.horizontal,
      s.taglist,
    },
    nil,
    {
      layout = wibox.layout.fixed.horizontal,
      wibox.widget.systray(),
      wibox.widget.textclock(),
    },
  }
end
