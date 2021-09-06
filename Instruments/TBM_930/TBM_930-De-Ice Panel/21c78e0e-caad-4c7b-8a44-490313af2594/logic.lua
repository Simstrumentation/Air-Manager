--[[
De-ice switch panel for TBM 930
by Joe "Crunchmeister" Gilker

Inertial Separator currently only turns Engine Anti Ice. Does not have the 30 second gradual system. 
Insep switch doesn't activate the switch in virtual cockpit. If the sim eventually allows it, the next version 
of this instrument will support it. 
]]--

--BACKGROUND IMAGE
img_add_fullscreen("bg.png")

local af = false
local propdeice = false
local wndsh1 = false
local wndsh2 = false
local indicator_light = "indicator_on.png"


af = img_add(indicator_light, 118, 120, 21, 21)
propdeice = img_add(indicator_light, 426, 120, 21, 21)
wndsh1 = img_add(indicator_light, 534, 120, 21, 21)
wndsh2 = img_add(indicator_light, 598, 120, 21, 21)

visible(af, false)
visible(propdeice, false)
visible(wndsh1, false)
visible(wndsh2, false)

-- STRUCTURAL DEICE SWITCH
function af_click_callback(position)
    if position == 0 then
        switch_set_position(af_deice_switch_id, 1)
        fs2020_event("TOGGLE_STRUCTURAL_DEICE")
        visible(af, true)
    elseif position == 1 then
        switch_set_position(af_deice_switch_id, 0)
        fs2020_event("TOGGLE_STRUCTURAL_DEICE")
        visible(af, false)
    end
end

af_deice_switch_id = switch_add("sw_off.png", "sw_on.png", 142, 210, 40, 161, af_click_callback)

function new_structure_pos(structure)
    if structure then
        switch_set_position(af_deice_switch_id, 1)
        visible(af, true)
    else 
        switch_set_position(af_deice_switch_id, 0)
        visible(af, false)
    end
end    
fs2020_variable_subscribe("STRUCTURAL DEICE SWITCH", "Bool", new_structure_pos)

function new_af_switch_pos(sw_on)
    if sw_on == 0 then
        switch_set_position(af_deice_switch_id, 1)
    elseif  sw_on == 1 then
        switch_set_position(af_deice_switch_id, 0)
    end
end    
fs2020_variable_subscribe("STRUCTURAL DEICE SWITCH", "Bool", new_af_switch_pos)
-- END STRUCTURAL DEICE SWITCH

-- ICE LIGHT SWITCH
function ice_light_click_callback(position)
    if position == 0 then
        switch_set_position(ice_light_id, 1)
        fs2020_event("TOGGLE_WING_LIGHTS")
    elseif position == 1 then
        switch_set_position(ice_light_id, 0)
        fs2020_event("TOGGLE_WING_LIGHTS")
    end
end

ice_light_id = switch_add("sw_off.png", "sw_on.png", 280, 210, 40, 161, ice_light_click_callback)

function new_ice_light_switch_pos(ice_light)
    if ice_light then
        switch_set_position(ice_light_id, 1)
    else
        switch_set_position(ice_light_id, 0)
    end
end    

fs2020_variable_subscribe("LIGHT WING", "Bool", new_ice_light_switch_pos)
-- END ICE LIGHT SWITCH

-- PROP DE-ICE SWITCH
function prop_deice_click_callback(position)
    if position == 0 then
        switch_set_position(prop_deice_id, 1)
        fs2020_event("TOGGLE_PROPELLER_DEICE")
         visible(propdeice, true)
    elseif position == 1 then
        switch_set_position(prop_deice_id, 0)
        fs2020_event("TOGGLE_PROPELLER_DEICE")
         visible(propdeice, false)
    end
end

prop_deice_id = switch_add("sw_off.png", "sw_on.png", 418, 210, 40, 161, prop_deice_click_callback)

function new_prop_deice_switch_pos(prop_on)
    if prop_on then
        switch_set_position(prop_deice_id, 1)
        visible(propdeice, true)
    else
        switch_set_position(prop_deice_id, 0)
        visible(propdeice, false)
    end
end    

fs2020_variable_subscribe("PROP DEICE SWITCH:1", "Bool", new_prop_deice_switch_pos)
-- END PROP DE-ICE SWITCH

-- WINDSHIELD DE-ICE SWITCH
function ws_deice_click_callback(position)
    if position == 0 then
        switch_set_position(ws_deice_id, 1)
        --fs2020_event("ANTI_ICE_ON")
        fs2020_event("WINDSHIELD_DEICE_TOGGLE")
        visible(wndsh1, true)
        visible(wndsh2, true)
    elseif position == 1 then
        switch_set_position(ws_deice_id, 0)
        fs2020_event("WINDSHIELD_DEICE_TOGGLE")
        visible(wndsh1, false)
        visible(wndsh2, false)
    end
end
ws_deice_id = switch_add("sw_off.png", "sw_on.png", 556, 210, 40, 161, ws_deice_click_callback)

function new_ws_deice_switch_pos(wsd_on)
    if wsd_on  then
        switch_set_position(ws_deice_id, 1)
    else
        switch_set_position(ws_deice_id, 0)
    end
end    

fs2020_variable_subscribe("WINDSHIELD DEICE SWITCH", "Bool", new_ws_deice_switch_pos)
-- END WINDSHIELD DE-ICE SWITCH

--PITOT HEAT SWITCH
function pitot_click_callback(position)
    new_position= math.abs(position-1)
    switch_set_position(pitot_l_id,new_position)
     switch_set_position(pitot_r_id,new_position)
    fs2020_event("PITOT_HEAT_SET", new_position)
end


pitot_l_id = switch_add("sw_off.png", "sw_on.png", 694, 210, 40, 161, pitot_click_callback)
pitot_r_id = switch_add("sw_off.png", "sw_on.png", 831, 210, 40, 161, pitot_click_callback)

function new_pitot_switch_pos(sw_on)
    switch_set_position(pitot_l_id,sw_on)
    switch_set_position(pitot_r_id,sw_on)
end    
fs2020_variable_subscribe("PITOT HEAT", "Bool", new_pitot_switch_pos)

--END PITOT HEAT SWITCH

-- INERTIAL SEPARATOR SWITCH
function insep_click_callback(position)

    if position == 0 then
        switch_set_position(in_sep_id, 1)
        fs2020_event("ANTI_ICE_TOGGLE_ENG1")
    elseif position == 1 then
        switch_set_position(in_sep_id, 0)
        fs2020_event("ANTI_ICE_TOGGLE_ENG1")
    end
end

in_sep_id = switch_add("sw_off.png", "sw_on.png", 968, 210, 40, 161, insep_click_callback)

function new_ws_insep_switch_pos(sw_on)

    if sw_on == 0 then
        switch_set_position(in_sep_id, 0)
    elseif  sw_on == 1 then
        switch_set_position(in_sep_id, 1)
    end
end    

fs2020_variable_subscribe("GENERAL ENG ANTI ICE POSITION:1", "Bool", new_ws_insep_switch_pos)
-- END INERTIAL SEPARATOR SWITCH


--ws_deice = switch_add("sw_on.png", "sw_off.png", 556, 210, 40, 161, gear_switch)
--pitot_l = switch_add("sw_on.png", "sw_off.png", 694, 210, 40, 161, gear_switch)

--in_sep = switch_add("sw_on.png", "sw_off.png", 968, 210, 40, 161, gear_switch)
