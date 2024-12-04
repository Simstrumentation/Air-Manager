--[[
--******************************************************************************************
-- *********************** Cessna 172 G1000 SWITCH PANEL ****************************
--******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation

    Main switch panel for the Cessna 172 G1000 Edition
    
    RELEASES: 
        V1.1 - made 2024 compatible
                - made the dimming knobs functional
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
        - Cabin Pwr Switch INOP in 2020

   --******************************************************************************************
--]]


--global vars
local sw1_pos
local sw2_pos
local batt1_pos
local batt2_pos
local panel_pos
local inst_pos
local ped_pos
local av_pos
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
    msfs_variable_write("L:XMLVAR_STBYBattery_Test", "Enum", 1)
    msfs_variable_write("L:XMLVAR_STBYBattery_IsHeld", "Number", 1)
    fs2020_event("BATTERY2_SET", 0)
end


function cb_test_release()
    msfs_variable_write("L:XMLVAR_STBYBattery_Test", "Enum", 0)
    msfs_variable_write("L:XMLVAR_STBYBattery_IsHeld", "Number", 0)
end

btn_test = button_add(nil, nil, 129, 160,  60, 60, cb_test_hold, cb_test_release)

-- set the switch and light based on current state
function cb_test_state(state)
    -- indicator light state
    if state == 2 then
        opacity(test_indicator, 1, "LOG", 0.5)
    elseif state == 1 then
        opacity(test_indicator, 0, "LOG", 0.5)
    end
    -- switch position
     if state == 2 then
        visible(sw_up_id, false)
        visible(sw_mid_id, false)
        visible(sw_down_id, true)
     elseif state == 0 then
        visible(sw_up_id, true)
        visible(sw_mid_id, false)         
        visible(sw_down_id, false)
    else
        visible(sw_up_id, false)
        visible(sw_mid_id, true)
        visible(sw_down_id, false)
    end   
end

msfs_variable_subscribe("L:XMLVAR_BatterySTBY_SwitchState", "Enum", cb_test_state)

--standby battery

function cb_on()
       msfs_event("B:ELECTRICAL_BATTERY_STBY_2", 0)
       fs2020_event("BATTERY2_SET", 1)
end
btn_stdb_bat = button_add(nil, nil, 129, 75,  60, 60, cb_on)

function cb_off()
       msfs_event("B:ELECTRICAL_BATTERY_STBY_2", 1)
       fs2020_event("BATTERY2_SET", 0)
end
btn_off = button_add(nil, nil, 79, 105, 60, 60, cb_off)        

--END STANDBY BATTERY SECTION

-- CALLSIGN
txt_callsign = txt_add("CALLSIGN", "size:26px; font:arimo_bold.ttf; color:white; halign:center;", 36, 30, 400, 84)
function cb_callsign(callsign)
	txt_set(txt_callsign,  callsign)
end

msfs_variable_subscribe("ATC ID", "STRING", cb_callsign)

-- END CALLSIGN



-- BEACON SWITCH
function beacon_click_callback(position)
    msfs_event("TOGGLE_BEACON_LIGHTS")
end
beacon_switch_id = switch_add("white knob off.png", "white knob.png", 308,460,28,98, beacon_click_callback)

function cb_beacon_switch(sw_pos) 
    switch_set_position(beacon_switch_id, sw_pos)
end	
msfs_variable_subscribe("LIGHT BEACON", "Bool", cb_beacon_switch)
-- END BEACON SWITCH

-- LANDING LIGHT SWITCH
function landing_click_callback(position)
    if position == 0 then
        msfs_event("LANDING_LIGHTS_ON")
    elseif position == 1 then
        msfs_event("LANDING_LIGHTS_OFF")
    end
end
landing_switch_id = switch_add("white knob off.png", "white knob.png", 379,460,28,98, landing_click_callback)

function cb_landing_switch(sw_pos)
    switch_set_position(landing_switch_id, sw_pos)
end
msfs_variable_subscribe("LIGHT LANDING", "Bool", cb_landing_switch)
-- END LANDING LIGHT SWITCH

