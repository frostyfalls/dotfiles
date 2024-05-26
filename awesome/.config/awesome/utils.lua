local awful = require("awful")

function tag_only_has_floating()
  local tag = awful.screen.focused().selected_tag
  local clients = tag:clients()
  for _, c in ipairs(clients) do
    if not c.floating then
      return false
    end
  end
  return true
end
