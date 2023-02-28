--[[
******************************************************************************************
******************Cessna Citation CJ4 Uper DCP Panel*******************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: http://simstrumentation.com

- **v1.0** 03-03-2021 Rob "FlightLevelRob" Verdon
    - Original Panel Created
- **v2.0** 09-22-2021 Joe "Crunchmeister" Gilker
    - Removed all Mobiflight events and replaced with H: events
    - Night mode and backlighting added
--*********END OF INTERNAL ALPHA TESTING****************
- **v2.0** 10-5-2021 Rob "FlightLevelRob" Verdon and Joe "Crunchmeister" Gilker and Todd "Toddimus831" Lorey
    !!- Initial Public Release -!!
    - Variable renaming for clarity
    - Added backlight logic to account for battery, external power and bus volts status
- **v2.1** 01-19-2022 SIMSTRUMENTATION
    - Baro knob fully functional, now changes between user baro and STD.
    - Resource folder file capitials renamed for SI Store submittion  
    - Click and Dial sounds replaced with custom.    
- **v2.2** 01-19-2022 SIMSTRUMENTATION with credit to SimInnovations Tony for the suggestion.
    - Baro knob changed from Switch to Button to allow Knobster push function.    
- **v2.3** 10-19-2022 SIMSTRUMENTATION 
    - Added acceleration to Baro Knob. Request from sunbeam60.                
- **v2.4** 12-06-2022  SIMSTRUMENTATION       
    - Updated code to reflect AAU1 being released in 2023Q1
- **v2.5** 02-27-2023  SIMSTRUMENTATION      
    - Reversed Baro Dial,  turning to the right now increase baro.
    - Added Baro STD push sound.
          
## Left To Do:
  - N/A
	
## Notes:
  - N/A
 
****************************************************************************************** 
--]]

--SET USER PROPERTIES
unit_pos = user_prop_add_enum("Position", "Pilot,Copilot", "Pilot", "Choose instrument position")

--  unit position
if user_prop_get(unit_pos) == "Pilot" then
    instr_pos = "1"
else
    instr_pos = "2"
end

local barosaved = 0  
local barostate = 0  
--Backgroud Image before anything else
img_add_fullscreen("background.png")
--Sounds   
click_snd = sound_add("click.wav")
dial_snd = sound_add("dial.wav")

--ambient light
img_bg_night = img_add_fullscreen("background_night.png")

function ss_ambient_darkness(value)
    opacity(img_bg_night, value, "LOG", 0.04)
    opacity(img_baro_night, value, "LOG", 0.04)
    opacity(img_data_night, value, "LOG", 0.04)
    opacity(img_tilt_night, value, "LOG", 0.04)
    opacity(img_range_night, value, "LOG", 0.04)
    opacity(img_menu_night, value, "LOG", 0.04)
end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)

--back lighting
img_labels_backlight = img_add_fullscreen("backlight.png")
function ss_backlighting(value, panellight, power, extpower, busvolts)
    value = var_round(value,2)      
    if  panellight == false  or (power == false and extpower == false and busvolts < 5) then 
        opacity(img_labels_backlight, 0.1, "LOG", 0.04)
        opacity(img_baro_backlight, 0.1, "LOG", 0.04)
    else
        opacity(img_labels_backlight, ((value/2)+0.5), "LOG", 0.04)
        opacity(img_baro_backlight, ((value/2)+0.5), "LOG", 0.04)
    end
end
fs2020_variable_subscribe("A:LIGHT POTENTIOMETER:3", "Number",
                           "LIGHT PANEL","Bool",
                          "ELECTRICAL MASTER BATTERY","Bool",
                          "EXTERNAL POWER ON:1", "Bool",
                          "ELECTRICAL MAIN BUS VOLTAGE", "Volts", ss_backlighting)
						  
--NAV Select    
function callback_nav()
   fs2020_event("H:Generic_Upr_" .. instr_pos .. "_Push_NAV")
   sound_play(click_snd)
end
button_add(nil,"nav_pressed.png", 82,30,91,70, callback_nav)
--PFD Select    
function callback_pfd()
   fs2020_event("H:Generic_Upr_" .. instr_pos .. "_Push_PFD_MENU")
   sound_play(click_snd)
end
button_add(nil,"pfd_pressed.png", 203,30,91,70, callback_pfd)
--ESC Select    
function callback_esc()
   fs2020_event("H:Generic_Upr_" .. instr_pos .. "_Push_ESC")
   sound_play(click_snd)
end
button_add(nil,"ESC_pressed.png", 326,30,91,70, callback_esc)
--ET Select    
function callback_et()
   fs2020_event("H:Generic_Upr_" .. instr_pos .. "_Push_ET")
   sound_play(click_snd)
end
button_add(nil,"ET_pressed.png", 446,30,91,70, callback_et)
--FRMT Select    
function callback_frmt()
   fs2020_event("H:Generic_Upr_" .. instr_pos .. "_Push_FRMT")
   sound_play(click_snd)
end
button_add(nil,"frmt_pressed.png", 567,30,91,70, callback_frmt)
--TERR Select    
function callback_terr()
   fs2020_event("H:Generic_Upr_" .. instr_pos .. "_Push_TERR_WX")
   sound_play(click_snd)
end
button_add(nil,"terr_pressed.png", 687,30,91,70, callback_terr)
--TFC Select    
function callback_tfc()
   fs2020_event("H:Generic_Upr_" .. instr_pos .. "_Push_TFC")
   sound_play(click_snd)
end
button_add(nil,"TFC_pressed.png", 807,30,91,70, callback_tfc)
--CCP Select    
function callback_ccp()
   fs2020_event("H:Generic_Upr_" .. instr_pos .. "_Push_CCP")
