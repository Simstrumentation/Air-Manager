--[[
   CJ4 Electrical Panel
   Author Rob Verdon
   rob.verdon@gmail.com
   
   Version 1.0
   Functonal as of 3-4-2021
   
   REQUIRES Mobiflight-event-module in community folder  
   https://www.mobiflight.com/en/download.html
   
   How to in 1st post here:
   https://forums.flightsimulator.com/t/full-g1000-control-now-with-mobiflight/348509

   Avionics Button Does not Work, Status only.

--]]

--Backgroud Image before anything else
img_add_fullscreen("background.png")

LGen_On = img_add("Gen_On.png", 147,84,94,94)
RGen_On = img_add("Gen_On.png", 512,84,94,94)
Battery_On = img_add("Battery_On.png", 325,58,102,125)
AVI_On = img_add("AVI_On.png", 500,296,110,121)


local AVI_OnOff = false


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
--Battery     
function Battery()
   fs2020_event("TOGGLE_MASTER_BATTERY")
end
button_add(nil,nil, 330,84,94,94, Battery) 
--AVI   
function AVI()
    if AVI_OnOff == true then 
        fs2020_event("AVIONICS_MASTER_SET",0)
    else 
        fs2020_event("AVIONICS_MASTER_SET",1)
    end  
   
end
button_add(nil,nil, 501,295,110,121, AVI)  

 

---------------------------------
 
--Test if Gen is On         
function Gen_Status(Gen1_Status,Gen2_Status) 
    if Gen1_Status == true then 
        visible(LGen_On, true)
    else 
        visible(LGen_On, false)
    end
    if Gen2_Status == true then 
        visible(RGen_On, true)
    else 
        visible(RGen_On, false)
    end
end
--Test if Batt is On         
function Battery_Status(Battery_Status1) 
    if Battery_Status1 == true then 
        visible(Battery_On, true)
    else 
        visible(Battery_On, false)
    end 
end
--Test if AVI is On         
function AVI_Status(AVI_Mast_Status) 
    if AVI_Mast_Status == true then 
        visible(AVI_On, true)
        AVI_OnOff = true
    else 
        visible(AVI_On, false)
        AVI_OnOff = false
    end 

end
 
   
fs2020_variable_subscribe("GENERAL ENG MASTER ALTERNATOR:1","Bool",
                          "GENERAL ENG MASTER ALTERNATOR:2","Bool",Gen_Status)
                          
fs2020_variable_subscribe("ELECTRICAL MASTER BATTERY","Bool",Battery_Status)        
fs2020_variable_subscribe("AVIONICS MASTER SWITCH","Bool", AVI_Status)                   
                          