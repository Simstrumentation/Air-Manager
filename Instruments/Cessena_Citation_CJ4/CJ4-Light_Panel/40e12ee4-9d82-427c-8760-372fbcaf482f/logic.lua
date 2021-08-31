--[[
--******************************************************************************************
-- ******************Cessna Citation CJ4 Light Control Panel****************************
--******************************************************************************************

v1.0 8-2-21 Joe "Crunchmeister" Gilker
	-Original Panel Created
v1.1 8-29-21 Todd "Toddimus831" Lorey 
	-Added seatbelt, safety and pulse light functionality
v1.2 8-30-21 Rob "FlightLevelRob" Verdon	
	-Added variable subscribe for lights: Beacon,Nav,Strobe,Taxi,LNDG,Logo,Belt,Safety,RecLt. 
	-Removed toggle code now that variable subscribe is working.
	
##Left To Do:
	-Dimming Dials
	
##Notes:
	-TCAS is INOP in game. Not used.
	-You may have to push the in-game cockpit buttons twice to turn off a light if you turned it on from AirManager. Not sure if a WT issue or Asbro issue. The "toggle" events do not seem to update tooltips, could probably use LVARS as it does update when using ExtController.
										 					  													   
--******************************************************************************************
--]]


--IMPORT ASSETS
img_add_fullscreen("bg.png")
fail_snd = sound_add("beepfail.wav")
click_snd=sound_add("Asobo_CJ4_WT_PC_75.wav")


--------SET UP INDIVIDUAL LIGHT SWITCHES

-- BEACON LIGHT
function beacon_click_callback(position)
    if position == 0 then
        fs2020_event("TOGGLE_BEACON_LIGHTS")
    elseif position == 1 then
        fs2020_event("TOGGLE_BEACON_LIGHTS")
    end
    sound_play(click_snd)
end
beacon_id = switch_add("beacon_off.png", "beacon_on.png", 110, 227, 65, 50, beacon_click_callback)

function new_beacon_pos(beacon_on)
    if beacon_on  then					    
        switch_set_position(beacon_id, 1)
    else
        switch_set_position(beacon_id, 0)
    end
end     
fs2020_variable_subscribe("LIGHT BEACON ON", "Bool", new_beacon_pos)
-- END BEACON LIGHT

-- NAV LIGHT
function nav_click_callback(position)
    if position == 0 then
        fs2020_event("TOGGLE_NAV_LIGHTS")
    elseif position == 1 then
        fs2020_event("TOGGLE_NAV_LIGHTS")
    end
    sound_play(click_snd)
end
nav_id = switch_add("nav_off.png", "nav_on.png", 207, 227, 65, 50, nav_click_callback)

function new_nav_pos(nav_on)
    if nav_on   then
        switch_set_position(nav_id, 1)
    else
        switch_set_position(nav_id, 0)
    end
end    
fs2020_variable_subscribe("LIGHT NAV ON", "Bool", new_nav_pos)
-- END NAV LIGHT

-- STROBE LIGHT
function strobe_click_callback(position)
    if position == 0 then
        fs2020_event("STROBES_TOGGLE")
    elseif position == 1 then
        fs2020_event("STROBES_TOGGLE")
    end
    sound_play(click_snd)
end
strobe_id = switch_add("strobe_off.png", "strobe_on.png", 306, 227, 65, 50, strobe_click_callback)

function new_strobe_pos(nav_on)
    if nav_on  then
        switch_set_position(strobe_id, 1)
    else
        switch_set_position(strobe_id, 0)
    end
end    
fs2020_variable_subscribe("LIGHT STROBE ON", "Bool", new_strobe_pos)
-- END STROBE LIGHT

-- TAXI LIGHT
function taxi_click_callback(position)
    if position == 0 then
        fs2020_event("TOGGLE_TAXI_LIGHTS")
    elseif position == 1 then
        fs2020_event("TOGGLE_TAXI_LIGHTS")
    end
    sound_play(click_snd)
end
taxi_id = switch_add("taxi_off.png", "taxi_on.png", 110, 306, 65, 50, taxi_click_callback)

function new_taxi_pos(taxi_on)
    if taxi_on  then
        switch_set_position(taxi_id, 1)
    else
        switch_set_position(taxi_id, 0)
    end
end     
fs2020_variable_subscribe("LIGHT TAXI ON", "Bool", new_taxi_pos)
-- END TAXI LIGHT

