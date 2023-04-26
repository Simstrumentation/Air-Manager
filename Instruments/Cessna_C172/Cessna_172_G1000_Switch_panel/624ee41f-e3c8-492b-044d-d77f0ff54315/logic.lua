--[[
--******************************************************************************************
-- *********************** Cessna 172 G1000 SWITCH PANEL ****************************
--******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation

    Main switch panel for the Cessna 172 G1000 Edition
    
    RELEASES: 
        V1.03 - Released 2023-04-26
		- fixed issue with pitot switch
         V1.02 - Released 2022-07-19
		- adjusted spacing of toggle switches
		- made master battery, alternator and avionics 
		   switches wider for easier use
        V1.01 - Released 2022-07-17
		- adjusted grapphical issues
		- knob graphics - still inop
		- adjusted state issue with pitot switch
		
        V1.0 - Released 2022-07-16
                - initial release
    NOTES:
        - Background graphic by Andrew Kena from the MSFS forum. 
  
    
    KNOWN ISSUES:
        - Light potentiometers currently INOP. Will come in a future version

   --******************************************************************************************
--]]


--global vars
local sw1_pos
local sw2_pos
local batt1_pos
local batt2_pos
snd_inop = sound_add("beepfail.wav")

img_add_fullscreen("bg.png")

--STANDBY BATTERY SECTION
test_indicator = img_add("test_indicator.png", 199, 120, 28, 28)
opacity(test_indicator, 0)
sw_mid_id = img_add("red knob mid.png", 144, 90, 28, 88 )
sw_down_id = img_add("red knob off.png", 144, 90, 28, 88)
sw_up_id = img_add("red knob.png", 144, 90, 28, 88)
visible(sw_down_id, false)
visible(sw_up_id, false)


    --hold test position down
function cb_test_hold()
    fs2020_variable_write("L:XMLVAR_STBYBattery_Test", "Enum", 1)
    fs2020_variable_write("L:XMLVAR_STBYBattery_IsHeld", "Number", 1)
    fs2020_event("BATTERY2_SET", 0)
end

function testbatt(test)
    if test == 1 then
        visible(sw_down_id, true)
        visible(sw_mid_id, false)
        visible(sw_up_id, false)
    elseif test == 0 then
        visible(sw_down_id, false)
visible(sw_mid_id, true)
   --     visible(sw_up_id, false)
    end
end
fs2020_variable_subscribe("L:XMLVAR_STBYBattery_IsHeld", "Enum", testbatt)

    -- indicator light state
function cb_test_state(state)
    if state == 2 then
        opacity(test_indicator, 1, "LOG", 0.5)
    elseif state == 1 then
        opacity(test_indicator, 0, "LOG", 0.5)
    end
end

fs2020_variable_subscribe("L:XMLVAR_BatterySTBY_SwitchState", "Enum", cb_test_state)
function cb_test_release()
    fs2020_variable_write("L:XMLVAR_STBYBattery_Test", "Enum", 0)
    fs2020_variable_write("L:XMLVAR_STBYBattery_IsHeld", "Number", 0)
    visible(sw_mid_id, true)
end

btn_test = button_add(nil, nil, 129, 160,  60, 60, cb_test_hold, cb_test_release)

    --standby battery

function stdb_bat_click_callback(position)
        fs2020_event("BATTERY2_SET", 1)
end
btn_stdb_bat = button_add(nil, nil, 129, 75,  60, 60, stdb_bat_click_callback)

function cb_stdb_battery(pos)
    if pos then
        visible(sw_up_id, true)
        visible(sw_mid_id, false)
    else
        visible(sw_up_id, false)
        visible(sw_mid_id, true)
    end
end
fs2020_variable_subscribe("ELECTRICAL MASTER BATTERY:2", "Bool", cb_stdb_battery)            
function cb_off()
    fs2020_event("BATTERY2_SET", 0)
    visible(sw_up_id, false)
    visible(sw_mid_id, true)
end
btn_off = button_add(nil, nil, 79, 105, 60, 60, cb_off)        

--END STANDBY BATTERY SECTION

