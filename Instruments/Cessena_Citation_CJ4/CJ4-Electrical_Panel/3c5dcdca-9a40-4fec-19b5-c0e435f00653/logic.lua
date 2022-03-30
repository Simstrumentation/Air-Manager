--[[
******************************************************************************************
******************Cessna Citation CJ4 Electrical Control Panel**************************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation

- **v1.0**  03-04-2021 Rob "FlightLevelRob" Verdon    
    - Original Panel Created
- **v2.0**  08-29-2021 Rob "FlightLevelRob" Verdon 
    - Changed Background graphic so that all switches are set in off position.
- **v2.1**  09-6-2021 Rob "FlightLevelRob" Verdon and Herbert Puukka
    - Added Stby FTL and EMER Lights from variables thanks to Herbert Puukka
- **v2.2**  09-23-2021 Joe "Crunchmeister" Gilke 
    - New custom graphics for day and night mode
    - Added ambient dimming function
    - Added back lighting	
--*********END OF INTERNAL ALPHA TESTING****************
- **v2.0** 10-5-21 Rob "FlightLevelRob" Verdon and Joe "Crunchmeister" Gilker and Todd "Toddimus831" Lorey
    !!- Initial Public Release -!!
    - Variable renaming for clarity
    - Added backlight logic to account for battery, external power and bus volts status
 - **v2.1** 01-16-22 SIMSTRUMENTATION
     - Resource folder file capitials renamed for SI Store submittion  
     - Battery EMER is functional but requires Air Manager 4.1 for full functionality. If using AM4.0.1 EMER turns on actual battery.
 - **v2.2** 03-28-22 SIMSTRUMENTATION
     - Switch Graphics replaced 
     
##Left To Do:
    - 
	
##Notes:
    - 
			 					  													   					 					  													   
******************************************************************************************
--]]
local batterystatus = 0
--Backgroud Image before anything else
img_add_fullscreen("background.png")
img_bg_night = img_add_fullscreen("background_night.png")

--backlight graphics
img_labels_backlight = img_add_fullscreen("backlight.png")

--Day graphics
img_LGen_On = img_add("sml_blk_switch_up.png", 121,28,148,203)
img_RGen_On = img_add("sml_blk_switch_up.png", 485,28,148,203)
img_Battery_On = img_add("red_switch.png", 301,28,148,203)
img_Battery_EMER = img_add("red_switch_dn.png", 301,28,148,203)
img_AVI_On = img_add("blk_switch_up.png", 485,265,148,203)
img_AVI_Dispatch = img_add("blk_switch_dn.png", 485,265,148,203)
img_Emergency_Armed = img_add("blk_switch_up.png", 121,265,148,203)
img_StandbyDisplay_On = img_add("blk_switch_up.png", 301,265,148,203)

--Night Graphics
img_LGen_On_night = img_add("sml_blk_switch_up_dark.png", 121,28,148,203)
img_RGen_On_night = img_add("sml_blk_switch_up_dark.png", 485,28,148,203)
img_Battery_On_night = img_add("red_switch_up_dark.png", 301,28,148,203)
img_Battery_EMER_night = img_add("red_switch_dn_dark.png", 301,28,148,203)
img_AVI_On_night = img_add("blk_switch_up_dark.png", 485,265,148,203)
img_AVI_Dispatch_night = img_add("blk_switch_dn_dark.png", 485,265,148,203)
img_Emergency_Armed_night = img_add("blk_switch_up_dark.png", 121,265,148,203)
img_StandbyDisplay_On_night = img_add("blk_switch_up_dark.png",  301,265,148,203)

-- Ambient Light Control
function ss_ambient_darkness(value)
    opacity(img_bg_night, value, "LOG", 0.04)
    opacity(img_LGen_On_night, value, "LOG", 0.04)
    opacity(img_RGen_On_night, value, "LOG", 0.04)
    opacity(img_Battery_On_night, value, "LOG", 0.04)
    opacity(img_Battery_EMER_night, value, "LOG", 0.04)    
    opacity(img_AVI_On_night, value, "LOG", 0.04)
    opacity(img_AVI_Dispatch_night, value, "LOG", 0.04)
    opacity(img_Emergency_Armed_night, value, "LOG", 0.04)
    opacity(img_StandbyDisplay_On_night, value, "LOG", 0.04)
end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)

