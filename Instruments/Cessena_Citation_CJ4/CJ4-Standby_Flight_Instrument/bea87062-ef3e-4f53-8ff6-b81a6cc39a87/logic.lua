--[[
******************************************************************************************
******************Cessna Citation CJ4 Standby Flight Instrument Overlay***************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation
   
- **v1.0** 08-2021 Joe "Crunchmeister" Gilker
    - Original Instrument created
- **v2.0** 08-2021 Joe "Crunchmeister" Gilker
    - Added Backlight
    - Added Ambient Dimming
--*********END OF INTERNAL ALPHA TESTING****************
- **v2.0** 10-5-21 Rob "FlightLevelRob" Verdon and Joe "Crunchmeister" Gilker and Todd "Toddimus831" Lorey
    !!- Initial Public Release -!!
    - Variable renaming for clarity
    - Added backlight logic to account for battery, external power and bus volts status
 **v2.01** 10-6-21
    - Updated preview graphic
##Left To Do:
    - Baro knob adjusts knob on PFD and not Standby Instrument.
	
##Notes:
    - Knob adjusts barometer on the PFD.
 
******************************************************************************************
--]]
img_screen_dimmer = img_add("background_dim.png", 110, 60, 440, 440)
img_add_fullscreen("background.png")
img_bg_night = img_add_fullscreen("background_night.png")
-- Ambient Light Control
function ss_ambient_darkness(value)
    opacity(img_bg_night, value, "LOG", 0.04)
    opacity(dial_baro_night, value, "LOG", 0.04)
    
end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)

img_backlight = img_add_fullscreen("backlight.png")

function ss_backlighting(value, power, extpower, busvolts)
    value = var_round(value,2)
    newval = 1.1-((value/2)+0.5)
--    if value == 1.0 or (power == false and extpower == false) then 
    if value < 1 and (power == true or extpower == true or busvolts > 5) then
        opacity(img_screen_dimmer, newval, "LOG", 0.04)    
    end    
    opacity(img_backlight, 0.1, "LOG", 0.04)
    
    if value == 1.0 then
        opacity(img_screen_dimmer, 0, "LOG", 0.04)
        opacity(img_backlight, 0, "LOG", 0.04)
        
    else
        if (power == true or extpower == true or busvolts > 5) then
            opacity(img_backlight, ((value/2)+0.5), "LOG", 0.04)
        end
    end
end
fs2020_variable_subscribe("A:LIGHT POTENTIOMETER:3", "Number",
                          "ELECTRICAL MASTER BATTERY","Bool",
                          "EXTERNAL POWER ON:1", "Bool",
                          "ELECTRICAL MAIN BUS VOLTAGE", "Volts", ss_backlighting)
						  
function turn_baroknob_cb (knobdirection)
    if knobdirection > 0 then
      fs2020_event("KOHLSMAN_INC")
    else
      fs2020_event("KOHLSMAN_DEC")
    end
  end
  
  dial_baro = dial_add("knob.png" , 510 , 496 , 82 , 82 , turn_baroknob_cb)
  dial_baro_night = img_add("knob_night.png" , 510 , 496 , 82 , 82)
  dial_click_rotate(dial_baro, 6)
  
 function baro_click()
   fs2020_event("BAROMETRIC")
   sound_play(click_snd)
end