-- CALLSIGN
txt_callsign = txt_add("CALLSIGN", "size:26px; font:arimo_bold.ttf; color:white; halign:center;", 36, 30, 400, 84)
function cb_callsign(callsign)
	txt_set(txt_callsign,  callsign)
end

fs2020_variable_subscribe("ATC ID", "STRING", cb_callsign)

-- END CALLSIGN



-- BEACON SWITCH
function beacon_click_callback(position)
    fs2020_event("TOGGLE_BEACON_LIGHTS")
end
beacon_switch_id = switch_add("white knob off.png", "white knob.png", 308,460,28,98, beacon_click_callback)

function cb_beacon_switch(sw_pos) 
    switch_set_position(beacon_switch_id, sw_pos)
end	
fs2020_variable_subscribe("LIGHT BEACON", "Bool", cb_beacon_switch)
-- END BEACON SWITCH

-- LANDING LIGHT SWITCH
function landing_click_callback(position)
    if position == 0 then
        fs2020_event("LANDING_LIGHTS_ON")
    elseif position == 1 then
        fs2020_event("LANDING_LIGHTS_OFF")
    end
end
landing_switch_id = switch_add("white knob off.png", "white knob.png", 379,460,28,98, landing_click_callback)

function cb_landing_switch(sw_pos)
    switch_set_position(landing_switch_id, sw_pos)
end
fs2020_variable_subscribe("LIGHT LANDING", "Bool", cb_landing_switch)
-- END LANDING LIGHT SWITCH

-- TAXI LIGHT SWITCH
function taxi_click_callback(position)
    fs2020_event("TOGGLE_TAXI_LIGHTS")
end
taxi_switch_id = switch_add("white knob off.png", "white knob.png", 449,460,28,98,  taxi_click_callback)

function cb_taxi(sw_pos)
    switch_set_position(taxi_switch_id, sw_pos)
end	
fs2020_variable_subscribe("LIGHT TAXI", "Bool", cb_taxi)
-- END TAXI LIGHT SWITCH

-- NAV LIGHTS SWITCH
function nav_click_callback(position)
    fs2020_event("TOGGLE_NAV_LIGHTS")
end
nav_switch_id = switch_add("white knob off.png", "white knob.png", 518,460,28,98, nav_click_callback)

function cb_nav(sw_pos)
    switch_set_position(nav_switch_id,sw_pos)
end	
fs2020_variable_subscribe("LIGHT NAV", "Bool", cb_nav)
-- END NAV LIGHTS SWITCH

-- STROBE SWITCH
function strobe_click_callback(position)
    if position == 0 then
        fs2020_event("STROBES_ON")
    elseif position == 1 then
        fs2020_event("STROBES_OFF")
    end
end

strobe_switch_id = switch_add("white knob off.png", "white knob.png", 593,460,28,98, strobe_click_callback)

function cb_strobe(sw_pos)
    switch_set_position(strobe_switch_id, sw_pos)
end	


fs2020_variable_subscribe("LIGHT STROBE", "Bool", cb_strobe)
-- END STROBE SWITCH

-- FUEL PUMP SWITCH
function pump_click_callback(position)
    fs2020_event("TOGGLE_ELECT_FUEL_PUMP")
end

pump_switch_id = switch_add("white knob off.png", "white knob.png", 308,602,28,98, pump_click_callback)

function cb_pump(sw_pos)
    switch_set_position(pump_switch_id, sw_pos) 
end

fs2020_variable_subscribe("GENERAL ENG FUEL PUMP SWITCH:1", "Bool", cb_pump)
-- END FUEL PUMP SWITCH


-- PITOT HEAT SWITCH
function pitot_click_callback(position)
    fs2020_event("PITOT_HEAT_TOGGLE")
end

pitot_switch_id = switch_add("green knob off.png", "green knob.png", 380,602,28,98, pitot_click_callback)

function new_pitot_pos(pitot)
    if pitot then
        switch_set_position(pitot_switch_id, 0)
    else
        switch_set_position(pitot_switch_id, 1)
    end
end
fs2020_variable_subscribe("PITOT HEAT", "Bool", new_pitot_pos)
-- END PITOT HEAT SWITCH