--backlighting
function ss_backlighting(value, power, extpower, busvolts)
    value = var_round(value,2)      
    if value == 1.0 or (power == false and extpower == false and busvolts < 5) then 
        opacity(img_labels_backlight, 0, "LOG", 0.04)
     else
        opacity(img_labels_backlight, ((value/2)+0.5), "LOG", 0.04)     
    end
end
fs2020_variable_subscribe("A:LIGHT POTENTIOMETER:3", "Number",
                          "ELECTRICAL MASTER BATTERY","Bool",
                          "EXTERNAL POWER ON:1", "Bool",
                          "ELECTRICAL MAIN BUS VOLTAGE", "Volts", ss_backlighting)
						  
--L Gen    
function callback_LGen()
   fs2020_event("TOGGLE_ALTERNATOR1")
end
button_add(nil,nil,  147,87,90,90, callback_LGen)
--R Gen    
function callback_RGen()
   fs2020_event("TOGGLE_ALTERNATOR2")
end
button_add(nil,nil, 511,84,94,94, callback_RGen)

--BatteryOn     baterystatus = 1
function callback_BatteryOn()
    if (batterystatus ==  0) then
       fs2020_event("MASTER_BATTERY_ON")
    end
end
button_add(nil,nil, 330,35,94,60, callback_BatteryOn)
--BatteryOff     baterystatus = 0
function callback_BatteryOff()
    if (batterystatus ==  1) then
        fs2020_variable_write("L:XMLVAR_Essential_Bus_On", "number", 0)
        fs2020_event("MASTER_BATTERY_OFF")
    elseif (batterystatus ==  2) then
        fs2020_variable_write("L:XMLVAR_Essential_Bus_On", "number", 0)
        fs2020_event("MASTER_BATTERY_OFF")
        fs2020_event("ELECTRICAL_BUS_TO_BUS_CONNECTION_TOGGLE",1,3)
        fs2020_event("ELECTRICAL_BUS_TO_BUS_CONNECTION_TOGGLE",1,2)        
        fs2020_event("ELECTRICAL_BUS_TO_BUS_CONNECTION_TOGGLE",2,3)
    end
end
button_add(nil,nil, 330,97,94,60, callback_BatteryOff)
--BatteryEmer baterystatus = 2
function callback_BatteryEMER()
    if (batterystatus ==  0) then 
        fs2020_variable_write("L:XMLVAR_Essential_Bus_On", "number", 1)
        fs2020_event("MASTER_BATTERY_ON")
        fs2020_event("ELECTRICAL_BUS_TO_BUS_CONNECTION_TOGGLE",1,3)
        fs2020_event("ELECTRICAL_BUS_TO_BUS_CONNECTION_TOGGLE",1,2)        
        fs2020_event("ELECTRICAL_BUS_TO_BUS_CONNECTION_TOGGLE",2,3)
       
    end
end
button_add(nil,nil, 330,160,94,60, callback_BatteryEMER)


--AVIOn   
function callback_AVI_On()
    fs2020_event("AVIONICS_MASTER_1_SET",1)
    fs2020_event("AVIONICS_MASTER_2_SET",0)
end
button_add(nil,nil, 501,285,120,60, callback_AVI_On)  
--AVIOff
function callback_AVI_Off()
    fs2020_event("AVIONICS_MASTER_1_SET",0)
    fs2020_event("AVIONICS_MASTER_2_SET",0)
end
button_add(nil,nil, 501,335,120,50, callback_AVI_Off)
--AVIDispatch
function callback_AVI_Dispatch()
    fs2020_event("AVIONICS_MASTER_1_SET",0)
    fs2020_event("AVIONICS_MASTER_2_SET",1)
end
button_add(nil,nil, 501,385,120,50, callback_AVI_Dispatch)
-- EmergencyLightsArmed
function callback_Emerg_Lights_Armed()
	fs2020_variable_write("L:WT_CJ4_EMER_LIGHT_ARMED", "Int",1)
end
button_add(nil,nil, 110,250,180,160, callback_Emerg_Lights_Armed)
function callback_Emerg_Lights_Off()
    fs2020_variable_write("L:WT_CJ4_EMER_LIGHT_ARMED", "Int",0) 
end
button_add(nil,nil, 100,330,240,100, callback_Emerg_Lights_Off)
--Stand By Display On
function callback_Standby_Display_On()
    fs2020_event("K:ELECTRICAL_CIRCUIT_TOGGLE",49, "Int",1)
