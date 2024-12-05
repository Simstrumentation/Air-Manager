--[[
******************************************************************************************
******************Cessna Citation CJ4 Standby Flight Instrument Overlay***************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: http://simstrumentation.com
   
- **v1.0** 08-2021 Joe "Crunchmeister" Gilker
    - Original Instrument created
- **v2.0** 08-2021 Joe "Crunchmeister" Gilker
    - Added Backlight
    - Added Ambient Dimming
--*********END OF INTERNAL ALPHA TESTING****************
- **v2.0** 10-5-2021 Rob "FlightLevelRob" Verdon and Joe "Crunchmeister" Gilker and Todd "Toddimus831" Lorey
    !!- Initial Public Release -!!
    - Variable renaming for clarity
    - Added backlight logic to account for battery, external power and bus volts status
- **v2.01** 10-6-2021
    - Updated preview graphic
- **v2.1** 01-16-2022
    - Baro knob now adjust Standby Instrument.
    - Display now dims with SIMSTRUMENTATION Ambient Light Panel by default, there is a user prop to change this to either the PFD1 screen dim value or leave bright always.
    - Added dial sound.
    - Resource folder file capitials renamed for SI Store submittion  
- **v2.2** 12-06-2022 Joe "Crunchmeister" Gilker       
    - Updated code to reflect AAU1 being released in 2023Q1    
    
## Left To Do:
  - N/A
	
## Notes:
  - N/A
    
******************************************************************************************
--]]
screen_dim = user_prop_add_enum("Dim Display with SIMSTRUMENTATION Ambient Light Dimmer, PFD1 Dimmer, Or Leave Always Bright.", "AmbientLight,PFD1,AlwaysBright", "AmbientLight", "")
dial_snd = sound_add("dial.wav")

img_screen_dimmer = img_add("background_dim.png", 110, 60, 440, 440)
img_add_fullscreen("background.png")
img_bg_night = img_add_fullscreen("background_night.png")
-- Ambient Light Control
function ss_ambient_darkness(value)
    opacity(img_bg_night, value, "LOG", 0.04)
    opacity(dial_baro_night, value, "LOG", 0.04)
     if user_prop_get(screen_dim) == "AmbientLight" then
        opacity(img_screen_dimmer, (( (value / 2))), "LOG", 0.04)
     end
end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)

img_backlight = img_add_fullscreen("backlight.png")

function ss_backlighting(value, panellight, power, extpower, busvolts)
    value = var_round(value,2)      
    if  panellight == false  or (power == false and extpower == false and busvolts < 5) then 
        opacity(img_backlight, 0.1, "LOG", 0.04)
    else
        opacity(img_backlight, ((value/2)+0.5), "LOG", 0.04)
    end
end
msfs_variable_subscribe("A:LIGHT POTENTIOMETER:3", "Number",
                           "LIGHT PANEL","Bool",
                          "ELECTRICAL MASTER BATTERY","Bool",
                          "EXTERNAL POWER ON:1", "Bool",
                          "ELECTRICAL MAIN BUS VOLTAGE", "Volts", ss_backlighting)

function ss_screen_dim(value) 
    if user_prop_get(screen_dim) == "PFD1" then
        opacity(img_screen_dimmer, 0.5-(value / 2), "LOG", 0.04)
    elseif user_prop_get(screen_dim) == "AlwaysBright" then
        opacity(img_screen_dimmer, 0, "LOG", 0.04)
    end
end
msfs_variable_subscribe("A:LIGHT POTENTIOMETER:15", "Number", ss_screen_dim)						  						  						  						  
						  						  						  						  						  						  
function turn_baroknob_cb (knobdirection)
   sound_play(dial_snd)
     if knobdirection > 0 then
      msfs_event("KOHLSMAN_INC",2)
    else
      msfs_event("KOHLSMAN_DEC",2)
    end
  end
  
  dial_baro = dial_add("knob.png" , 510 , 496 , 82 , 82 , turn_baroknob_cb)
  dial_baro_night = img_add("knob_night.png" , 510 , 496 , 82 , 82)
  dial_click_rotate(dial_baro, 6)
  