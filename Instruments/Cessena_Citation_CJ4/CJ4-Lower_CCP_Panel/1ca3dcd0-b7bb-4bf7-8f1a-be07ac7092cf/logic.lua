--[[
******************************************************************************************
******************Cessna Citation CJ4 CCP Panel (Cursor Control Panel)****************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: http://simstrumentation.com


- **v1.0** 03-04-2021 Rob "FlightLevelRob" Verdon 
    - Original Panel Created
- **v1.1** 08-14-2021 Joe "Crunchmeister" Gilker    
   - Panning joystick now functional
   - Zoom buttons functional
- **v2.0** 09-17-2021 Joe "Crunchmeister" Gilker    
   - Mobiflight no longer required.
   - Night mode with cockpit lighting enabled.

--*********END OF INTERNAL ALPHA TESTING****************
- **v2.0** 10-5-2021 Rob "FlightLevelRob" Verdon and Joe "Crunchmeister" Gilker and Todd "Toddimus831" Lorey
    !!- Initial Public Release -!!
    - Variable renaming for clarity
    - Added backlight logic to account for battery, external power and bus volts status
- **v2.1** 01-16-2022 SIMSTRUMENTATION
    - Resource folder file capitials renamed for SI Store submittion  
    - Click and Dial sounds replaced with custom.
- **v2.2** 04-27-2022 SIMSTRUMENTATION
    - Fixed dial night mode not spinning correctly
- **v2.3** 12-06-2022 Joe "Crunchmeister" Gilker       
   - Updated code to reflect AAU1 being released in 2023Q1
        
## Left To Do:
  - Panning Joystick animation.
	
## Notes:
  - With AAU1 Several buttons no longer work.
   
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
  
      
--Backgroud Image before anything else
img_add_fullscreen("background.png")
--Sounds   
click_snd = sound_add("click.wav")
dial_snd = sound_add("dial.wav")

--night lighting
img_bg_night = img_add_fullscreen("background_night.png")
img_labels_backlight = img_add_fullscreen("backlight.png")

-- Ambient Light Control
function ss_ambient_darkness(value)
    opacity(img_bg_night, value, "LOG", 0.04)
    opacity(img_menu_night, value, "LOG", 0.04)
    opacity(img_data_night, value, "LOG", 0.04)
end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)

-- Backlight Control

function ss_backlighting(value, panellight, power, extpower, busvolts)
    value = var_round(value,2)      
    if  panellight == false or (power == false and extpower == false and busvolts < 5) then 
       opacity(img_labels_backlight, 0.1, "LOG", 0.04)
    else
        opacity(img_labels_backlight, ((value/2)+0.5), "LOG", 0.04)
    end
end
msfs_variable_subscribe("A:LIGHT POTENTIOMETER:3", "Number",
                           "LIGHT PANEL","Bool",
                          "ELECTRICAL MASTER BATTERY","Bool",
                          "EXTERNAL POWER ON:1", "Bool",
                          "ELECTRICAL MAIN BUS VOLTAGE", "Volts", ss_backlighting)
						  

--UPR Menu Select    
function callback_UPR_Menu()
   msfs_event("H:Generic_Lwr_" .. instr_pos .. "_Push_UPR_MENU")
   sound_play(click_snd)
end
button_add(nil,"upr_menu_pressed.png", 81,18,80,58, callback_UPR_Menu)
--ESC Select    
function callback_ESC()
   msfs_event("H:Generic_Lwr_" .. instr_pos .. "_Push_ESC")
   sound_play(click_snd)
end
button_add(nil,"esc_pressed.png", 174,18,80,58, callback_ESC)
--DATABASE Select    
function callback_DATABASE()
   msfs_event("H:Generic_Lwr_" .. instr_pos .. "_Push_DATABASE")
end
button_add(nil,"database_pressed.png", 267,18,80,58, callback_DATABASE)
--NAVDATA Select    
function callback_NAVDATA()
   msfs_event("H:Generic_Lwr_" .. instr_pos .. "_Push_NAVDATA")
end
button_add(nil,"navdata_pressed.png", 357,18,80,58, callback_NAVDATA)
--CHART Select    
function callback_CHART()
   msfs_event("H:Generic_Lwr_" .. instr_pos .. "_Push_CHART_1")
   sound_play(click_snd)
end
button_add(nil,"chart_pressed.png", 450,18,80,58, callback_CHART)
--CAS Select    
function callback_CAS()
   msfs_event("H:Generic_Lwr_" .. instr_pos .. "_Push_CAS")
   sound_play(click_snd)
end
button_add(nil,"cas_pressed.png", 543,18,80,58, callback_CAS)
--LWR Menu Select    
function callback_LWR_MENU()
   msfs_event("H:Generic_Lwr_" .. instr_pos .. "_Push_LWR_MENU")
   sound_play(click_snd)
end
button_add(nil,"lwr_menu_pressed.png", 81,103,80,58, callback_LWR_MENU)
--CURSR Select    
function callback_CURSR()
   msfs_event("H:Generic_Lwr_" .. instr_pos .. "_Push_CURSR")
end
button_add(nil,"cursr_pressed.png", 81,190,80,58, callback_CURSR)
--ENG Select    
function callback_ENG()
   msfs_event("H:Generic_Lwr_" .. instr_pos .. "_Push_ENG")
   sound_play(click_snd)
end
button_add(nil,"eng_pressed.png", 81,275,80,58, callback_ENG)
--TERRWX Select    
function callback_TERRWX()
   msfs_event("H:Generic_Lwr_" .. instr_pos .. "_Push_TERR_WX")
   sound_play(click_snd)
end
button_add(nil,"terrwx_pressed.png", 175,275,80,58, callback_TERRWX)
--TFC Select    
function callback_TFC()
   msfs_event("H:Generic_Lwr_" .. instr_pos .. "_Push_TFC")
   sound_play(click_snd)
end
button_add(nil,"tfc_pressed.png", 265,275,80,58, callback_TFC)
--MEM1 Select    
function callback_MEM1()
   msfs_event("H:Generic_Lwr_" .. instr_pos .. "_Push_MEM1")
   sound_play(click_snd)
end
button_add(nil,"mem1_pressed.png", 358,103,80,58, callback_MEM1)
--MEM2 Select    
function callback_MEM2()
   msfs_event("H:Generic_Lwr_" .. instr_pos .. "_Push_MEM2")
   sound_play(click_snd)
end
button_add(nil,"mem2_pressed.png", 358,189,80,58, callback_MEM2)
--MEM3 Select    
function callback_MEM3()
   msfs_event("H:Generic_Lwr_" .. instr_pos .. "_Push_MEM3")
   sound_play(click_snd)
end
button_add(nil,"mem3_pressed.png", 359,275,80,58, callback_MEM3)
--SYS Select    
function callback_SYS()
   msfs_event("H:Generic_Lwr_" .. instr_pos .. "_Push_SYS")
   sound_play(click_snd)
end
button_add(nil,"sys_pressed.png", 451,275,80,58, callback_SYS)
--CKLST Select    
function callback_CKLST()
   msfs_event("H:Generic_Lwr_" .. instr_pos .. "_Push_CKLST_1")
   sound_play(click_snd)
end
button_add(nil,"cklst_pressed.png", 544,275,80,58, callback_CKLST)
--PASSBRIEF Select    
function callback_PASSBRIEF()
   msfs_event("H:Generic_Lwr_" .. instr_pos .. "_Push_PASSBRIEF_1")
   sound_play(click_snd)
end
button_add(nil,"passbrief_pressed.png", 637,275,80,58, callback_PASSBRIEF)
--ZOOMMINUS   
function callback_ZOOMMINUS ()
   msfs_event("H:Generic_Lwr_" .. instr_pos .. "_Push_ZOOM_DEC")
   sound_play(click_snd)
end
button_add(nil,"zoomminus_pressed.png", 452,187,52,60, callback_ZOOMMINUS )
--ZOOMPLUS   
function callback_ZOOMPLUS()
   msfs_event("H:Generic_Lwr_" .. instr_pos .. "_Push_ZOOM_INC")
    sound_play(click_snd)
end
button_add(nil,"zoomplus_pressed.png", 501,187,52,60, callback_ZOOMPLUS)
--ROTATE  
function callback_ROTATE()
   msfs_event("H:Generic_Lwr_" .. instr_pos .. "_Push_ROTATE")
    sound_play(dial_snd)
end
button_add(nil,"rotate_pressed.png",451,103,80,58, callback_ROTATE)




--MENU DIAL (OUTER)
local menu_angle = 0
function callback_menu_turn( direction)
     if direction ==  -1 then
         menu_angle =menu_angle - 10     
         msfs_event("H:Generic_Lwr_" .. instr_pos .. "_MENU_ADV_DEC")
         sound_play(dial_snd)
     elseif direction == 1 then
         menu_angle =menu_angle + 10          
         msfs_event("H:Generic_Lwr_" .. instr_pos .. "_MENU_ADV_INC")
         sound_play(dial_snd)
     end
     rotate (img_menu_night, menu_angle)      
end
dial_menu = dial_add("menu_dial.png", 215,125,90,90, callback_menu_turn)
img_menu_night = img_add("menu_dial_night.png", 215,125,90,90)
--DATA DIAL (INNER)
local data_angle = 0
function callback_data_turn( direction)
     if direction ==  -1 then
         data_angle =data_angle - 10
         msfs_event("H:Generic_Lwr_" .. instr_pos .. "_Data_DEC")
         sound_play(dial_snd)
     elseif direction == 1 then
         data_angle =data_angle + 10     
         msfs_event("H:Generic_Lwr_" .. instr_pos .. "_Data_INC")
         sound_play(dial_snd)
     end
     rotate (img_data_night, data_angle)     
end
dial_data = dial_add("data_dial.png", 230,140,60,60, callback_data_turn) 
img_data_night =img_add("data_dial_night.png", 230,140,60,60) 

--DATA PRESS
function data_click()
    msfs_event("H:Generic_Lwr_" .. instr_pos .. "_Data_PUSH")  
    sound_play(click_snd)
end    
button_add(nil,nil, 240,150,30,50, data_click) 

--JOYSTICK FUNCTIONS
function up_click_callback()
    msfs_event("H:Generic_Lwr_" .. instr_pos .. "_JOYSTICK_UP")
    sound_play(click_snd)
end
button_add(nil, nil, 625, 47, 75,75, up_click_callback)

function dn_click_callback()
    msfs_event("H:Generic_Lwr_" .. instr_pos .. "_JOYSTICK_DOWN")
    sound_play(click_snd)
end
button_add(nil, nil, 625, 150, 75,75, dn_click_callback)

function left_click_callback()
    msfs_event("H:Generic_Lwr_" .. instr_pos .. "_JOYSTICK_LEFT")
    sound_play(click_snd)
end
button_add(nil, nil, 550, 100, 75,75, left_click_callback)


function right_click_callback()
    msfs_event("H:Generic_Lwr_" .. instr_pos .. "_JOYSTICK_RIGHT")
    sound_play(click_snd)
end
button_add(nil, nil, 690, 100, 75, 75, right_click_callback)