-- TAXI LIGHT SWITCH
function taxi_click_callback(position)
    msfs_event("TOGGLE_TAXI_LIGHTS")
end
taxi_switch_id = switch_add("white knob off.png", "white knob.png", 449,460,28,98,  taxi_click_callback)

function cb_taxi(sw_pos)
    switch_set_position(taxi_switch_id, sw_pos)
end	
msfs_variable_subscribe("LIGHT TAXI", "Bool", cb_taxi)
-- END TAXI LIGHT SWITCH

-- NAV LIGHTS SWITCH
function nav_click_callback(position)
    msfs_event("TOGGLE_NAV_LIGHTS")
end
nav_switch_id = switch_add("white knob off.png", "white knob.png", 518,460,28,98, nav_click_callback)

function cb_nav(sw_pos)
    switch_set_position(nav_switch_id,sw_pos)
end	
msfs_variable_subscribe("LIGHT NAV", "Bool", cb_nav)
-- END NAV LIGHTS SWITCH

-- STROBE SWITCH
function strobe_click_callback(position)
    if position == 0 then
        msfs_event("STROBES_ON")
    elseif position == 1 then
        msfs_event("STROBES_OFF")
    end
end

strobe_switch_id = switch_add("white knob off.png", "white knob.png", 593,460,28,98, strobe_click_callback)

function cb_strobe(sw_pos)
    switch_set_position(strobe_switch_id, sw_pos)
end	


msfs_variable_subscribe("LIGHT STROBE", "Bool", cb_strobe)
-- END STROBE SWITCH

-- FUEL PUMP SWITCH
function pump_click_callback(position)

        if position == 0 then
            fs2024_event("B:FUEL_PUMP_1", 1)
        else
            fs2024_event("B:FUEL_PUMP_1", 0)
        end
        fs2020_event("TOGGLE_ELECT_FUEL_PUMP")

end

pump_switch_id = switch_add("white knob off.png", "white knob.png", 308,602,28,98, pump_click_callback)

function cb_pump(sw_pos)
    switch_set_position(pump_switch_id, sw_pos) 
end

fs2024_variable_subscribe("FUELSYSTEM PUMP SWITCH:1", "Bool", cb_pump)
fs2020_variable_subscribe("GENERAL ENG FUEL PUMP SWITCH:1", "Bool", cb_pump)

-- END FUEL PUMP SWITCH


-- PITOT HEAT SWITCH
function pitot_click_callback(position)
    msfs_event("PITOT_HEAT_TOGGLE")
end

pitot_switch_id = switch_add("green knob off.png", "green knob.png", 380,602,28,98, pitot_click_callback)

function new_pitot_pos(pitot)
  --  print(pitot)
    if pitot == 1 then
        switch_set_position(pitot_switch_id, 1)
    else
        switch_set_position(pitot_switch_id, 0)
    end
end
msfs_variable_subscribe("PITOT HEAT SWITCH:1", "Number", new_pitot_pos)

-- END PITOT HEAT SWITCH

-- CABIN POWER SWITCH
-- no variable for position, so may be out of sync until you cycle it
-- INOP for 2020

function cb_power(position)
    --I switches stay in sync, but no real effect in sim
--    sound_play(snd_inop)
    if position == 0 then
        position = 1
    else
        position = 0
    end
    switch_set_position(power_switch_id, position)
    fs2024_event("B:ELECTRICAL_ELECTRICAL_SWITCH_POWER12V", position)
end

power_switch_id = switch_add("white knob off.png", "white knob.png", 447,602,28,98, cb_power)

function p12v(p12v_pos)
    switch_set_position(power_switch_id, p12v_pos)
end

fs2024_event_subscribe("B:ELECTRICAL_ELECTRICAL_SWITCH_POWER12V", p12v)
-- END CABIN POWER SWITCH


-- ALTERNATOR SWITCH
function alt_click_callback(position)

    if position == 0 then
        msfs_event("TOGGLE_MASTER_ALTERNATOR")
    elseif position == 1 then
        msfs_event("TOGGLE_MASTER_ALTERNATOR")
    end

end

