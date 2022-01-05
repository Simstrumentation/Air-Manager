--[[
--******************************************************************************************
-- ******************* DAHER KODIAK (SWS) ICE / LIGHT PANEL *************************
--******************************************************************************************
    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation
    Main electrical switch panel for the Daher Kodiak by SimWorks Studios. 
    
    NOTE:
    - FOLLOWING CONTROLS CURRENTLY INOP
        - Engine inlet bypass override (INOP in the Kodiak model)
        
    V1.1 - Released 2022-01-05
        - added lighting knob functionality
        
    V1.0 - Released 2021-12-28
        - initial release
    
    KNOWN ISSUES:
    - Engine bypass switch works, but does not activate the cockpit animation. Upon
      consultation with the SWS dev, currently it seems to be a limitation of the sim
      due to this control using a B: variable
    - Backup pump switch INOP. Currently runs on an externally inaccessible I: variable
    - Light knobs will not animate cockpit knobs due to B: variable inacessibility. 
   --******************************************************************************************
--]]

img_add_fullscreen("bg.png")

--  global variables

local landing_sw_pos 
local cabin_sw_pos

--Beacon Switch
function toggle_beacon()
    fs2020_event("TOGGLE_BEACON_LIGHTS")
end

beacon_id = switch_add("toggle_down.png","toggle_up.png", 116, 67, 72, 154, toggle_beacon)

function new_beacon_pos(beacon)
    if beacon then
       switch_set_position(beacon_id, 1)
    else
       switch_set_position(beacon_id, 0)
    end
end
fs2020_variable_subscribe("LIGHT BEACON", "Bool",new_beacon_pos)

--Strobe Switch
function toggle_strobe()
    fs2020_event("STROBES_TOGGLE")
end

strobe_id = switch_add("toggle_down.png","toggle_up.png", 246, 67, 72, 154, toggle_strobe)

function new_strobe_pos(strobe)
    if strobe then
       switch_set_position(strobe_id, 1)
    else
       switch_set_position(strobe_id, 0)
    end
end
fs2020_variable_subscribe("LIGHT STROBE", "Bool", new_strobe_pos)

--Nav Switch
function toggle_nav()
    fs2020_event("TOGGLE_NAV_LIGHTS")
end

nav_id = switch_add("toggle_down.png","toggle_up.png", 376, 67, 72, 154, toggle_nav)

function new_nav_pos(nav)
    if nav then
       switch_set_position(nav_id, 1)
    else
       switch_set_position(nav_id, 0)
    end
end
fs2020_variable_subscribe("LIGHT NAV", "Bool", new_nav_pos)


--Taxi Switch
function toggle_taxi()
    fs2020_event("TOGGLE_TAXI_LIGHTS")
end

taxi_id = switch_add("toggle_down.png","toggle_up.png", 508, 67, 72, 154, toggle_taxi)

function new_taxi_pos(taxi)
    if taxi then
       switch_set_position(taxi_id, 1)
    else
       switch_set_position(taxi_id, 0)
    end
end
fs2020_variable_subscribe("LIGHT TAXI", "Bool", new_taxi_pos)

--Landing Switch
function landing_inc()
      if landing_sw_pos == 0 then
          fs2020_variable_write("L:SWS_LIGHTING_Switch_Light_Landing", "Enum", 1)
      elseif landing_sw_pos == 1 then
          fs2020_variable_write("L:SWS_LIGHTING_Switch_Light_Landing", "Enum", 2) 
      end
end
landing_inc_id = button_add(nil, nil, 670, 37, 72, 72, landing_inc)

function landing_dec()
    if landing_sw_pos == 2 then
          fs2020_variable_write("L:SWS_LIGHTING_Switch_Light_Landing", "Enum", 1)
      elseif landing_sw_pos == 1 then
          fs2020_variable_write("L:SWS_LIGHTING_Switch_Light_Landing", "Enum", 0) 
      end
end

landing_dec_id = button_add(nil, nil, 670, 180, 72, 72, landing_dec)

landing_off_id = img_add("toggle_down.png", 670, 67, 72, 154 )
landing_pulse_id = img_add("toggle_mid.png", 670, 67, 72, 154 )
visible(landing_pulse_id, false)
landing_on_id = img_add("toggle_up.png", 670, 67, 72, 154 )
visible(landing_on_id, false)

function new_landing_pos(landing)
    if landing == 1 then
        visible(landing_off_id, false)
        visible(landing_pulse_id, true)
        visible(landing_on_id, false)
    elseif landing == 2 then
        visible(landing_off_id, false)
        visible(landing_pulse_id, false)
        visible(landing_on_id, true)
    elseif landing == 0 then
        visible(landing_off_id, true)
        visible(landing_pulse_id, false)
        visible(landing_on_id, false)
    end
        landing_sw_pos = landing
 end   
    
