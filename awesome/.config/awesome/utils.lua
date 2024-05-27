local awful = require("awful")

local utils = {}

function utils.attach_top(c)
  local t = awful.tag.selected(c.screen)

  local clients = t:clients()
  local layout = awful.tag.getproperty(t, "layout")
  local nmaster = layout.master_count or 1

  local index = math.min(#clients, nmaster)
  c:swap(clients[index])
end

return utils
