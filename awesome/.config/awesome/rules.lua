local awful = require("awful")
local beautiful = require("beautiful")

local binds = require("binds")

return {
  { -- All clients
    rule = { },
    properties = {
      placement = awful.placement.no_overlap + awful.placement.no_offscreen,
      focus = awful.client.focus.filter,
      screen = awful.screen.preferred,
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      raise = true,
      keys = binds.client_keys,
      buttons = binds.client_buttons
    }
  },

  { -- Floating clients
    rule_any = {
      class = {
        "Arandr",
        "mpv",
        "Nsxiv"
      }
    },
    properties = { floating = true }
  },

  { -- Sticky Firefox PiP clients
    rule = { name = "Picture-in-Picture" },
    properties = {
      floating = true,
      sticky = true
    }
  },

  {
    rule = { floating = true },
    properties = { placement = awful.placement.centered }
  }, 
}