fs2020_variable_subscribe("L:SWS_LIGHTING_Switch_Light_Landing", "Enum", new_landing_pos)

--Cabin Switch


function cabin_inc()
    if cabin_sw_pos == 0 then
        fs2020_variable_write("L:SWS_LIGHTING_Switch_Light_Cabin_12", "Enum", 1)
    elseif cabin_sw_pos ==1 then
        fs2020_variable_write("L:SWS_LIGHTING_Switch_Light_Cabin_12", "Enum", 2)
    end
end

function cabin_dec()
    if cabin_sw_pos == 2 then
        fs2020_variable_write("L:SWS_LIGHTING_Switch_Light_Cabin_12", "Enum", 1)
    elseif cabin_sw_pos ==1 then
        fs2020_variable_write("L:SWS_LIGHTING_Switch_Light_Cabin_12", "Enum", 0)
    end
end

cabin_inc_id = button_add(nil, nil, 833, 37, 72, 72, cabin_inc)
cabin_dec_id = button_add(nil, nil, 833, 180, 72, 72, cabin_dec)

cabin_off_id = img_add("toggle_down.png", 833, 67, 72, 154)
cabin_norm_id = img_add("toggle_mid.png", 833, 67, 72, 154)
visible(cabin_norm_id, false)
cabin_on_id = img_add("toggle_up.png", 833, 67, 72, 154)
visible(cabin_on_id, false)

function new_cabin_pos(cabin)
    cabin_sw_pos = cabin
    if cabin_sw_pos == 1 then
        visible(cabin_off_id, false)
        visible(cabin_norm_id, true)
        visible(cabin_on_id, false)
    elseif cabin_sw_pos == 2 then
        visible(cabin_off_id, false)
        visible(cabin_norm_id, false)
        visible(cabin_on_id, true)
    elseif cabin_sw_pos == 0 then
        visible(cabin_off_id, true)
        visible(cabin_norm_id, false)
        visible(cabin_on_id, false)
    end
    cabin_sw_pos = cabin
end

fs2020_variable_subscribe("L:SWS_LIGHTING_Switch_Light_Cabin_12", "Enum", new_cabin_pos)

--light knob graphics

img_lights_glareshield_knob =   img_add("knob_outer.png", 950, 92, 95,95)
img_lights_instruments_knob =  img_add("knob_inner.png", 958,100,81,81)
img_lights_panel_knob = img_add("knob_inner.png", 1084,100,81,81)


--Glareshield
function ss_lights_glareshield(value)
    value = var_round(value,2)
    rotate (img_lights_glareshield_knob, (value*290),"LOG", 0.1)
    switch_set_position(sw_lights_glareshield, ((value*200)/10))
end
fs2020_variable_subscribe("A:LIGHT POTENTIOMETER:3", "Number", ss_lights_glareshield)

function callback_lights_glareshield(position, direction)
    if direction == 1 then
      fs2020_event("LIGHT_POTENTIOMETER_3_SET", var_cap(((position*5)+5),0,100))
       fs2020_event("GLARESHIELD_LIGHTS_ON")
   else
       fs2020_event("LIGHT_POTENTIOMETER_3_SET", var_cap(((position*5)-5),0,100))
       if position ==0  then
            fs2020_event("LIGHT_POTENTIOMETER_3_SET", 0)
            fs2020_event("GLARESHIELD_LIGHTS_OFF")
       end
   end
end        
sw_lights_glareshield = switch_add(nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil, 30, 40, 134, 134, callback_lights_glareshield)

--Instrument Lights
function ss_lights_instruments(value)
    value = var_round(value,2)
    rotate (img_lights_instruments_knob, (value*290),"LOG", 0.1)
    switch_set_position(sw_lights_instruments, (value*200)/10)
end

fs2020_variable_subscribe("A:LIGHT POTENTIOMETER:2", "Number", ss_lights_instruments)

function callback_lights_instruments(position, direction)
    if direction == 1 then
       fs2020_event("LIGHT_POTENTIOMETER_2_SET", var_cap(((position*5)+5),0,100))
       fs2020_event("PANEL_LIGHTS_ON")
       --fs2020_event("PANEL_LIGHTS_SET")
       --fs2020_variable_write("L:LIGHTING_PANEL_1_Inc", "Number", 1)
   else
       fs2020_event("LIGHT_POTENTIOMETER_2_SET", var_cap(((position*5)-5),0,100))
       if position == 0  then
          fs2020_event("PANEL_LIGHTS_OFF")
          fs2020_event("LIGHT_POTENTIOMETER_2_SET", 0)
       end
   end
end        