-- LANDING LIGHT
function land_click_callback(position)
    if position == 0 then
        fs2020_event("LANDING_LIGHTS_TOGGLE")
    elseif position == 1 then
        fs2020_event("LANDING_LIGHTS_TOGGLE")
    end
    sound_play(click_snd)
end
land_id = switch_add("land_off.png", "land_on.png", 208, 306, 65, 50, land_click_callback)

function new_land_pos(land_on)
    if land_on  then
        switch_set_position(land_id, 1)
    else
        switch_set_position(land_id, 0)
    end
end    
fs2020_variable_subscribe("LIGHT LANDING ON", "Bool", new_land_pos)
-- END LANDING LIGHT

-- LOGO LIGHT
function logo_click_callback(position)
    if position == 0 then
        fs2020_event("TOGGLE_LOGO_LIGHTS")
    elseif position == 1 then
        fs2020_event("TOGGLE_LOGO_LIGHTS")
    end
    sound_play(click_snd)
end
logo_id = switch_add("logo_off.png", "logo_on.png", 306, 306, 65, 50, logo_click_callback)

function new_logo_pos(logo_on)
    if logo_on then
        switch_set_position(logo_id, 1)
    else 
        switch_set_position(logo_id, 0)
    end
end     
fs2020_variable_subscribe("LIGHT LOGO ON", "Bool", new_logo_pos)
-- END LOGO LIGHT

-- BELT LIGHT
function belt_click_callback(position)
    if position == 0 then
		fs2020_variable_write("L:SEATBELT_LIGHT_ON", "Int",1)         
    elseif position == 1 then
		fs2020_variable_write("L:SEATBELT_LIGHT_ON", "Int",0)
     end
    sound_play(click_snd)
end
belt_id = switch_add("belt_off.png", "belt_on.png", 434, 227, 65, 50, belt_click_callback)

function new_belt_pos(sw_on)
    if sw_on == 0 then
        switch_set_position(belt_id, 0)
    elseif  sw_on == 1 then
        switch_set_position(belt_id, 1)
    end
end 
fs2020_variable_subscribe("L:SEATBELT_LIGHT_ON", "Int", new_belt_pos)
-- END BELT LIGHT

-- SAFETY LIGHT
function safety_click_callback(position)
    if position == 0 then
		fs2020_variable_write("L:SAFETY_LIGHT_ON", "Int",1)         
    elseif position == 1 then
		fs2020_variable_write("L:SAFETY_LIGHT_ON", "Int",0) 
    end
    sound_play(click_snd)
end
safety_id = switch_add("safety_off.png", "safety_on.png", 531, 227, 65, 50, safety_click_callback)

function new_safety_pos(sw_on)
    if sw_on == 0 then
        switch_set_position(safety_id, 0)
    elseif  sw_on == 1 then
        switch_set_position(safety_id, 1)
    end
end    
fs2020_variable_subscribe("L:SAFETY_LIGHT_ON", "Int", new_safety_pos)
-- END SAFETY LIGHT

-- TCAS 
function tcas_click_callback(position)
    if position == 0 then
        switch_set_position(tcas_id, 1)
        --INOP
    elseif position == 1 then
        switch_set_position(tcas_id, 0)
        --INOP
    end
    sound_play(fail_snd)
end
tcas_id = switch_add("tcas_off.png", "tcas_off.png", 433, 306, 65, 50, tcas_click_callback)

function new_tcas_pos(sw_on)
    if sw_on == 0 then
        switch_set_position(tcas_id, 0)
    elseif  sw_on == 1 then
        switch_set_position(tcas_id, 1)
    end
end    
--fs2020_variable_subscribe("CABIN SEATBELTS ALERT SWITCH", "Bool", new_tcas_pos)
-- END TCAS

-- PULSE SWITCH
function on_click_callback(position)
    if position == 0 then
       -- switch_set_position(on_id, 1)
        fs2020_event("TOGGLE_RECOGNITION_LIGHTS")
    elseif position == 1 then
        --switch_set_position(on_id, 0)
        fs2020_event("TOGGLE_RECOGNITION_LIGHTS")
    end
    sound_play(click_snd)
end
on_id = switch_add("on_off.png", "on_on.png", 531, 306, 65, 50, on_click_callback)

function new_on_pos(sw_on)
    if sw_on == false then
        switch_set_position(on_id, 0)
    elseif  sw_on == true then
        switch_set_position(on_id, 1)
    end
end    
fs2020_variable_subscribe("LIGHT RECOGNITION ON", "Bool", new_on_pos)
-- END Pulse SWITCH