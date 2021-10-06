--[[
******************************************************************************************
******************Cessna Citation CJ4 CCP Panel (Cursor Control Panel)****************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation

- **v1.0** 03-04-2021 Rob "FlightLevelRob" Verdon 
    - Original Panel Created
- **v1.1** 08-14-2021 Joe "Crunchmeister" Gilker    
   - Panning joystick now functional
   - Zoom buttons functional
- **v2.0** 09-17-2021 Joe "Crunchmeister" Gilker    
   - Mobiflight no longer required.
   - Night mode with cockpit lighting enabled.
--*********END OF INTERNAL ALPHA TESTING****************
- **v2.0** 10-5-21 Rob "FlightLevelRob" Verdon and Joe "Crunchmeister" Gilker and Todd "Toddimus831" Lorey
    !!- Initial Public Release -!!
    - Variable renaming for clarity
    - Added backlight logic to account for battery, external power and bus volts status
   
##Left To Do:
    - Panning Joystick animation.
	
##Notes:
    -    
   
******************************************************************************************   
--]]
  
--Backgroud Image before anything else
img_add_fullscreen("background.png")
--Sounds   
click_snd = sound_add("click.wav")
fail_snd = sound_add("beepfail.wav")
dial_snd = sound_add("dial.wav")

--night lighting
img_bg_night = img_add_fullscreen("background_night.png")
img_labels_backlight = img_add_fullscreen("backlight.png")

-- Ambient Light Control
function ss_ambient_darkness(value)
    opacity(img_bg_night, value, "LOG", 0.04)
    opacity(dial_menu_night, value, "LOG", 0.04)
    opacity(dial_data_night, value, "LOG", 0.04)
end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)

-- Backlight Control

function ss_backlighting(value, power, extpower, busvolts)
    value = var_round(value,2)      
    if value == 1.0 or (power == false and extpower == false and busvolts < 5) then 
       opacity(img_labels_backlight, 0.1, "LOG", 0.04)
    else
        opacity(img_labels_backlight, ((value/2)+0.5), "LOG", 0.04)
    end
end
fs2020_variable_subscribe("A:LIGHT POTENTIOMETER:3", "Number",
                          "ELECTRICAL MASTER BATTERY","Bool",
                          "EXTERNAL POWER ON:1", "Bool",
                          "ELECTRICAL MAIN BUS VOLTAGE", "Volts", ss_backlighting)
						  

--UPR Menu Select    
function callback_UPR_Menu()
   fs2020_event("H:Generic_Lwr_Push_UPR_MENU")
   sound_play(click_snd)
end
button_add(nil,"UPR_Menu_pressed.png", 81,18,80,58, callback_UPR_Menu)
--ESC Select    
function callback_ESC()
   fs2020_event("H:Generic_Lwr_Push_ESC")
   sound_play(click_snd)
end
button_add(nil,"ESC_pressed.png", 174,18,80,58, callback_ESC)
--DATABASE Select    
function callback_DATABASE()
   fs2020_event("H:Generic_Lwr_Push_DATABASE")
   sound_play(fail_snd)
end
button_add(nil,"DATABASE_pressed.png", 267,18,80,58, callback_DATABASE)
--NAVDATA Select    
function callback_NAVDATA()
   fs2020_event("H:Generic_Lwr_Push_NAVDATA")
   sound_play(fail_snd)
end
button_add(nil,"NAVDATA_pressed.png", 357,18,80,58, callback_NAVDATA)
--CHART Select    
function callback_CHART()
   fs2020_event("H:Generic_Lwr_Push_CHART_1")
   sound_play(click_snd)
end
button_add(nil,"CHART_pressed.png", 450,18,80,58, callback_CHART)
--CAS Select    
function callback_CAS()
   fs2020_event("H:Generic_Lwr_Push_CAS")
   sound_play(click_snd)
end
button_add(nil,"CAS_pressed.png", 543,18,80,58, callback_CAS)
--LWR Menu Select    
function callback_LWR_MENU()
   fs2020_event("H:Generic_Lwr_Push_LWR_MENU")
   sound_play(click_snd)
end
button_add(nil,"LWR_MENU_pressed.png", 81,103,80,58, callback_LWR_MENU)
--CURSR Select    
function callback_CURSR()
   fs2020_event("H:Generic_Lwr_Push_CURSR")
   sound_play(fail_snd)
end
button_add(nil,"CURSR_pressed.png", 81,190,80,58, callback_CURSR)
--ENG Select    
function callback_ENG()
   fs2020_event("H:Generic_Lwr_Push_ENG")
   sound_play(click_snd)
end
button_add(nil,"ENG_pressed.png", 81,275,80,58, callback_ENG)
--TERRWX Select    
function callback_TERRWX()
   fs2020_event("H:Generic_Lwr_Push_TERR_WX")
   sound_play(click_snd)