-- CABIN POWER SWITCH
function cb_power(position)
    --INOP
    sound_play(snd_inop)
end

power_switch_id = switch_add("white knob off.png", "white knob.png", 447,602,28,98, cb_power)

function new_pitot_switch_pos(sw_on)

    if sw_on == 0 then
        switch_set_position(pitot_switch_id,0)
    elseif  sw_on == 1 then
        switch_set_position(pitot_switch_id,1)
    end

end	

function new_pitot_switch_pos_fsx(sw_on)

    sw_on = fif(sw_on, 1, 0)
    new_pitot_switch_pos(sw_on)

end

fs2020_variable_subscribe("PITOT HEAT", "Bool", new_pitot_switch_pos_fsx)
-- END CABIN POWER SWITCH


-- ALTERNATOR SWITCH
function alt_click_callback(position)

    if position == 0 then
        fs2020_event("TOGGLE_MASTER_ALTERNATOR")
    elseif position == 1 then
        fs2020_event("TOGGLE_MASTER_ALTERNATOR")
    end

end

alt_switch_id = switch_add("master_right_off.png", "master_right_on.png", 70,263, 72,150,alt_click_callback)

function cb_alternator(sw_pos)

    switch_set_position(alt_switch_id, sw_pos)

end

fs2020_variable_subscribe("GENERAL ENG MASTER ALTERNATOR", "Bool", cb_alternator)
-- END ALTERNATOR SWITCH


-- BATTERY SWITCH
function bat_click_callback(position)
     if batt1_pos == true then
        fs2020_event("BATTERY1_SET", 0)
    else
        fs2020_event("BATTERY1_SET", 1)
    end
end

bat_switch_id = switch_add("master_left_off.png", "master_left_on.png",110,263, 72,150,bat_click_callback)

function cb_battery(sw_pos)
    switch_set_position(bat_switch_id, sw_pos)
    batt1_pos = sw_pos
end	
fs2020_variable_subscribe("ELECTRICAL MASTER BATTERY:1", "Bool", cb_battery)
-- END BATTERY SWITCH

-- AVIONICS 
function avionics1_click(position)
    if sw1_pos then
        fs2020_variable_write("A:CIRCUIT SWITCH ON:24", "Enum", 0)
    else
        fs2020_variable_write("A:CIRCUIT SWITCH ON:24", "Enum", 1)
    end
end
avion_1_switch_id = switch_add("white_rock_off.png", "white_rock_on.png",227,275, 37,121, avionics1_click)

function avionics2_click(position)
    if sw2_pos then
        fs2020_variable_write("A:CIRCUIT SWITCH ON:25", "Enum", 0)
    else
        fs2020_variable_write("A:CIRCUIT SWITCH ON:25", "Enum", 1)
    end
end
avion_2_switch_id = switch_add("white_rock_off.png", "white_rock_on.png",268,275, 37,121, avionics2_click)

function cb_avionics(sw_1, sw_2)
    sw1_pos = sw_1
    sw2_pos = sw_2
    switch_set_position(avion_1_switch_id, sw1_pos)
    switch_set_position(avion_2_switch_id, sw2_pos)
end
fs2020_variable_subscribe("AVIONICS MASTER SWITCH:1", "Bool",
                                                "AVIONICS MASTER SWITCH:2", "Bool", 
                                               cb_avionics)
-- END AVIONICS 



--DIMMING 

    --panels
function cb_panel()
    --inop
    sound_play(snd_inop)
end    
knob_panel_id = dial_add("delta_knob.png", 90, 498, 64, 64, cb_panel)    

-- stdb instruments

function cb_inst()
    --inop
    sound_play(snd_inop)
end    
knob_inst_id = dial_add("delta_knob.png", 180, 498, 64, 64, cb_inst)    

    --pedestal
function cb_pedestal()
    --inop
    sound_play(snd_inop)
end    
knob_pedestal_id = dial_add("delta_knob.png", 90, 604, 64, 64, cb_pedestal)    

    --avionics
function cb_avionics()
    --inop
    sound_play(snd_inop)
end    
knob_avionics_id = dial_add("delta_knob.png", 180, 604, 64, 64, cb_avionics)    
--END DIMMING

