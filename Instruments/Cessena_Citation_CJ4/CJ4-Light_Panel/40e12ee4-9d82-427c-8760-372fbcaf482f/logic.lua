--[[
--******************************************************************************************
-- ******************Cessna Citation CJ4 Light Control Panel****************************
--******************************************************************************************

- **v1.0** 8-2-21 Joe "Crunchmeister" Gilker
    - Original Panel Created
- **v1.1** 8-29-21 Todd "Toddimus831" Lorey 
    - Added seatbelt, safety and pulse light functionality
- **v1.2** 8-30-21 Rob "FlightLevelRob" Verdon 
    - Added variable subscribe for lights: Beacon,Nav,Strobe,Taxi,LNDG,Logo,Belt,Safety,RecLt. 
    - Removed toggle code now that variable subscribe is working.
- **v1.3** 9-9-21 Herbert Puukka
    - Repalced Background Graphic to remove back edges.		
- **v1.4** 9-13-21 Rob "FlightLevelRob" Verdon 			
    - Added panel dimming functionality
- **v1.5** 9-15-2021 Joe "Crunchmeister" Gilker
    - Total custom graphics overhaul    
    			
    						
    												
						
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
click_snd=sound_add("click.wav")


panel_knob_img = img_add("panel_dimmer.png", 279, 34, 152, 152)

small_knob_outer_left = img_add("smallKnob_outer.png",144,55,94, 94)
small_knob_inner_left = img_add("smallKnob_inner.png",162,69,57, 57)

small_knob_outer_right = img_add("smallKnob_outer.png",474,55,94, 94)
small_knob_inner_right = img_add("smallKnob_inner.png",493,69,57, 57)


--subscribe to position
function panel_dimming_pos(sw_pos)
--print "position is:"
--print (sw_pos)
    if sw_pos == 0.1 then
        switch_set_position(panel_dimming_switch, 0)
        rotate (panel_knob_img, -120)  
    elseif  sw_pos == 0.2 then
        switch_set_position(panel_dimming_switch, 1)
	rotate (panel_knob_img, -100) 
    elseif  sw_pos == 0.3 then
        switch_set_position(panel_dimming_switch, 2)
	rotate (panel_knob_img, -80) 
    elseif  sw_pos == 0.4 then
        switch_set_position(panel_dimming_switch, 3)
	rotate (panel_knob_img, -40) 	
    elseif  sw_pos == 0.5 then
        switch_set_position(panel_dimming_switch, 4)
	rotate (panel_knob_img, 0) 
    elseif  sw_pos == 0.6 then
        switch_set_position(panel_dimming_switch, 5)
	rotate (panel_knob_img, 40)
	

    elseif  sw_pos > 0.6 and sw_pos < 0.8 then
	--print "sw_pos=0.7, just set position to 6"
        switch_set_position(panel_dimming_switch, 6)
	rotate (panel_knob_img, 80)

    elseif  sw_pos == 0.8 then
        switch_set_position(panel_dimming_switch, 7)
	rotate (panel_knob_img, 100)
--	print "sw_pos=0.8, just set position to 7"
    elseif  sw_pos == 0.9 then
        switch_set_position(panel_dimming_switch, 8)
	rotate (panel_knob_img, 120)	
    elseif  sw_pos == 1 then
        switch_set_position(panel_dimming_switch, 9)
        rotate (panel_knob_img, 150)
    end
end 
fs2020_variable_subscribe("A:LIGHT POTENTIOMETER:3", "Number", panel_dimming_pos)
--trying to see if L var is readable
--fs2020_variable_subscribe("L:LIGHTING_Knob_Master", "Int", panel_dimming_pos)
--fs2020_variable_subscribe("K:LIGHT POTENTIOMETER 3 SET", "Int", panel_dimming_pos)



function panel_dimming_callback(position, direction)
--print "Position:"

    if direction == 1 then           -- turned dial to the right 
      --  print "Called To go Right"
      --  print (position) 
        if position == 0 then    
            fs2020_variable_write("L:LIGHTING_Knob_Master", "Int",20)  
        elseif  position == 1 then    
            fs2020_variable_write("L:LIGHTING_Knob_Master", "Int",30) 
        elseif  position == 2 then    
            fs2020_variable_write("L:LIGHTING_Knob_Master", "Int",40) 
        elseif  position == 3 then    
            fs2020_variable_write("L:LIGHTING_Knob_Master", "Int",50) 
        elseif  position == 4 then    
            fs2020_variable_write("L:LIGHTING_Knob_Master", "Int",60)      
        elseif  position == 5 then   
            fs2020_variable_write("L:LIGHTING_Knob_Master", "Int",70) 
        elseif  position == 6 then    
            fs2020_variable_write("L:LIGHTING_Knob_Master", "Int",80) 
        elseif  position == 7 then    
            fs2020_variable_write("L:LIGHTING_Knob_Master", "Int",90) 
        elseif  position == 8 then    
            fs2020_variable_write("L:LIGHTING_Knob_Master", "Int",100) 
        elseif  position == 9 then    
           -- Can't go any more
        end
          
    else            -- turned dial to the left
       -- print "Called To go Left"
       -- print (position)
        if position == 0 then    
           -- Can't go any more  
        elseif  position == 1 then    
            fs2020_variable_write("L:LIGHTING_Knob_Master", "Int",10) 
        elseif  position == 2 then    
            fs2020_variable_write("L:LIGHTING_Knob_Master", "Int",20) 
        elseif  position == 3 then    
            fs2020_variable_write("L:LIGHTING_Knob_Master", "Int",30) 
        elseif  position == 4 then    
            fs2020_variable_write("L:LIGHTING_Knob_Master", "Int",40)      
        elseif  position == 5 then    
            fs2020_variable_write("L:LIGHTING_Knob_Master", "Int",50) 
        elseif  position == 6 then    
            fs2020_variable_write("L:LIGHTING_Knob_Master", "Int",60) 
        elseif  position == 7 then    
            fs2020_variable_write("L:LIGHTING_Knob_Master", "Int",70) 
        elseif  position == 8 then    
            fs2020_variable_write("L:LIGHTING_Knob_Master", "Int",80) 
        elseif  position == 9 then    
            fs2020_variable_write("L:LIGHTING_Knob_Master", "Int",90)      
                                      
        end
    end


end
panel_dimming_switch = switch_add(nil,nil,nil,nil,nil,nil,nil,nil,nil,nil, 285, 40, 140, 140, panel_dimming_callback)





---------PFD1
--[[

function pfd1_dimming_callback(position, direction)
--print "Position:"

    if direction == 1 then           -- turned dial to the right 
      --  print "Called To go Right"
      --  print (position) 
        if position == 0 then    
            fs2020_variable_write("L:LIGHTING_Strobe_0", "Int",100) --this current sets TTValue
            fs2020_variable_write("L:LIGHTING_Knob_PFD_1", "Float",100)
           -- fs2020_variable_write("L:LIGHT POTENTIOMETER:15", "Float",100)
            --fs2020_variable_write("L:LIGHTING_POTENTIOMETER_15_Inc", "Number",0)
            --fs2020_variable_write("L:AS3000_Brightness", "Number",10)
            print "going"
        end
     end
end  
pfd1_dimming_switch = switch_add("beacon_off.png",nil,nil,nil,nil,nil,nil,nil,nil,nil,nil, 130, 40, 120, 120, pfd1_dimming_callback)


--]]


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