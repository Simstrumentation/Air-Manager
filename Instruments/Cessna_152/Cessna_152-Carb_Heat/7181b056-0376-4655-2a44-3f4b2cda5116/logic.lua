

function carb_heat_callback(position)

    if position == 0 then
        switch_set_position(carb_heat_id, 1)
        fs2020_event("ANTI_ICE_TOGGLE_ENG1")
    elseif position == 1 then
        switch_set_position(carb_heat_id, 0)
        fs2020_event("ANTI_ICE_TOGGLE_ENG1")
    end
end

carb_heat_id = switch_add("sw_off.png", "sw_on.png", 0, 0, 248, 315, carb_heat_callback)

function new_carb_heat_pos(sw_on)

    if sw_on == 0 then
        switch_set_position(in_sep_id, 0)
    elseif  sw_on == 1 then
        switch_set_position(in_sep_id, 1)
    end
end    

fs2020_variable_subscribe("GENERAL ENG ANTI ICE POSITION:1", "Bool", new_carb_heat_pos)