sw_lights_instruments = switch_add(nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,  55, 65, 80, 80, callback_lights_instruments)

--Panel Lights
function ss_lights_panel(value)
    value = var_round(value,2)
    rotate (img_lights_panel_knob, (value*290),"LOG", 0.1)
    switch_set_position(sw_lights_panel, ((value*200)/10))
end

fs2020_variable_subscribe("A:LIGHT POTENTIOMETER:21", "Number", ss_lights_panel)

function callback_lights_panel(position, direction)
    if direction == 1 then
      fs2020_event("LIGHT_POTENTIOMETER_21_SET", var_cap(((position*5)+5),0,100))
       fs2020_event("PEDESTRAL_LIGHTS_ON")
   else
       fs2020_event("LIGHT_POTENTIOMETER_21_SET", var_cap(((position*5)-5),0,100))
       if position ==0  then
            fs2020_event("LIGHT_POTENTIOMETER_21_SET", 0)
            fs2020_event("PEDESTRAL_LIGHTS_OFF")
       end
   end
end        

sw_lights_panel = switch_add(nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil, 200, 40, 120, 120, callback_lights_panel)




-- Engine Inlet Override
-- INOP

override_id = img_add("override_switch.png", 91, 365, 84, 130)
    
--Inlet Bypass Switch
function toggle_bypass()
    fs2020_event("ANTI_ICE_TOGGLE_ENG1")    
end
bypass_id = switch_add("paddle_down.png","paddle_up.png", 247, 310, 72, 154, toggle_bypass)

function new_bypass_pos(bypass)
    if bypass then
       switch_set_position(bypass_id, 1)
    else
       switch_set_position(bypass_id, 0)
    end
end
fs2020_variable_subscribe("ENG ANTI ICE:1", "Bool", new_bypass_pos)

-- Pitot switches
function pitot_l_taxi()
    fs2020_event("PITOT_HEAT_TOGGLE", 1)
end

pitot_l_id = switch_add("toggle_down.png","toggle_up.png", 378, 310, 72, 154, pitot_l_taxi)

function new_pitot_l_pos(pitot_l)
    if pitot_l == 1 then
        switch_set_position(pitot_l_id, 1)
    else
        switch_set_position(pitot_l_id, 0)
    end
end

fs2020_variable_subscribe("L:DEICE_Pitot_1", "Int", new_pitot_l_pos)

function pitot_r_taxi()
    fs2020_event("PITOT_HEAT_TOGGLE", 2)
end

pitot_r_id = switch_add("toggle_down.png","toggle_up.png", 508, 310, 72, 154, pitot_r_taxi)

function new_pitot_r_pos(pitot_r)
    if pitot_r == 1 then
        switch_set_position(pitot_r_id, 1)
    else
        switch_set_position(pitot_r_id, 0)
    end
end

fs2020_variable_subscribe("L:DEICE_Pitot_2", "Int", new_pitot_r_pos)


-- Ice Knob

function ice_power()
    fs2020_event("TOGGLE_PROPELLER_DEICE")
end

ice_id = img_add("ice_knob.png", 675, 350, 67, 84)
button_add(nil, nil,  675, 350, 67, 84, ice_power)



function new_prop_pos(prop)
    if prop  then
        switch_set_position(ice_id, 1)
        rotate(ice_id, 90, "LINEAR", 0.05)
    else
        rotate(ice_id, 0, "LINEAR", 0.05)
    end
end
fs2020_variable_subscribe("A:PROP DEICE SWITCH:1", "bOOL", new_prop_pos)


--Windshield Switch
function toggle_windshield()
    fs2020_event("WINDSHIELD_DEICE_TOGGLE")
end
windshield_id = switch_add("toggle_down.png","toggle_up.png", 832, 310, 72, 154, toggle_windshield)

function new_windshield_pos(windshield)
    if windshield then
       switch_set_position(windshield_id, 1)
    else
       switch_set_position(windshield_id, 0)
    end
end
fs2020_variable_subscribe("WINDSHIELD DEICE SWITCH", "Bool", new_windshield_pos)

--Pump Switch
function toggle_pump()
    --INOP
end

pump_id = switch_add("toggle_down.png","toggle_up.png", 960, 310, 72, 154, toggle_pump)


--Ice light Switch
function toggle_ice_light()
    fs2020_event("TOGGLE_WING_LIGHTS")
end

ice_light_id = switch_add("toggle_down.png","toggle_up.png", 1090, 310, 72, 154, toggle_ice_light)

function new_ice_light_pos(ice_light)
    if ice_light then
       switch_set_position(ice_light_id, 1)
    else
       switch_set_position(ice_light_id, 0)
    end

end
fs2020_variable_subscribe("LIGHT WING", "Bool", new_ice_light_pos)


