--[[
******************************************************************************************
******************Cessna Citation CJ4 Master Caution Warning*************************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation

- **v1.0** 08-22-2021 Rob "FlightLevelRob" Verdon 
    - Original Instrument Created
- **v2.0** 09-26-2021 Joe "Crunchmeister" Gilker    
       - Added night mode
--*********END OF INTERNAL ALPHA TESTING****************
- **v2.0** 10-5-21 Rob "FlightLevelRob" Verdon and Joe "Crunchmeister" Gilker and Todd "Toddimus831" Lorey
    !!- Initial Public Release -!!
    - Variable renaming for clarity
    - Added backlight logic to account for battery, external power and bus volts status
   
##Left To Do:
    - 
	
##Notes:
    -  This instrument can be used with most FS2020 planes.  
   
******************************************************************************************   
--]]
  
--Backgroud Image before anything else
img_add_fullscreen("background.png")
img_dimmerLeft = img_add("background_dim.png", 0,0,217,217)
img_dimmerRight = img_add("background_dim.png", 232,0,217, 217)

img_Warning_On = img_add("warning.png", 15,15,188,160)
img_Caution_On = img_add("caution.png", 248,15,188,160)

click_snd = sound_add("click.wav")
-- Ambient Light Control
function ss_ambient_darkness(value)
   if value < 0.7 then
       dimval = 1-value
    else
        dimval = 0.3
    end
    opacity(img_dimmerLeft, 1- dimval, "LOG", 0.04)
    opacity(img_dimmerRight, 1- dimval, "LOG", 0.04)
end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)

--Warning Select    
function callback_Warning()
   fs2020_event("H:Generic_Master_Warning_Push")
   sound_play(click_snd)
end
button_add(nil,"warning.png", 15,15,188,160, callback_Warning)

--Caution Select    
function callback_Caution()
    fs2020_event("H:Generic_Master_Caution_Push")
    sound_play(click_snd)
end
button_add(nil,"caution.png", 248,15,188,160, callback_Caution)

--Test if Gen is On         
function ss_warningtrue(warningactive,Battery_Status,ExtPower_Status, busvolts) 
  if (warningactive == 1 and (Battery_Status == true or ExtPower_Status == true or busvolts > 5)) then 
        visible(img_Warning_On, true)
  else 
        visible(img_Warning_On, false)
  end
end
fs2020_variable_subscribe("L:Generic_Master_Warning_Active","Int", 
                          "ELECTRICAL MASTER BATTERY","Bool",
                          "EXTERNAL POWER ON:1", "Bool",
                          "ELECTRICAL MAIN BUS VOLTAGE", "Volts", ss_warningtrue)
                          
function ss_cautiontrue(cautionactive,Battery_Status,ExtPower_Status, busvolts) 
    if (cautionactive == 1 and (Battery_Status == true or ExtPower_Status == true or busvolts > 5)) then 
        visible(img_Caution_On, true)
    else 
        visible(img_Caution_On, false)
    end
end       
fs2020_variable_subscribe("L:Generic_Master_Caution_Active","Int",
                          "ELECTRICAL MASTER BATTERY","Bool",
                          "EXTERNAL POWER ON:1", "Bool",
                          "ELECTRICAL MAIN BUS VOLTAGE", "Volts", ss_cautiontrue)