end
button_add(nil,nil, 321,295,120,50, callback_Standby_Display_On)
--Stand By Display Off
function callback_Standby_Display_Off()
   fs2020_event("K:ELECTRICAL_CIRCUIT_TOGGLE",49, "Int",0)
end
button_add(nil,nil, 321,340,120,50, callback_Standby_Display_Off)

---------------------------------
 
--Test if Gen is On         
function ss_Gen_Status(Gen1_Status,Gen2_Status) 
    if Gen1_Status == true then 
        visible(img_LGen_On, true)
        visible(img_LGen_On_night, true)
    else 
        visible(img_LGen_On, false)
        visible(img_LGen_On_night, false)
    end
    if Gen2_Status == true then 
        visible(img_RGen_On, true)
        visible(img_RGen_On_night, true)
    else 
        visible(img_RGen_On, false)
        visible(img_RGen_On_night, false)
    end
end
fs2020_variable_subscribe("GENERAL ENG MASTER ALTERNATOR:1","Bool",
                          "GENERAL ENG MASTER ALTERNATOR:2","Bool",ss_Gen_Status)
                          
--Test if Batt is On         
function ss_Battery_Status(Battery_Status1,EMER) 
    if ((Battery_Status1 == true) and (EMER == 0)) then 
        batterystatus = 1
        visible(img_Battery_On, true)
        visible(img_Battery_On_night, true)
        visible(img_Battery_EMER, false)
        visible(img_Battery_EMER_night, false)
    elseif ((Battery_Status1 == true) and (EMER == 1)) then 
        batterystatus = 2
        visible(img_Battery_On, false)
        visible(img_Battery_On_night, false)
        visible(img_Battery_EMER, true)
        visible(img_Battery_EMER_night, true)
    else 
        batterystatus = 0
        visible(img_Battery_On, false)
        visible(img_Battery_On_night, false)
        visible(img_Battery_EMER, false)
        visible(img_Battery_EMER_night, false)
    end 
end
fs2020_variable_subscribe("ELECTRICAL MASTER BATTERY","Bool",
                                              "L:XMLVAR_Essential_Bus_On", "number", ss_Battery_Status)

--Test if AVI is On         
function ss_AVI_Status(AVI_Bus_1,AVI_Bus_2) 
    if AVI_Bus_1 == true then 
        visible(img_AVI_On, true)
        visible(img_AVI_On_night, true)
        visible(img_AVI_Dispatch, false)
        visible(img_AVI_Dispatch_night, false)
        --AVI_OnOff = true
    elseif AVI_Bus_2 == true then 
        visible(img_AVI_On, false)
        visible(img_AVI_On_night, false)
        visible(img_AVI_Dispatch, true)
        visible(img_AVI_Dispatch_night, true)
       -- AVI_OnOff = true
    else 
        visible(img_AVI_On, false)
        visible(img_AVI_On_night, false)
        visible(img_AVI_Dispatch, false)
        visible(img_AVI_Dispatch_night, false)
       -- AVI_OnOff = false
    end 
end
fs2020_variable_subscribe("AVIONICS MASTER SWITCH:1","Bool",
                          "AVIONICS MASTER SWITCH:2","Bool", ss_AVI_Status)
                          
--Test if Emergency Lights Armed
function ss_Emerg_Lights_Status(emlights_armed)
    if emlights_armed == 1 then
         visible(img_Emergency_Armed, true)
         visible(img_Emergency_Armed_night, true)
    elseif emlights_armed == 0 then
        visible(img_Emergency_Armed, false)
        visible(img_Emergency_Armed_night, false)
    end
end
fs2020_variable_subscribe("L:WT_CJ4_EMER_LIGHT_ARMED", "Int", ss_Emerg_Lights_Status)

--Test if Standy By Display ON
function ss_Standby_Display_Status(standby_on)
    if standby_on == true then
         visible(img_StandbyDisplay_On, true)
         visible(img_StandbyDisplay_On_night, true)
    elseif  standby_on == false then
        visible(img_StandbyDisplay_On, false)
        visible(img_StandbyDisplay_On_night, false)
    end
end   
fs2020_variable_subscribe("A:Circuit Switch On:49", "Bool", ss_Standby_Display_Status)                             