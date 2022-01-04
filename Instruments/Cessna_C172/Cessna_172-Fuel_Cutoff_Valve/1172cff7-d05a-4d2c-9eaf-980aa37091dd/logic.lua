--[[
******************************************************************************************
*********************** CESSNA 172 / 182 FUEL CUTOFF VALVE  ***********************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation

    Fuel cutoff valve for Cessna 172 and 182. Also works with the SWS Daher Kodiak
  
NOTES:
    - None
      
V1.0 - Released 2022-01-04
           
KNOWN ISSUES:
    - None

******************************************************************************************
--]]

local fuel_cutoff_state = nil
showBG = user_prop_add_boolean("Display Background", true, "Display grey background for switch") -- Show or hide the unit type onscreen
local bg = user_prop_get(showBG)



if bg  then
    img_add_fullscreen("bg.png")
end

function toggle_switch_callback(position)
    if position == 0 and fuel_cutoff_state == 0 then
        fs2020_event("TOGGLE_FUEL_VALVE_ENG1")
    elseif position == 1 and fuel_cutoff_state == 1 then
        fs2020_event("TOGGLE_FUEL_VALVE_ENG1")
        end
end

btn_id = switch_add("off.png", "on.png", 0, 0, 181, 283, toggle_switch_callback )


function new_fuel_pos(fuel_on)
    fuel_cutoff_state = fuel_on
    if fuel_on ~= 0 then
        switch_set_position(btn_id, 1)
    else 
        switch_set_position(btn_id, 0)
    end
end 
fs2020_variable_subscribe("GENERAL ENG FUEL VALVE:1", "Number", new_fuel_pos)