end
button_add(nil,"CCP_pressed.png", 273,125,91,70, callback_ccp)
--REFS Select    
function callback_refs()
   fs2020_event("H:Generic_Upr_" .. instr_pos .. "_Push_REFS_MENU")
   sound_play(click_snd)
end
button_add(nil,"REFS_pressed.png", 273,227,91,70, callback_refs)
--RADAR Select    
function callback_radar()
   fs2020_event("H:Generic_Upr_" .. instr_pos .. "_Push_RADAR_MENU")
end
button_add(nil,"RADAR_pressed.png", 606,125,91,70, callback_radar)
--TAWS Select    
function callback_taws()
   fs2020_event("H:Generic_Upr_" .. instr_pos .. "_Push_TAWS_MENU")
end
button_add(nil,"TAWS_pressed.png", 606,228,91,70, callback_taws)
--------------------------------------------------

--BARO DIAL
function ss_barosaved_value(value)
    barosaved = value
end
fs2020_variable_subscribe("L:XMLVAR_Baro1_SavedPressure","number", ss_barosaved_value)

baro_angle = 0
function callback_baro_turn( direction)
     if direction ==  -1 then 
         fs2020_event("KOHLSMAN_DEC")
         baro_angle = baro_angle - 10
     elseif direction == 1 then
         fs2020_event("KOHLSMAN_INC")
         baro_angle = baro_angle + 10
     end
 sound_play(dial_snd)  
     rotate (img_baro_day, baro_angle)     
     rotate (img_baro_night, baro_angle)
     rotate (img_baro_backlight, baro_angle)
end
dial_baro = dial_add(nil, 115,165,120,120, callback_baro_turn)
dial_set_acceleration(dial_baro, 3) 
img_baro_day = img_add("baro.png", 115,165,120,120 )
img_baro_night = img_add("baro_night.png", 115,165,120,120 )
img_baro_backlight = img_add("baro_backlight.png", 115,165,120,120)

--BARO STD PRESS
 function callback_baro_click()
     fs2020_event("BAROMETRIC")
      sound_play(click_snd)  
end    
sw_baro_std = button_add(nil,nil, 140,190,70,70, callback_baro_click)

function ss_baro_std(value)
    barostate = value     --set value to global local
end
fs2020_variable_subscribe("L:XMLVAR_Baro1_ForcedToSTD","number", ss_baro_std)

 --------------------------------------------------

--MENU DIAL (OUTER)
function callback_menu_turn( direction)
     if direction ==  -1 then
         fs2020_event("H:Generic_Upr_" .. instr_pos .. "_MENU_ADV_DEC")
         sound_play(dial_snd)
     elseif direction == 1 then
         fs2020_event("H:Generic_Upr_" .. instr_pos .. "_MENU_ADV_INC")
         sound_play(dial_snd)
     end
end
dial_menu = dial_add("MENU_Dial.png", 418,165,120,120, callback_menu_turn)
img_menu_night = img_add("MENU_Dial_night.png", 418,165,120,120)
--DATA DIAL (INNER)
data_angle = 0
function callback_data_turn( direction)
     if direction ==  -1 then
         data_angle =data_angle - 10
         fs2020_event("H:Generic_Upr_" .. instr_pos .. "_Data_DEC")
         sound_play(dial_snd)
     elseif direction == 1 then
         data_angle =data_angle + 10     
         fs2020_event("H:Generic_Upr_" .. instr_pos .. "_Data_INC")
         sound_play(dial_snd)
     end
     rotate (img_data_night, data_angle)

end
dial_data = dial_add("DATA_Dial.png", 437,182,85,85, callback_data_turn) 
img_data_night = img_add("DATA_Dial_night.png", 437,182,85,85) 
--DATA PRESS
function data_click()
    fs2020_event("H:Generic_Upr_" .. instr_pos .. "_Data_PUSH")  
    sound_play(click_snd)
end    
button_add(nil,nil, 450,200,50,50, data_click) 
 
 --------------------------------------------------
 --TILT DIAL (OUTER)
function callback_tilt_turn( direction)
     if direction ==  -1 then
         fs2020_event("H:Generic_Upr_" .. instr_pos .. "_TILT_DEC")
     elseif direction == 1 then
          fs2020_event("H:Generic_Upr_" .. instr_pos .. "_TILT_INC")
     end
end
dial_tilt = dial_add("TILT_Dial.png", 735,165,120,120, callback_tilt_turn)
img_tilt_night = img_add("TILT_Dial_night.png", 735,165,120,120)

--RANGE DIAL (INNER)
range_angle = 0
function callback_range_turn( direction)
     if direction ==  -1 then
         range_angle = range_angle - 10     
         fs2020_event("H:Generic_Upr_" .. instr_pos .. "_RANGE_DEC")
         sound_play(dial_snd)
     elseif direction == 1 then
         range_angle = range_angle + 10     
         fs2020_event("H:Generic_Upr_" .. instr_pos .. "_RANGE_INC")
         sound_play(dial_snd)
     end
     rotate (img_range_night, range_angle)

end
dial_range = dial_add("RANGE_Dial.png", 754,182,85,85, callback_range_turn) 
img_range_night = img_add("RANGE_Dial_night.png", 754,182,85,85) 

--TILT PRESS
function callback_tilt_click()
    fs2020_event("H:Generic_Upr_" .. instr_pos .. "_Tilt_PUSH")  
     sound_play(click_snd)  
end    
button_add(nil,nil, 773,200,50,50, callback_tilt_click) 



