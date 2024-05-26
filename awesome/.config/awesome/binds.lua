local gears = require("gears")
local awful = require("awful")

local config = require("config")

local utils = require("utils")

local taglist_buttons = gears.table.join(
  awful.button({ }, 1, function(t)
    t:view_only() end
  ),
  awful.button({ "Mod4" }, 1, function(t)
    if client.focus then
      client.focus:move_to_tag(t)
    end
  end),
  awful.button({ }, 3,
    awful.tag.viewtoggle
  ),
  awful.button({ "Mod4" }, 3, function(t)
    if client.focus then
      client.focus:toggle_tag(t)
    end
  end),
  awful.button({ }, 4, function(t)
    awful.tag.viewnext(t.screen)
  end),
  awful.button({ }, 5, function(t)
    awful.tag.viewprev(t.screen)
  end)
)

local global_keys = gears.table.join(
  awful.key({ "Mod4" }, "j", function()
    awful.client.focus.byidx(1)
  end),
  awful.key({ "Mod4" }, "k", function()
    awful.client.focus.byidx(-1)
  end),

  awful.key({ "Mod4", "Shift" }, "j", function()
    awful.client.swap.byidx(1)
  end),
  awful.key({ "Mod4", "Shift" }, "k", function()
    awful.client.swap.byidx(-1)
  end),

  awful.key({ "Mod4" }, "period", function()
    awful.screen.focus_relative(1)
  end),
  awful.key({ "Mod4" }, "comma", function()
    awful.screen.focus_relative(-1)
  end),

  awful.key({ "Mod4" }, "Return", function()
    awful.spawn(config.terminal)
  end),
  awful.key({ "Mod4" }, "p", function()
    awful.spawn("dmenu_run")
  end),

  awful.key({ "Mod4", "Control" }, "r",
    awesome.restart
  ),
  awful.key({ "Mod4", "Control" }, "q",
    awesome.quit
  ),

  awful.key({ "Mod4" }, "l", function()
    awful.tag.incmwfact(0.05)
  end),
  awful.key({ "Mod4" }, "h", function()
    awful.tag.incmwfact(-0.05)
  end),

  awful.key({ "Mod4" }, "i", function()
    awful.tag.incnmaster(1, nil, true)
  end),
  awful.key({ "Mod4" }, "d", function()
    awful.tag.incnmaster(-1, nil, true)
  end),

  awful.key({ "Mod4" }, "t", function()
    awful.layout.set(awful.layout.suit.tile)
  end),
  awful.key({ "Mod4" }, "m", function()
    awful.layout.set(awful.layout.suit.max)
  end),
  awful.key({ "Mod4" }, "f", function()
    awful.layout.set(awful.layout.suit.floating)
  end)
)

local client_keys = gears.table.join(
  awful.key({ "Mod4", "Shift" }, "f", function(c)
    c.fullscreen = not c.fullscreen
    c:raise()
  end),
  awful.key({ "Mod4", "Shift" }, "c", function(c)
    c:kill()
  end),
  awful.key({ "Mod4", "Shift" }, "space",
    awful.client.floating.toggle
  )
)

for i = 1, 9 do
  global_keys = gears.table.join(global_keys,
    awful.key({ "Mod4" }, "#" .. i + 9, function()
      local screen = awful.screen.focused()
      local tag = screen.tags[i]
      if tag then
        tag:view_only()
      end
    end),
    awful.key({ "Mod4", "Control" }, "#" .. i + 9, function()
      local screen = awful.screen.focused()
      local tag = screen.tags[i]
      if tag then
        awful.tag.viewtoggle(tag)
      end
    end),
    awful.key({ "Mod4", "Shift" }, "#" .. i + 9, function()
      if client.focus then
        local tag = client.focus.screen.tags[i]
        if tag then
          client.focus:move_to_tag(tag)
        end
      end
    end),
    awful.key({ "Mod4", "Control", "Shift" }, "#" .. i + 9, function()
      if client.focus then
        local tag = client.focus.screen.tags[i]
        if tag then
          client.focus:toggle_tag(tag)
        end
      end
    end)
  )
end

local client_buttons = gears.table.join(
  awful.button({ }, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
  end),
  awful.button({ "Mod4" }, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.move(c)
  end),
  awful.button({ "Mod4" }, 3, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.resize(c, config.resize_corner)
  end)
)

return {
  taglist_buttons = taglist_buttons,
  global_keys = global_keys,
  client_keys = client_keys,
  client_buttons = client_buttons,
}
