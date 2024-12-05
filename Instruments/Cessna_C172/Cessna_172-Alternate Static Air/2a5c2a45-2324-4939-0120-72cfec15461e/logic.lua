--[[
Alternate Static Air switch for Cessna 172

by Joe "Crunchmeister" Gilker

]]--


showBG = user_prop_add_boolean("Display Background", true, "Display grey background for switch") -- Show or hide the unit type onscreen
local bg = user_prop_get(showBG)



if bg  then
    img_add_fullscreen("bg.png")
end

function toggle_switch_callback(position)
    if position == 0 then
        switch_set_position(btn_id, 1)
        msfs_event("TOGGLE_ALTERNATE_STATIC")
    elseif position == 1 then
        switch_set_position(btn_id, 0)
        msfs_event("TOGGLE_ALTERNATE_STATIC")
    end
end

btn_id = switch_add("off.png", "on.png", 0, 0, 181, 283, toggle_switch_callback )


function new_alt_air_pos(alt_on)
    if alt_on then
        switch_set_position(btn_id, 1)
    else 
        switch_set_position(btn_id, 0)
    end
end    
msfs_variable_subscribe("ALTERNATE STATIC SOURCE OPEN", "Bool", new_alt_air_pos)