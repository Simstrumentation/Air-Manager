img_add_fullscreen("bg.png")

local oxygen_state

level_indicator_id = img_add("indicators.png", 112, 98, 17, 178)
visible(level_indicator_id, false)

function toggle_oxygen_cb()
    if oxygen_state == 1 then
        fs2020_variable_write("L:XMLVAR_Oxygen", "Number", 0)
    else
        fs2020_variable_write("L:XMLVAR_Oxygen", "Number", 1)
    end

end

switch_id = switch_add("off.png", "on.png", 157, 138, 82, 115, toggle_oxygen_cb) 

function new_oxygen_pos(oxygen)
    if oxygen == 1 then
        switch_set_position(switch_id, 1)
        visible(level_indicator_id, true)
        oxygen_state = 1
    else
        switch_set_position(switch_id, 0)
        visible(level_indicator_id, false)
        oxygen_state = 0
    end
end

fs2020_variable_subscribe("L:XMLVAR_Oxygen", "Number", new_oxygen_pos)