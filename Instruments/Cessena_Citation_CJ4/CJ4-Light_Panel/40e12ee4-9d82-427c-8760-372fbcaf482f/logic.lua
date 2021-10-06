--[[
******************************************************************************************
******************Cessna Citation CJ4 Light Control Panel*******************************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation

- **v1.0** 08-2-21 Joe "Crunchmeister" Gilker
    - Original Panel Created
- **v1.1** 08-29-21 Todd "Toddimus831" Lorey 
    - Added seatbelt, safety and pulse light functionality
- **v1.2** 08-30-21 Rob "FlightLevelRob" Verdon 
    - Added variable subscribe for lights: Beacon,Nav,Strobe,Taxi,LNDG,Logo,Belt,Safety,RecLt. 
    - Removed toggle code now that variable subscribe is working.
- **v1.3** 09-9-21 Herbert Puukka
    - Repalced Background Graphic to remove back edges.		
- **v1.4** 09-13-21 Rob "FlightLevelRob" Verdon 			
    - Added panel dimming functionality
- **v1.5** 09-15-2021 Joe "Crunchmeister" Gilker
    - Total custom graphics overhaul    
- **v2.0** 09-18-21 Rob "FlightLevelRob" Verdon and Joe "Crunchmeister" Gilker		
    - Added PFD/MFD dimming functionality    			
    - Rewrote code to define what variables are.
--*********END OF INTERNAL ALPHA TESTING****************
- **v2.0** 10-5-21 Rob "FlightLevelRob" Verdon and Joe "Crunchmeister" Gilker and Todd "Toddimus831" Lorey
    !!- Initial Public Release -!!
    - Variable renaming for clarity
    - Added backlight logic to account for battery, external power and bus volts status
    																						
##Left To Do:
    - 
	
##Notes:
    - The Panel Dimmer (BackLighting) in the cockpit allows you to turn all the way to the left and should set A:Light Potentiometer:3 to a Double value of "0.0" but in the game it remains as "0.10", which is the value before, whichi i believe is a bug in the game. Thus this causes this panel to act strange if you overturn to the left.
    - TCAS is INOP in game. Not used.
    - You may have to push the in-game cockpit buttons twice to turn off a light if you turned it on from AirManager. Not sure if a WT issue or Asbro issue. The "toggle" events do not seem to update tooltips, could probably use LVARS as it does update when using ExtController.
										 					  													   
******************************************************************************************
--]]

--===========IMPORT ASSETS==============================

img_add_fullscreen("background.png")

snd_fail = sound_add("beepfail.wav")
snd_click = sound_add("click.wav")
snd_dial = sound_add("dial.wav")

local value_recon_position = 0
local value_taxi_position = 0


img_bg_night = img_add_fullscreen("background_night.png")
-- Ambient Light Control
function ss_ambient_darkness(value)
    opacity(img_bg_night, value, "LOG", 0.04)
    opacity(img_panel_knob_night, value, "LOG", 0.04)
    opacity(img_small_knob_outer_left_night, value, "LOG", 0.04)
    opacity(img_small_knob_inner_left_night , value, "LOG", 0.04)
    opacity(img_small_knob_inner_right_night, value, "LOG", 0.04)
    opacity(img_small_knob_outer_right_night, value, "LOG", 0.04)

end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)



--Backlighting
img_labels_backlight = img_add_fullscreen("backlight.png")
opacity(img_labels_backlight, 0.0)

--Knobs--
--Panel Dimmer
img_panel_knob = img_add("panel_dimmer.png", 289, 45, 134, 134)
img_panel_knob_night = img_add("panel_dimmer_night.png", 289, 45, 134, 134)
img_dimmer_indicator = img_add("panel_dimmer_inidicator.png", 289, 42, 134, 134)

-- Left PFD / MFD
img_small_knob_outer_left = img_add("smallKnob_outer.png",144,55,94, 94)
img_small_knob_outer_left_night = img_add("smallKnob_outer_night.png",144,55,94, 94)

img_small_knob_inner_left = img_add("smallKnob_inner.png",162,73,57, 57)
img_small_knob_inner_left_night = img_add("smallKnob_inner_night.png",162,73,57, 57)

