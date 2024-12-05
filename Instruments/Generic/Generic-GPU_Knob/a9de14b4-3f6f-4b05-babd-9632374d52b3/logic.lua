--[[
--******************************************************************************************
-- ***********************Generic - Ground Power Unit Knob*****************************
--******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation

- **v1.0** 9-18-21 Rob "FlightLevelRob" Verdon
    - Original Panel Created
- **v2.0** 01-19-22 SIMSTRUMENTATION
    - Graphics Updated
    - Added LED indicator to tell when Ground Power is Available
    - Added user option to select aircraft that support backlighting or generic that doesn't support any backlighting.
    

##Left To Do:
    - 

##Notes:
    - This knob is compatiable with all aircraft that support GPU/External Power. 
    - There is a user option to select aircraft for the purposing of backlighting according to dimmer knob.
    - There is a user option to hide background.
    - This knob is compatiable with SIMSTRUMENTATION Ambient Light Dimmer.
										 					  													   
--******************************************************************************************
--]]

--=============================================================================
-- Ground Power Unit Knob
--=============================================================================

prop_BG = user_prop_add_boolean("Display Background",true,"Show grey background")
prop_aircraft = user_prop_add_enum("Select Aircraft to match", "WT CJ4, Generic", "WT CJ4", "Used for backlighting and power.")

if user_prop_get(prop_BG) == true then
    img_add_fullscreen("background.png")
    img_bg_night = img_add_fullscreen("background_night.png")
end    

img_labels = img_add_fullscreen("labels.png")
img_labels_backlight = img_add_fullscreen("labels_backlight.png")
img_knob = img_add("knob.png", 62, 80, 125, 125)
img_knob_night = img_add("knob_night.png", 62, 80, 125, 125)

img_knob_indicator_backlight = img_add("knob_inidicator_backlight.png", 62, 80, 125, 125)

img_led_off = img_add("led_off.png", 106, 40, 36, 36)
img_led_on = img_add("led_on.png", 106, 40, 36, 36)
opacity(img_led_on, 0)

-- Load sound
snd_dial = sound_add("dial.wav")
--******************************************************************************************
-- Ambient Light Control
function ss_ambient_darkness(value)
        if user_prop_get(prop_BG) == true then
            opacity(img_bg_night, value, "LOG", 0.04)    --set this panels night background 
        end
    opacity(img_knob_night, value, "LOG", 0.04)
    opacity(img_labels, (1-value), "LOG", 0.04) 
end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)
--Backlighting
function ss_backlighting_WTCJ4(value, power)
    value = var_round(value,2)      
    if value == 1.0 or power == false  then 
        opacity(img_labels_backlight, 0.1, "LOG", 0.04)
        opacity(img_knob_indicator_backlight, 0.0, "LOG", 0.04)
    else
        opacity(img_labels_backlight, ((value/2)+0.5), "LOG", 0.04)
        opacity(img_knob_indicator_backlight, ((value/2)+0.5), "LOG", 0.04)
    end
end

if  (user_prop_get(prop_aircraft) =="WT CJ4") then
    msfs_variable_subscribe("A:LIGHT POTENTIOMETER:3", "Number",
                                                  "CIRCUIT GENERAL PANEL ON","Bool", ss_backlighting_WTCJ4)
--Enter more aircraft here                                                 
else -- Doesn't support backlight
        opacity(img_labels_backlight, 0.1, "LOG", 0.04)
        opacity(img_knob_indicator_backlight, 0.0, "LOG", 0.04)   
end
						  
--=============================================================================
function ss_avail_GPU(avail)
    if avail then
        opacity(img_led_on, 1)
    else
        opacity(img_led_on, 0)        
    end    
end
msfs_variable_subscribe("EXTERNAL POWER AVAILABLE", "bool", ss_avail_GPU)
--subscribe to position
function pos_GPU(sw_on)
    if sw_on == 0 then
        switch_set_position(sw_GPU, 0)
	rotate (img_knob, -55,"LOG", 0.1) 
        rotate (img_knob_night, -55,"LOG", 0.1)    
        rotate (img_knob_indicator_backlight, -55,"LOG", 0.1)  
    elseif  sw_on == 1 then
        switch_set_position(sw_GPU, 1)
	rotate (img_knob, 50,"LOG", 0.1) 
        rotate (img_knob_night, 50,"LOG", 0.1)    
        rotate (img_knob_indicator_backlight, 50,"LOG", 0.1)  
    end
end 
msfs_variable_subscribe("EXTERNAL POWER ON", "Number", pos_GPU)

--toggle gpu power on/off
function callback_GPU(position, direction)		   
          msfs_event("K:TOGGLE_EXTERNAL_POWER") 
          sound_play(snd_dial)
end
sw_GPU = switch_add(nil,nil, 50, 90, 140, 140, callback_GPU)

