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
 
##Left To Do:
    - 	
	
##Notes:
    - 
			 					  													   					 					  													   
******************************************************************************************
--]]

--Backgroud Image before anything else
img_add_fullscreen("background.png")
img_bg_night = img_add_fullscreen("background_night.png")

--backlight graphics
img_labels_backlight = img_add_fullscreen("backlight.png")

--Day graphics
img_LGen_On = img_add("Gen_On.png", 148,82,94,94)
img_RGen_On = img_add("Gen_On.png", 513,82,94,94)
img_Battery_On = img_add("Battery_On.png", 325,56,102,125)
img_AVI_On = img_add("AVI_On.png", 500,296,110,121)
img_AVI_Dispatch = img_add("AVI_Dispatch.png", 505,319,120,160)
visible(img_AVI_Dispatch, false)
img_Emergency_Armed = img_add("Emergency_Armed.png", 135,299,110,121)
img_StandbyDisplay_On = img_add("StandyDisplay_On.png", 316,299,110,121)

--Night Graphics
img_LGen_On_night = img_add("Gen_On_night.png", 148,82,94,94)
img_RGen_On_night = img_add("Gen_On_night.png", 513,82,94,94)
img_Battery_On_night = img_add("Battery_On_night.png", 325,56,102,125)
img_AVI_On_night = img_add("AVI_On_night.png", 500,296,110,121)
img_AVI_Dispatch_night = img_add("AVI_Dispatch_night.png", 505,319,120,160)
img_Emergency_Armed_night = img_add("Emergency_Armed_night.png", 135,299,110,121)
img_StandbyDisplay_On_night = img_add("StandyDisplay_On_night.png", 316,299,110,121)


--[[
-- Switches reflecting panel lighting 
-- needs more work. Future version change - Joe

img_LGen_On_glow = img_add("Gen_On_glow.png", 148,82,94,94)
img_RGen_On_glow = img_add("Gen_On_glow.png", 513,82,94,94)
img_Battery_On_glow = img_add("Battery_On_glow.png", 325,56,102,125)
img_AVI_On_glow = img_add("AVI_On_glow.png", 500,296,110,121)
--img_AVI_Dispatch_glow = img_add("AVI_Dispatch_glow.png", 505,319,120,160)
img_Emergency_Armed_glow = img_add("Emergency_Armed_glow.png", 135,299,110,121)
img_StandbyDisplay_On_glow = img_add("StandyDisplay_On_glow.png", 316,299,110,121)
]]--

-- Ambient Light Control
function ss_ambient_darkness(value)
    opacity(img_bg_night, value, "LOG", 0.04)
    opacity(img_LGen_On_night, value, "LOG", 0.04)
    opacity(img_RGen_On_night, value, "LOG", 0.04)
    opacity(img_Battery_On_night, value, "LOG", 0.04)
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
 --[[       opacity(img_LGen_On_glow, 0, "LOG", 0.04)
         opacity(img_RGen_On_glow, 0, "LOG", 0.04)
         opacity(img_Battery_On_glow, 0, "LOG", 0.04)
         opacity(img_AVI_On_glow, 0, "LOG", 0.04)
 --        opacity(img_AVI_Dispatch_glow, value, "LOG", 0.04)
         opacity(img_Emergency_Armed_glow, 0, "LOG", 0.04)
         opacity(img_StandbyDisplay_On_glow, 0, "LOG", 0.04)
 ]]--
     else
        opacity(img_labels_backlight, ((value/2)+0.5), "LOG", 0.04)
 --[[       opacity(img_LGen_On_glow, ((value/2)+0.5), "LOG", 0.04)
        opacity(img_RGen_On_glow, ((value/2)+0.5), "LOG", 0.04)
        opacity(img_Battery_On_glow, ((value/2)+0.5), "LOG", 0.04)
        opacity(img_AVI_On_glow, ((value/2)+0.5), "LOG", 0.04)
--        opacity(img_AVI_Dispatch_glow, ((value/2)+0.5), "LOG", 0.04)
        opacity(img_Emergency_Armed_glow, ((value/2)+0.5), "LOG", 0.04)
        opacity(img_StandbyDisplay_On_glow, ((value/2)+0.5), "LOG", 0.04)
 ]]--       
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

--BatteryOn     
function callback_BatteryOn()
   fs2020_event("TOGGLE_MASTER_BATTERY")
end
button_add(nil,nil, 330,35,94,60, callback_BatteryOn)

--BatteryEmer (NOT WORKING) 
function callback_BatteryEMER()
   --fs2020_event("TOGGLE_MASTER_BATTERY")
   --fs2020_event("mobiflight.WT_CJ4_MASTER_BATTERY_EMER")
   --fs2020_variable_write("A:ELECTRICAL MASTER BATTERY:1", "Bool",true) 
   --fs2020_variable_write("L:XMLVAR_Essential_Bus_On","Int",1)
   --fs2020_event("K:TOGGLE_MASTER_BATTERY")
   --fs2020_variable_write("A:ELECTRICAL MASTER BATTERY:1")
end
button_add(nil,nil, 330,160,94,60, callback_BatteryEMER)

--BatteryOff     
function callback_BatteryOff()
   fs2020_event("TOGGLE_MASTER_BATTERY")
end
button_add(nil,nil, 330,90,94,60, callback_BatteryOff)
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
 --       visible(img_LGen_On_glow, true)
    else 
        visible(img_LGen_On, false)
        visible(img_LGen_On_night, false)
 --        visible(img_LGen_On_glow, false)
    end
    if Gen2_Status == true then 
        visible(img_RGen_On, true)
        visible(img_RGen_On_night, true)
 --       visible(img_RGen_On_glow, true)
    else 
        visible(img_RGen_On, false)
        visible(img_RGen_On_night, false)
 --       visible(img_RGen_On_glow, false)
    end
end
fs2020_variable_subscribe("GENERAL ENG MASTER ALTERNATOR:1","Bool",
                          "GENERAL ENG MASTER ALTERNATOR:2","Bool",ss_Gen_Status)
                          
--Test if Batt is On         
function ss_Battery_Status(Battery_Status1) 
    if Battery_Status1 == true then 
        visible(img_Battery_On, true)
        visible(img_Battery_On_night, true)
 --       visible(img_Battery_On_glow, true)
    else 
        visible(img_Battery_On, false)
        visible(img_Battery_On_night, false)
--        visible(img_Battery_On_glow, false)
    end 
end
fs2020_variable_subscribe("ELECTRICAL MASTER BATTERY","Bool", ss_Battery_Status)

--Test if AVI is On         
function ss_AVI_Status(AVI_Bus_1,AVI_Bus_2) 
    if AVI_Bus_1 == true then 
        visible(img_AVI_On, true)
        visible(img_AVI_On_night, true)
--        visible(img_AVI_On_glow, true)
        visible(img_AVI_Dispatch, false)
        visible(img_AVI_Dispatch_night, false)
        --AVI_OnOff = true
    elseif AVI_Bus_2 == true then 
        visible(img_AVI_On, false)
        visible(img_AVI_On_night, false)
--        visible(img_AVI_On_glow, false)
        visible(img_AVI_Dispatch, true)
        visible(img_AVI_Dispatch_night, true)
       -- AVI_OnOff = true
    else 
        visible(img_AVI_On, false)
        visible(img_AVI_On_night, false)
--        visible(img_AVI_On_glow, false)
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