--Right PFD / MFD
img_small_knob_outer_right = img_add("smallKnob_outer.png",474,55,94, 94)
img_small_knob_outer_right_night = img_add("smallKnob_outer_night.png",474,55,94, 94)

img_small_knob_inner_right = img_add("smallKnob_inner.png",493,73,57, 57)
img_small_knob_inner_right_night = img_add("smallKnob_inner_night.png",493,73,57, 57)


--Global SI Variables
sivar_overlay_pfd1 = si_variable_create("sivar_overlay_pfd1_dim", "FLOAT", 0.0)
sivar_overlay_mfd1 = si_variable_create("sivar_overlay_mfd1_dim", "FLOAT", 0.0)

--===========User Props==============================
--UserProp to Set if PFD/MFD's dim with dials.
prop_pfdmfd_dim_with_dial = user_prop_add_boolean("Dim Air Manager's Overlay PFD & MFD with Dimmer Dial", true, "Disable this if you do not want Air Manager to dim the Popped out PFD(or MFD) Overlay when you turn the dial's on the this light panel (or in the game cockpit). Thus it will only dim the ingame cockpit screens.") 

--====================================================


--Should PFD1 Dim with Dials?
function write_to_overlay_pfd1(pfd1_value)
    if user_prop_get (prop_pfdmfd_dim_with_dial) == true then
        si_variable_write(sivar_overlay_pfd1, pfd1_value) 
    end
end    
--Should MFD1 Dim with Dials?
function write_to_overlay_mfd1(mfd1_value)
    if user_prop_get (prop_pfdmfd_dim_with_dial) == true then
        si_variable_write(sivar_overlay_mfd1, mfd1_value) 
    end
end



--******************************************************************************************
-------Panel Backlighting
function ss_backlighting(value, power, extpower, busvolts)
    value = var_round(value,2)
    --print (value)
    rotate (img_panel_knob, (value*290),"LOG", 0.1)
    rotate (img_panel_knob_night, (value*290),"LOG", 0.1)
    rotate (img_dimmer_indicator, (value*290),"LOG", 0.1)
    switch_set_position(sw_backlighting, (value * 10)) 
    if value == 1.0 or (power == false and extpower == false and busvolts < 5) then 
        opacity(img_labels_backlight, 0.0, "LOG", 0.04)
        opacity(img_dimmer_indicator, 0.0, "LOG", 0.04)
    else
        opacity(img_labels_backlight, ((value/2)+0.5), "LOG", 0.04)
        opacity(img_dimmer_indicator, ((value/2)+0.5), "LOG", 0.04)
        
    end
end
fs2020_variable_subscribe("A:LIGHT POTENTIOMETER:3", "Number",
                          "ELECTRICAL MASTER BATTERY","Bool",
                          "EXTERNAL POWER ON:1", "Bool",
                          "ELECTRICAL MAIN BUS VOLTAGE", "Volts", ss_backlighting)
						  

function callback_backlighting(position, direction)
        fs2020_variable_write("L:LIGHTING_Knob_Master", "Int", var_cap((var_round((position + direction), 0) * 10),0,100))
end
sw_backlighting = switch_add(nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil, 285, 40, 140, 140, callback_backlighting)


---------PFD1 Dimming
local value_pfd1_position = 0

function ss_pfd1_dimming(value)
     value = var_round(value,2)
     rotate (img_small_knob_outer_left, (value*290),"LOG", 0.1)
     switch_set_position(sw_pfd1_dimming, (value * 10))
     value_pfd1_position = (value * 10)
     write_to_overlay_pfd1(0.5-(value / 2))
end
fs2020_variable_subscribe("A:LIGHT POTENTIOMETER:15", "Number", ss_pfd1_dimming)

function callback_pdf1_dimming(position, direction)
     sound_play(snd_dial)
    if direction == 1 then
        fs2020_event("LIGHT_POTENTIOMETER_15_SET", var_cap((var_round(value_pfd1_position,1) * 10)+5,0,100))
    else
        fs2020_event("LIGHT_POTENTIOMETER_15_SET", var_cap((var_round(value_pfd1_position,1)* 10)-5,0,100))
    end
end        
sw_pfd1_dimming = switch_add(nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil, 130, 40, 120, 120, callback_pdf1_dimming)

---------PFD2 Dimming
local value_pfd2_position = 0