alt_switch_id = switch_add("master_right_off.png", "master_right_on.png", 70,263, 72,150,alt_click_callback)

function cb_alternator(sw_pos)

    switch_set_position(alt_switch_id, sw_pos)

end

msfs_variable_subscribe("GENERAL ENG MASTER ALTERNATOR", "Bool", cb_alternator)
-- END ALTERNATOR SWITCH


-- BATTERY SWITCH
function bat_click_callback(position)
     if batt1_pos == true then
        fs2024_event("B:ELECTRICAL_BATTERY_1", 0)
        fs2020_event("BATTERY1_SET", 0)
    else
        fs2024_event("B:ELECTRICAL_BATTERY_1", 1)
        fs2020_event("BATTERY1_SET", 1)
    end
end

bat_switch_id = switch_add("master_left_off.png", "master_left_on.png",110,263, 72,150,bat_click_callback)

function cb_battery(sw_pos)
--    print(sw_pos)
    if sw_pos then
        switch_set_position(bat_switch_id, 1)
    else
        switch_set_position(bat_switch_id, 0)
    end
    batt1_pos = sw_pos
end	
fs2024_variable_subscribe("ELECTRICAL MASTER BATTERY:2", "Bool", cb_battery)
fs2020_variable_subscribe("ELECTRICAL MASTER BATTERY:1", "Bool", cb_battery)

-- END BATTERY SWITCH

-- AVIONICS 
function avionics1_click(position)
    if position == 1 then
         fs2020_event("B:ELECTRICAL_Avionics_Bus_1", 0)
         fs2024_event("B:ELECTRICAL_LINE_BUS_1_TO_AVIONICS_BUS_1", 0)
    else
        fs2020_event("B:ELECTRICAL_Avionics_Bus_1", 1)
        fs2024_event("B:ELECTRICAL_LINE_BUS_1_TO_AVIONICS_BUS_1", 1)
    end
end
avion_1_switch_id = switch_add("white_rock_off.png", "white_rock_on.png",227,275, 37,121, avionics1_click)

function avionics2_click(position)
    if position == 1 then
         fs2020_event("B:ELECTRICAL_Avionics_Bus_2", 0)
         fs2024_event("B:ELECTRICAL_LINE_BUS_2_TO_AVIONICS_BUS_2", 0)
    else
         fs2020_event("B:ELECTRICAL_Avionics_Bus_2", 1)
         fs2024_event("B:ELECTRICAL_LINE_BUS_2_TO_AVIONICS_BUS_2", 1)
    end
end
avion_2_switch_id = switch_add("white_rock_off.png", "white_rock_on.png",268,275, 37,121, avionics2_click)

--fs2020 only
function cb_avionics(sw_1, sw_2)
    sw1_pos = sw_1
    sw2_pos = sw_2
    switch_set_position(avion_1_switch_id, sw1_pos)
    switch_set_position(avion_2_switch_id, sw2_pos)
end
fs2020_variable_subscribe("AVIONICS MASTER SWITCH:1", "Bool",
                                                "AVIONICS MASTER SWITCH:2", "Bool", 
                                               cb_avionics)
                                               
-- 2024 set switche based on system state
function av2(av2_pos)
    switch_set_position(avion_2_switch_id, av2_pos)
end

fs2024_variable_subscribe("CIRCUIT AVIONICS ON:2", "Bool", av2)

function av1(av1_pos)
    switch_set_position(avion_1_switch_id, av1_pos)
end

-- av bus 1 is always on in 2024, this makes the switches stay in sync, but it doesn't matter if its off, it'll be on in sim
switch_set_position(avion_1_switch_id, true)
fs2024_event_subscribe("B:ELECTRICAL_LINE_BUS_1_TO_AVIONICS_BUS_1", av1)

-- END AVIONICS 



--DIMMING 
local settings = { { 0 , 0 },
                   { 100, 135 } }

 --panels
    
