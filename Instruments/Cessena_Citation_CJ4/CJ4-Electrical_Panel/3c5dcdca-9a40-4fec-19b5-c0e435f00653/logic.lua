--[[
   CJ4 Electrical Panel
   Author Rob Verdon
   rob.verdon@gmail.com
   
   Version 2.0
   Currently Does Not Require MobiFlight
   
--]]

--Backgroud Image before anything else
img_add_fullscreen("background.png")

img_LGen_On = img_add("Gen_On.png", 147,84,94,94)
img_RGen_On = img_add("Gen_On.png", 512,84,94,94)
img_Battery_On = img_add("Battery_On.png", 325,56,102,125)
--img_Battery_Emer = img_add("Battery_EMER.png", 325,82,102,155)
img_AVI_On = img_add("AVI_On.png", 500,296,110,121)
img_AVI_Dispatch = img_add("AVI_Dispatch.png", 507,319,120,160)
img_Emergency_Armed = img_add("Emergency_Armed.png", 137,299,110,121)
img_StandbyDisplay_On = img_add("StandyDisplay_On.png", 318,299,110,121)


--L Gen    
function LGen()
   fs2020_event("TOGGLE_ALTERNATOR1")
end
button_add(nil,nil,  147,87,90,90, LGen)
--R Gen    
function RGen()
   fs2020_event("TOGGLE_ALTERNATOR2")
end
button_add(nil,nil, 511,84,94,94, RGen)

--BatteryOn     
function BatteryOn()
   fs2020_event("TOGGLE_MASTER_BATTERY")
   --fs2020_event("mobiflight.WT_CJ4_MASTER_BATTERY_ON")
end
button_add(nil,nil, 330,35,94,60, BatteryOn)


--BatteryEmer (NOT WORKING) 
function BatteryEMER()
   --fs2020_event("TOGGLE_MASTER_BATTERY")
   --fs2020_event("mobiflight.WT_CJ4_MASTER_BATTERY_EMER")
   --fs2020_variable_write("A:ELECTRICAL MASTER BATTERY:1", "Bool",true) 
   --fs2020_variable_write("L:XMLVAR_Essential_Bus_On","Int",1)
   --fs2020_event("K:TOGGLE_MASTER_BATTERY")
   --fs2020_variable_write("A:ELECTRICAL MASTER BATTERY:1")

end
button_add(nil,nil, 330,160,94,60, BatteryEMER)



--BatteryOff     
function BatteryOff()
   fs2020_event("TOGGLE_MASTER_BATTERY")
   --fs2020_event("mobiflight.WT_CJ4_MASTER_BATTERY_OFF")
end
button_add(nil,nil, 330,90,94,60, BatteryOff)
--AVIOn   
function AVI_On()
    fs2020_event("AVIONICS_MASTER_1_SET",1)
    fs2020_event("AVIONICS_MASTER_2_SET",0)
end
button_add(nil,nil, 501,285,120,60, AVI_On)  
--AVIOff
function AVI_Off()
    fs2020_event("AVIONICS_MASTER_1_SET",0)
    fs2020_event("AVIONICS_MASTER_2_SET",0)
end
button_add(nil,nil, 501,335,120,50, AVI_Off)
--AVIDispatch
function AVI_Dispatch()
    fs2020_event("AVIONICS_MASTER_1_SET",0)
    fs2020_event("AVIONICS_MASTER_2_SET",1)
end
button_add(nil,nil, 501,385,120,50, AVI_Dispatch)
-- EmergencyLightsArmed
function Emerg_Lights_Armed()
	fs2020_variable_write("L:WT_CJ4_EMER_LIGHT_ARMED", "Int",1)
end
button_add(nil,nil, 137,300,120,50, Emerg_Lights_Armed)
function Emerg_Lights_Off()
    fs2020_variable_write("L:WT_CJ4_EMER_LIGHT_ARMED", "Int",0) 
end
button_add(nil,nil, 137,340,120,50, Emerg_Lights_Off)
--Stand By Display On
function Standby_Display_On()
    fs2020_event("K:ELECTRICAL_CIRCUIT_TOGGLE",49, "Int",1)
end
button_add(nil,nil, 321,295,120,50, Standby_Display_On)
--Stand By Display Off
function Standby_Display_Off()
   fs2020_event("K:ELECTRICAL_CIRCUIT_TOGGLE",49, "Int",0)
end
button_add(nil,nil, 321,340,120,50, Standby_Display_Off)

---------------------------------
 
--Test if Gen is On         
function Gen_Status(Gen1_Status,Gen2_Status) 
    if Gen1_Status == true then 
        visible(img_LGen_On, true)
    else 
        visible(img_LGen_On, false)
    end
    if Gen2_Status == true then 
        visible(img_RGen_On, true)
    else 
        visible(img_RGen_On, false)
    end
end
--Test if Batt is On         
function Battery_Status(Battery_Status1) 
    if Battery_Status1 == true then 
        visible(img_Battery_On, true)
    else 
        visible(img_Battery_On, false)
    end 
end
--Test if AVI is On         
function AVI_Status(AVI_Bus_1,AVI_Bus_2) 
    if AVI_Bus_1 == true then 
        visible(img_AVI_On, true)
        visible(img_AVI_Dispatch, false)
        --AVI_OnOff = true
    elseif AVI_Bus_2 == true then 
        visible(img_AVI_On, false)
        visible(img_AVI_Dispatch, true)
       -- AVI_OnOff = true
    else 
        visible(img_AVI_On, false)
        visible(img_AVI_Dispatch, false)
       -- AVI_OnOff = false
    end 

end
--Test if Emergency Lights Armed
function Emerg_Lights_Status(emlights_armed)
    if emlights_armed == 1 then
         visible(img_Emergency_Armed, true)
    elseif emlights_armed == 0 then
        visible(img_Emergency_Armed, false)
    end
end
--Test if Standy By Display ON
function Standby_Display_Status(standby_on)
    if standby_on == true then
         visible(img_StandbyDisplay_On, true)
    elseif  standby_on == false then
        visible(img_StandbyDisplay_On, false)
    end
end   
   
fs2020_variable_subscribe("GENERAL ENG MASTER ALTERNATOR:1","Bool",
                          "GENERAL ENG MASTER ALTERNATOR:2","Bool",Gen_Status)
                          
fs2020_variable_subscribe("ELECTRICAL MASTER BATTERY","Bool",Battery_Status)


fs2020_variable_subscribe("AVIONICS MASTER SWITCH:1","Bool",
                          "AVIONICS MASTER SWITCH:2","Bool", AVI_Status)
                          
fs2020_variable_subscribe("L:WT_CJ4_EMER_LIGHT_ARMED", "Int", Emerg_Lights_Status)

fs2020_variable_subscribe("A:Circuit Switch On:49", "Bool", Standby_Display_Status)                             