function ss_pfd2_dimming(value)
     value = var_round(value,2)
     rotate (img_small_knob_outer_right, (value*290),"LOG", 0.1)
     switch_set_position(sw_pfd2_dimming, (value * 10))
     value_pfd2_position = (value * 10)
end
fs2020_variable_subscribe("A:LIGHT POTENTIOMETER:16", "Number", ss_pfd2_dimming)

function callback_pdf2_dimming(position, direction)
    sound_play(snd_dial)
    if direction == 1 then
        fs2020_event("LIGHT_POTENTIOMETER_16_SET", var_cap((var_round(value_pfd2_position,1) * 10)+5,0,100))
    else
        fs2020_event("LIGHT_POTENTIOMETER_16_SET", var_cap((var_round(value_pfd2_position,1)* 10)-5,0,100))
    end
end        
sw_pfd2_dimming = switch_add(nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil, 465, 40, 120, 120, callback_pdf2_dimming)

---------MFD1 Dimming
local value_mfd1_position = 0

function ss_mfd1_dimming(value)
     value = var_round(value,2)
     rotate (img_small_knob_inner_left, (value*290),"LOG", 0.1)
     switch_set_position(sw_mfd1_dimming, (value * 10))
     value_mfd1_position = (value * 10)
     write_to_overlay_mfd1(0.5-(value / 2))
end
fs2020_variable_subscribe("A:LIGHT POTENTIOMETER:17", "Number", ss_mfd1_dimming)

function callback_mdf1_dimming(position, direction)
    sound_play(snd_dial)
    if direction == 1 then
        fs2020_event("LIGHT_POTENTIOMETER_17_SET", var_cap((var_round(value_mfd1_position,1) * 10)+5,0,100))
    else
        fs2020_event("LIGHT_POTENTIOMETER_17_SET", var_cap((var_round(value_mfd1_position,1)* 10)-5,0,100))
    end
end        
sw_mfd1_dimming = switch_add(nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil, 165, 75, 50, 50, callback_mdf1_dimming)

---------MFD2 Dimming
local value_mfd2_position = 0

function ss_mfd2_dimming(value)
     value = var_round(value,2)
     rotate (img_small_knob_inner_right, (value*290),"LOG", 0.1)
     switch_set_position(sw_mfd2_dimming, (value * 10))
     value_mfd2_position = (value * 10)
end
fs2020_variable_subscribe("A:LIGHT POTENTIOMETER:18", "Number", ss_mfd2_dimming)

function callback_mdf2_dimming(position, direction)
    sound_play(snd_dial)
    if direction == 1 then
        fs2020_event("LIGHT_POTENTIOMETER_18_SET", var_cap((var_round(value_mfd2_position,1) * 10)+5,0,100))
    else
        fs2020_event("LIGHT_POTENTIOMETER_18_SET", var_cap((var_round(value_mfd2_position,1)* 10)-5,0,100))
    end
end        
sw_mfd2_dimming = switch_add(nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil, 495, 75, 50, 50, callback_mdf2_dimming)

--******************************************************************************************
--------SET UP INDIVIDUAL LIGHT SWITCHES

-- BEACON LIGHT
img_beacon_indicator = img_add("button_on.png", 118, 232, 47, 15)
function callback_beacon(position)
    if position == 0 then
        fs2020_event("TOGGLE_BEACON_LIGHTS")
    elseif position == 1 then 
        fs2020_event("TOGGLE_BEACON_LIGHTS")
    end   
    sound_play(snd_click)
end
sw_beacon = switch_add(nil, nil, 110, 227, 65, 50, callback_beacon)

function ss_beacon(sw_on)
    if sw_on  then					    
        switch_set_position(sw_beacon, 1)
        visible(img_beacon_indicator, true)
    else
        switch_set_position(sw_beacon, 0)
        visible(img_beacon_indicator, false)
    end
end     
fs2020_variable_subscribe("LIGHT BEACON ON", "Bool", ss_beacon)
-- END BEACON LIGHT

-- NAV LIGHT
img_nav_indicator = img_add("button_on.png", 215, 232, 47, 15)
function callback_nav(position)
    if position == 0 then
        fs2020_event("TOGGLE_NAV_LIGHTS")
    elseif position == 1 then
        fs2020_event("TOGGLE_NAV_LIGHTS")
    end
    sound_play(snd_click)
