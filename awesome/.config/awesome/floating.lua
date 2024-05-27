local ipairs = ipairs
local capi = { mouse = mouse, mousegrabber = mousegrabber }

local floating = {}

function floating.mouse_resize_handler(c, corner, x, y)
  local g = c:geometry()

  -- Do not allow maximized clients to be resized by mouse
  local fixed_x = c.maximized_horizontal
  local fixed_y = c.maximized_vertical

  local prev_coords = {}
  local coordinates_delta = {x=0, y=0}

  local corner_x, corner_y = x, y
  local mouse_coords = capi.mouse.coords()
  x = mouse_coords.x
  y = mouse_coords.y
  coordinates_delta = {x = corner_x-x,y = corner_y-y}

  capi.mousegrabber.run(function(state)
    if not c.valid then return false end

    state.x = state.x + coordinates_delta.x
    state.y = state.y + coordinates_delta.y

    for _, v in ipairs(state.buttons) do
      if v then
        local ng

        prev_coords = { x = state.x, y = state.y }

        if corner == "bottom_right" then
          ng = {
            width = state.x - g.x,
            height = state.y - g.y
          }
        elseif corner == "bottom_left" then
          ng = {
            x = state.x,
            width = (g.x + g.width) - state.x,
            height = state.y - g.y
          }
        elseif corner == "top_left" then
          ng = {
            x = state.x,
            width = (g.x + g.width) - state.x,
            y = state.y,
            height = (g.y + g.height) - state.y
          }
        else
          ng = {
            width = state.x - g.x,
            y = state.y, 
            height = (g.y + g.height) - state.y 
          }
        end

        if ng.width <= 0 then ng.width = nil end
        if ng.height <= 0 then ng.height = nil end
        if fixed_x then ng.width = g.width ng.x = g.x end
        if fixed_y then ng.height = g.height ng.y = g.y end

        c:geometry(ng)
        local rg = c:geometry()

        if corner == "bottom_right" then
          ng = {}
        elseif corner == "bottom_left" then
          ng = {
            x = (g.x + g.width) - rg.width
          }
        elseif corner == "top_left" then
          ng = {
            x = (g.x + g.width) - rg.width,
            y = (g.y + g.height) - rg.height
          }
        else
          ng = {
            y = (g.y + g.height) - rg.height
          }
        end

        c:geometry({ x = ng.x, y = ng.y })
        return true
      end
    end

    return prev_coords.x == state.x and prev_coords.y == state.y
  end, corner .. "_corner")
end

function floating.arrange()
end

floating.name = "floating"

return floating