function cb_panel(direction)
    if (panel_pos < 5 and direction == -1) then
        panel_pos = 0
    elseif panel_pos > 95 and direction == 1 then
        panel_pos = 100
    else
        panel_pos = panel_pos + (direction * 5)
    end
        
    fs2024_variable_write("L:LIGHTING_PANEL_1", "Number", panel_pos)
     fs2024_event("B:LIGHTING_PANEL_1", panel_pos)
     fs2020_variable_write("L:LIGHTING_POTENTIOMETER_3", "Number", panel_pos)
     fs2020_event("B:LIGHTING_POTENTIOMETER_3", panel_pos)
end    

knob_panel_id = dial_add(nil, 90, 498, 64, 64, cb_panel)    
knob_panel_img = img_add("delta_knob.png", 90, 498, 64, 64)


function panel(level)
        panel_pos = level
        rotate(knob_panel_img, 270 + interpolate_linear(settings, level))
end

fs2024_variable_subscribe("L:LIGHTING_PANEL_1",  "Number", panel)
fs2020_variable_subscribe("L:LIGHTING_POTENTIOMETER_3",  "Number", panel)

-- stdb instruments

function cb_inst(direction)

    if (inst_pos < 5 and direction == -1) then
        inst_pos = 0
    elseif inst_pos > 95 and direction == 1 then
        inst_pos = 100
    else
        inst_pos = inst_pos + (direction * 5)
    end
        
     fs2024_variable_write("L:LIGHTING_PANEL_2", "Number", inst_pos)
     fs2024_event("B:LIGHTING_PANEL_2", inst_pos)
     fs2020_variable_write("L:LIGHTING_PANEL_1", "Number", inst_pos)
     fs2020_event("B:LIGHTING_PANEL_1", inst_pos)
end    

knob_inst_id = dial_add(nil,180, 498, 64, 64, cb_inst)    
knob_inst_img = img_add("delta_knob.png", 180, 498, 64, 64)


function panel(level)
        inst_pos = level
        rotate(knob_inst_img, 270 + interpolate_linear(settings, level))
end

fs2024_variable_subscribe("L:LIGHTING_PANEL_2",  "Number", panel)
fs2020_variable_subscribe("L:LIGHTING_PANEL_1",  "Number", panel)

    --pedestal
function cb_ped(direction)

    if (ped_pos < 5 and direction == -1) then
        ped_pos = 0
    elseif ped_pos > 95 and direction == 1 then
        ped_pos = 100
    else
        ped_pos = ped_pos + (direction * 5)
    end
        
     msfs_variable_write("L:LIGHTING_PEDESTRAL_1", "Number", ped_pos)
     msfs_event("B:LIGHTING_PEDESTRAL_1", ped_pos)
end    

knob_ped_id = dial_add(nil,90, 604, 64, 64, cb_ped)    
knob_ped_img = img_add("delta_knob.png", 90, 604, 64, 64)


function panel(level)
        ped_pos = level
        rotate(knob_ped_img, 270 + interpolate_linear(settings, level))
end

msfs_variable_subscribe("L:LIGHTING_PEDESTRAL_1",  "Number", panel)

    --avionics
function cb_av(direction)

    if (av_pos < 5 and direction == -1) then
        av_pos = 0
    elseif av_pos > 95 and direction == 1 then
        av_pos = 100
    else
        av_pos = av_pos + (direction * 5)
    end
        
     fs2024_variable_write("L:LIGHTING_POTENTIOMETER_5", "Number", av_pos)
     fs2024_event("B:LIGHTING_POTENTIOMETER_5", av_pos)
     fs2020_variable_write("L:LIGHTING_POTENTIOMETER_4", "Number", av_pos)
     fs2020_event("B:LIGHTING_POTENTIOMETER_4", av_pos)
end    

knob_av_id = dial_add(nil,180, 604, 64, 64, cb_av)    
knob_av_img = img_add("delta_knob.png", 180, 604, 64, 64)


function panel(level)
        av_pos = level
        rotate(knob_av_img, 270 + interpolate_linear(settings, level))
end

fs2024_variable_subscribe("L:LIGHTING_POTENTIOMETER_5",  "Number", panel)
fs2020_variable_subscribe("L:LIGHTING_POTENTIOMETER_4",  "Number", panel)
--END DIMMING