end
sw_nav = switch_add(nil, nil, 207, 227, 65, 50, callback_nav)

function ss_nav(sw_on)
    if sw_on   then
        switch_set_position(sw_nav , 1)
        visible(img_nav_indicator, true)        
    else
        switch_set_position(sw_nav , 0)
        visible(img_nav_indicator, false)
    end
end    
fs2020_variable_subscribe("LIGHT NAV ON", "Bool", ss_nav)
-- END NAV LIGHT

-- STROBE LIGHT
img_strobe_indicator = img_add("button_on.png", 315, 232, 47, 15)
function callback_strobe(position)
    if position == 0 then
        fs2020_event("STROBES_TOGGLE")
    elseif position == 1 then
        fs2020_event("STROBES_TOGGLE")
    end
    sound_play(snd_click)
end
sw_strobe = switch_add(nil, nil, 306, 227, 65, 50, callback_strobe)

function ss_strobe(sw_on)
    if sw_on  then
        switch_set_position(sw_strobe, 1)
        visible(img_strobe_indicator, true)        
    else
        switch_set_position(sw_strobe, 0)
        visible(img_strobe_indicator, false)        
    end
end    
fs2020_variable_subscribe("LIGHT STROBE ON", "Bool", ss_strobe)
-- END STROBE LIGHT

-- TAXI LIGHT
img_taxi_indicator = img_add("button_on.png", 118, 310, 47, 15)
function callback_taxi(position)
    if position == 0 then
        fs2020_event("TOGGLE_TAXI_LIGHTS")
        fs2020_event("LANDING_LIGHTS_OFF")
        if value_recon_position == 1 then
            fs2020_event("TOGGLE_RECOGNITION_LIGHTS")
        end          
    elseif position == 1 then
        fs2020_event("TOGGLE_TAXI_LIGHTS")
      
    end
    sound_play(snd_click)
end
sw_taxi = switch_add(nil, nil, 110, 306, 65, 50, callback_taxi)

function ss_taxi(sw_on)
    if sw_on  then
        switch_set_position(sw_taxi, 1)
        visible(img_taxi_indicator, true)
        value_taxi_position = 1
        else
        switch_set_position(sw_taxi, 0)
        visible(img_taxi_indicator, false)
        value_taxi_position = 0
    end
end     
fs2020_variable_subscribe("LIGHT TAXI ON", "Bool", ss_taxi)
-- END TAXI LIGHT

-- LANDING LIGHT
img_landing_indicator = img_add("button_on.png", 215, 310, 47, 15)
function callback_landing(position)
    if position == 0 then
        fs2020_event("LANDING_LIGHTS_TOGGLE")
        if value_taxi_position == 1 then 
            fs2020_event("TOGGLE_TAXI_LIGHTS")                         
        elseif value_recon_position == 1 then 
            fs2020_event("TOGGLE_RECOGNITION_LIGHTS")   
        end
    elseif position == 1 then
        fs2020_event("LANDING_LIGHTS_TOGGLE")
    end
    sound_play(snd_click)
end
sw_landing = switch_add(nil, nil, 208, 306, 65, 50, callback_landing)

function ss_landing(sw_on)
    if sw_on  then
        switch_set_position(sw_landing, 1)
        visible(img_landing_indicator, true)        
    else
        switch_set_position(sw_landing, 0)
        visible(img_landing_indicator, false)        
    end
end    
fs2020_variable_subscribe("LIGHT LANDING ON", "Bool", ss_landing)
-- END LANDING LIGHT

-- LOGO LIGHT
img_logo_indicator = img_add("button_on.png", 315, 310, 47, 15)
function callback_logo(position)
    if position == 0 then
        fs2020_event("TOGGLE_LOGO_LIGHTS")
    elseif position == 1 then
        fs2020_event("TOGGLE_LOGO_LIGHTS")
    end
    sound_play(snd_click)
end
sw_logo = switch_add(nil, nil, 306, 306, 65, 50, callback_logo)

function ss_logo(sw_on)
    if sw_on then
        switch_set_position(sw_logo, 1)
        visible(img_logo_indicator, true)           
    else 
        switch_set_position(sw_logo, 0)
        visible(img_logo_indicator, false)           
    end
