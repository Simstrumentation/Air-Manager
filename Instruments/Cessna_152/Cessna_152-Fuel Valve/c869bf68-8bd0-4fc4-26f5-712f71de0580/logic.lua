--[[
Cessna 152 fuel shutoff valve.
by Joe "Crunchmeister" Gilker
]]--
img_add_fullscreen("bg.png")

function toggle_valve(position)
    if position == 0 then
        switch_set_position(valve_id, 1)
       fs2020_event("TOGGLE_FUEL_VALVE_ENG1")
    elseif position == 1 then
        switch_set_position(valve_id, 0)
       fs2020_event("TOGGLE_FUEL_VALVE_ENG1")
    end
 end

valve_id = switch_add("off.png", "on.png", 0, 0, 350, 146, toggle_valve)

function new_valve_pos(valve_pos)
    if valve_pos then
        switch_set_position(valve_id, 1)
        --fs2020_event("TOGGLE_FUEL_VALVE_ENG1")
    else
        switch_set_position(valve_id, 0)
        --fs2020_event("TOGGLE_FUEL_VALVE_ENG1")
    end
end

fs2020_variable_subscribe("GENERAL ENG FUEL VALVE:1", "Bool", new_valve_pos)