end
button_add(nil,"TERRWX_pressed.png", 175,275,80,58, callback_TERRWX)
--TFC Select    
function callback_TFC()
   fs2020_event("H:Generic_Lwr_Push_TFC")
   sound_play(click_snd)
end
button_add(nil,"TFC_pressed.png", 265,275,80,58, callback_TFC)
--MEM1 Select    
function callback_MEM1()
   fs2020_event("H:Generic_Lwr_Push_MEM1_1")
   sound_play(click_snd)
end
button_add(nil,"MEM1_pressed.png", 358,103,80,58, callback_MEM1)
--MEM2 Select    
function callback_MEM2()
   fs2020_event("H:Generic_Lwr_Push_MEM2_1")
   sound_play(click_snd)
end
button_add(nil,"MEM2_pressed.png", 358,189,80,58, callback_MEM2)
--MEM3 Select    
function callback_MEM3()
   fs2020_event("H:Generic_Lwr_Push_MEM3_1")
   sound_play(click_snd)
end
button_add(nil,"MEM3_pressed.png", 359,275,80,58, callback_MEM3)
--SYS Select    
function callback_SYS()
   fs2020_event("H:Generic_Lwr_Push_SYS")
   sound_play(click_snd)
end
button_add(nil,"SYS_pressed.png", 451,275,80,58, callback_SYS)
--CKLST Select    
function callback_CKLST()
   fs2020_event("H:Generic_Lwr_Push_CKLST_1")
   sound_play(click_snd)
end
button_add(nil,"CKLST_pressed.png", 544,275,80,58, callback_CKLST)
--PASSBRIEF Select    
function callback_PASSBRIEF()
   fs2020_event("H:Generic_Lwr_Push_PASSBRIEF_1")
   sound_play(click_snd)
end
button_add(nil,"PASSBRIEF_pressed.png", 637,275,80,58, callback_PASSBRIEF)
--ZOOMMINUS   
function callback_ZOOMMINUS ()
   fs2020_event("H:Generic_Lwr_Push_ZOOM_DEC")
   sound_play(click_snd)
end
button_add(nil,"ZOOMMINUS_pressed.png", 452,187,52,60, callback_ZOOMMINUS )
--ZOOMPLUS   
function callback_ZOOMPLUS()
   fs2020_event("H:Generic_Lwr_Push_ZOOM_INC")
    sound_play(click_snd)
end
button_add(nil,"ZOOMPLUS_pressed.png", 501,187,52,60, callback_ZOOMPLUS)
--ROTATE  
function callback_ROTATE()
   fs2020_event("H:Generic_Lwr_Push_ROTATE")
    sound_play(dial_snd)
end
button_add(nil,"ROTATE_pressed.png",451,103,80,58, callback_ROTATE)




--MENU DIAL (OUTER)
function callback_menu_turn( direction)
     if direction ==  -1 then
         fs2020_event("H:Generic_Lwr_MENU_ADV_DEC")
         sound_play(dial_snd)
     elseif direction == 1 then
         fs2020_event("H:Generic_Lwr_MENU_ADV_INC")
         sound_play(dial_snd)
     end
end
dial_menu = dial_add("MENU_Dial.png", 215,125,90,90, callback_menu_turn)
dial_menu_night = dial_add("MENU_Dial_night.png", 215,125,90,90, callback_menu_turn)
--DATA DIAL (INNER)
function callback_data_turn( direction)
     if direction ==  -1 then
         fs2020_event("H:Generic_Lwr_Data_DEC")
         sound_play(dial_snd)
     elseif direction == 1 then
         fs2020_event("H:Generic_Lwr_Data_INC")
         sound_play(dial_snd)
     end
end
dial_data = dial_add("DATA_Dial.png", 230,140,60,60, callback_data_turn) 
dial_data_night =dial_add("DATA_Dial_night.png", 230,140,60,60, callback_data_turn) 

--DATA PRESS
function data_click()
    fs2020_event("H:Generic_Lwr_Data_PUSH")  
    sound_play(click_snd)
end    
button_add(nil,nil, 240,150,30,50, data_click) 

--JOYSTICK FUNCTIONS
function up_click_callback()
    fs2020_event("H:Generic_Lwr_JOYSTICK_UP")
    sound_play(click_snd)
end
button_add(nil, nil, 625, 47, 75,75, up_click_callback)

function dn_click_callback()
    fs2020_event("H:Generic_Lwr_JOYSTICK_DOWN")
    sound_play(click_snd)
end
button_add(nil, nil, 625, 150, 75,75, dn_click_callback)

function left_click_callback()
    fs2020_event("H:Generic_Lwr_JOYSTICK_LEFT")
    sound_play(click_snd)
end
button_add(nil, nil, 550, 100, 75,75, left_click_callback)


function right_click_callback()
    fs2020_event("H:Generic_Lwr_JOYSTICK_RIGHT")
    sound_play(click_snd)
end
button_add(nil, nil, 690, 100, 75, 75, right_click_callback)