end     
fs2020_variable_subscribe("LIGHT LOGO ON", "Bool", ss_logo)
-- END LOGO LIGHT

-- BELT LIGHT
img_belt_indicator = img_add("button_on.png", 445, 232, 47, 15)
function callback_belt(position)
    if position == 0 then
		fs2020_variable_write("L:SEATBELT_LIGHT_ON", "Int",1)         
    elseif position == 1 then
		fs2020_variable_write("L:SEATBELT_LIGHT_ON", "Int",0)
     end
    sound_play(snd_click)
end
sw_belt = switch_add(nil, nil, 434, 227, 65, 50, callback_belt)

function ss_belt(sw_on)
    if sw_on == 1 then
        switch_set_position(sw_belt, 1)
        visible(img_belt_indicator, true)          
    elseif  sw_on == 0 then
        switch_set_position(sw_belt, 0)
        visible(img_belt_indicator, false) 
    end
end 
fs2020_variable_subscribe("L:SEATBELT_LIGHT_ON", "Int", ss_belt)
-- END BELT LIGHT

-- SAFETY LIGHT
img_safety_indicator = img_add("button_on.png", 542, 232, 47, 15)
function callback_safety(position)
    if position == 0 then
		fs2020_variable_write("L:SAFETY_LIGHT_ON", "Int",1)         
    elseif position == 1 then
		fs2020_variable_write("L:SAFETY_LIGHT_ON", "Int",0) 
    end
    sound_play(snd_click)
end
sw_safety = switch_add(nil, nil, 531, 227, 65, 50, callback_safety)

function ss_safety(sw_on)
    if sw_on == 1 then
        switch_set_position(sw_safety, 1)
        visible(img_safety_indicator, true)         
    elseif  sw_on == 0 then
        switch_set_position(sw_safety, 0)
        visible(img_safety_indicator, false)         
    end
end    
fs2020_variable_subscribe("L:SAFETY_LIGHT_ON", "Int", ss_safety)
-- END SAFETY LIGHT

-- TCAS 
--img_tcas_indicator = img_add("button_on.png", 443, 310, 47, 15)
function callback_tcas(position)
    if position == 0 then
        --switch_set_position(sw_tcas, 1)
        --INOP
    elseif position == 1 then
        --switch_set_position(sw_tcas, 0)
        --INOP
    end
    sound_play(snd_fail)
end
sw_tcas = switch_add(nil,nil, 433, 306, 65, 50, callback_tcas)

function ss_tcas(sw_on)
    if sw_on == 1 then
        switch_set_position(sw_tcas, 0)
        visible(img_tcas_indicator, true)        
    elseif  sw_on == 0 then
        switch_set_position(sw_tcas, 1)
        visible(img_tcas_indicator, false)        
    end
end    
--fs2020_variable_subscribe("CABIN SEATBELTS ALERT SWITCH", "Bool", ss_tcas)
-- END TCAS

-- PULSE RECON SWITCH
img_recon_indicator = img_add("button_on.png", 541, 310, 47, 15)
function callback_recon(position)
    if position == 0 then
       -- switch_set_position(on_id, 1)
        fs2020_event("TOGGLE_RECOGNITION_LIGHTS")
                
    elseif position == 1 then
        --switch_set_position(on_id, 0)
        fs2020_event("TOGGLE_RECOGNITION_LIGHTS")
        fs2020_event("LANDING_LIGHTS_OFF")
        if value_taxi_position == 1 then 
            fs2020_event("TOGGLE_TAXI_LIGHTS")       
        end
    end
    sound_play(snd_click)
end
sw_recon = switch_add(nil, nil, 531, 306, 65, 50, callback_recon)

function ss_recon(sw_on)
    if sw_on  then
        switch_set_position(sw_recon, 0)
        visible(img_recon_indicator, true) 
        value_recon_position = 1    
    else 
        switch_set_position(sw_recon, 1)
        visible(img_recon_indicator, false)        
        value_recon_position = 0
    end
end    
fs2020_variable_subscribe("LIGHT RECOGNITION ON", "Bool", ss_recon)
-- END Pulse SWITCH

ss_ambient_darkness(0)
ss_backlighting(0)