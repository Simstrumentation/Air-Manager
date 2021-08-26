--[[
   CJ4 AutoPilot Panel
   Author Rob Verdon
   rob.verdon@gmail.com
   
   Version 1.1
   Functonal as of 3-7-2021
   
   REQUIRES Mobiflight-event-module in community folder  
   https://www.mobiflight.com/en/download.html
   
   How to in 1st post here:
   https://forums.flightsimulator.com/t/full-g1000-control-now-with-mobiflight/348509


   ** Speed knob only goes by 10 increments


    3-8-2021 YD button fixed.



--]]





--Backgroud Image before anything else
img_add_fullscreen("background.png")

--SOUNDS
click_snd = sound_add("Asobo_CJ4_WT_PC_75.wav")
fail_snd = sound_add("beepfail.wav")
dial_snd = sound_add("dial.wav")

--IMG
AP_Dis_IMG_Off = img_add("AP_Dis.png", 1515,117,170,75)
AP_Dis_IMG_On = img_add("AP_Dis.png", 1515,130,170,75)

--Locals
local AP_DIS_STATUS_LOCAL = false


--Flight Director ON   
function FD()
   fs2020_event("TOGGLE_FLIGHT_DIRECTOR")
   sound_play(click_snd)
end
button_add(nil,"FD_pressed.png",  103,37,63,48, FD)
button_add(nil,"FD_pressed.png",  1751,37,63,48, FD)
--Virticle Speed    
function VS()
   fs2020_event("MOBIFLIGHT.WT_CJ4_AP_VS_PRESSED")
   sound_play(click_snd)
end
button_add(nil,"VS_pressed.png", 270,37,63,48, VS)
--FLC    
function FLC()
   fs2020_event("MOBIFLIGHT.WT_CJ4_AP_FLC_PRESSED")
   sound_play(click_snd)
end
button_add(nil,"FLC_pressed.png", 607,37,63,48, FLC) 
--NAV    
function NAV()
   fs2020_event("MOBIFLIGHT.WT_CJ4_AP_NAV_PRESSED")
   sound_play(click_snd)
end
button_add(nil,"NAV_pressed.png", 775,37,63,48, NAV) 
--HDG    
function HDG()
   fs2020_event("MOBIFLIGHT.WT_CJ4_AP_HDG_PRESSED")
   sound_play(click_snd)
end
button_add(nil,"HDG_pressed.png", 935,37,63,48, HDG) 
--APPR    
function APPR()
   fs2020_event("MOBIFLIGHT.WT_CJ4_AP_APPR_PRESSED")
   sound_play(click_snd)
end
button_add(nil,"APPR_pressed.png", 1085,37,63,48, APPR) 
--ALT    
function ALT()
   --fs2020_event("MOBIFLIGHT.WT_CJ4_AP_ALT_PRESSED")
   fs2020_event("AP_ALT_HOLD")
   sound_play(click_snd)
end
button_add(nil,"ALT_pressed.png", 1236,37,63,48, ALT) 
--YD    
function YD()
   fs2020_event("YAW_DAMPER_TOGGLE")
   --fs2020_event("MOBIFLIGHT.WT_CJ4_AP_YD_PRESSED")
   sound_play(click_snd)
end
button_add(nil,"YD_pressed.png", 1389,37,63,48, YD) 
--AP    
function AP()
   fs2020_event("AP_MASTER")
   sound_play(click_snd)
end
button_add(nil,"AP_pressed.png", 1569,37,63,48, AP) 
--VNAV    
function VNAV()
   fs2020_event("MOBIFLIGHT.WT_CJ4_AP_VNAV_PRESSED")
   sound_play(click_snd)
end
button_add(nil,"VNAV_pressed.png", 270,135,63,48, VNAV) 
--BANK    
function BANK()
   fs2020_event("AP_MAX_BANK")
   sound_play(fail_snd)
end
button_add(nil,"BANK_pressed.png", 775,135,63,48, BANK) 
--BC    
function BC()
   fs2020_event("MOBIFLIGHT.WT_CJ4_AP_BC_PRESSED")
   --AP_BC_HOLD_ON
   sound_play(click_snd)
end
button_add(nil,"BC_pressed.png", 1085,135,63,48, BC) 
--APXFR    
function APXFR()
   fs2020_event("MOBIFLIGHT.WT_CJ4_AP_APXFR_PRESSED")
   sound_play(fail_snd)
end
button_add(nil,"AP-XFR_pressed.png", 1389,135,63,48, APXFR) 


-----VS Dial-------------
VSDialorButtons = user_prop_add_boolean("VS Dial acts as buttons instead of dial", false, "") -- Show or hide the unit type onscreen
if user_prop_get(VSDialorButtons) then
    --VS DEC    
    function VS_DEC()
       fs2020_event("AP_VS_VAR_DEC")
       sound_play(dial_snd)
    end
    button_add(nil,"VS_DEC_pressed.png", 437,42,40,68, VS_DEC) 
    --VS INC    
    function VS_INC()
       fs2020_event("AP_VS_VAR_INC")
       sound_play(dial_snd)
    end
    button_add(nil,"VS_INC_pressed.png", 437,110,40,68, VS_INC) 
else
    function VS_DIAL( direction)
         if direction ==  -1 then
             fs2020_event("AP_VS_VAR_DEC")
             sound_play(dial_snd)
         elseif direction == 1 then
             fs2020_event("AP_VS_VAR_INC")
             sound_play(dial_snd)
         end
    end
    VS_dial = dial_add(nil, 437,42,40,148, VS_DIAL)

end


--CRS1 DIAL (PILOT)
function CRS1_DIAL( direction)
     if direction ==  -1 then
         fs2020_event("VOR1_OBI_DEC")
         sound_play(dial_snd)
     elseif direction == 1 then
         fs2020_event("VOR1_OBI_INC")
         sound_play(dial_snd)
     end
end
dial_add("CRS_DIAL.png", 89,112,96,95, CRS1_DIAL)
--CRS2 DIAL (PILOT)
function CRS2_DIAL( direction)
     if direction ==  -1 then
         fs2020_event("VOR2_OBI_DEC")
         sound_play(dial_snd)
     elseif direction == 1 then
         fs2020_event("VOR2_OBI_INC")
         sound_play(dial_snd)
     end
end
dial_add("CRS_DIAL.png", 1739,112,96,95, CRS2_DIAL)


--IAS DIAL (OUTER)
function IAS_DIAL( direction)
     if direction ==  -1 then
         fs2020_event("AP_SPD_VAR_DEC")
         sound_play(dial_snd)
     elseif direction == 1 then
         fs2020_event("AP_SPD_VAR_INC")
         sound_play(dial_snd)
     end
end

dial_add("IAS_DIAL.png", 592,112,96,95, IAS_DIAL)
--IAS PRESS
function IAS_DIAL_click()
    fs2020_event("AP_MACH_SET")  
    sound_play(click_snd)
end    
button_add(nil,nil, 607,140,40,40, IAS_DIAL_click) 

---------------------------------------------------------
function ap_heading_bug_callback(heading)   
    HDG_Degrees = heading
    --print("CB Heading:" .. tostring(heading))
    return HDG_Degrees
end
fs2020_variable_subscribe("AUTOPILOT HEADING LOCK DIR", "Degrees", ap_heading_bug_callback)


function hdg_turn_inner( direction)
        if direction ==  -1 then
            HDG_Degrees = HDG_Degrees - 1
            if HDG_Degrees <= 0 then
                NewHdg = 360
            else
                NewHdg = HDG_Degrees
            end
            print("Heading Degrees CCW: " .. tostring(HDG_Degrees))
            print("New Heading: " .. tostring(NewHdg)) 
            fs2020_event("HEADING_BUG_SET", NewHdg)
        elseif direction == 1 then
            HDG_Degrees = HDG_Degrees + 1
            if HDG_Degrees >= 361 then
                NewHdg = HDG_Degrees - 360
            else
                NewHdg = HDG_Degrees
            end
            print("Heading Degrees CW: " .. tostring(HDG_Degrees))
            print("New Heading: " .. tostring(NewHdg)) 
            fs2020_event("HEADING_BUG_SET", NewHdg)
        end
    end
hdg_dial = dial_add("HDG_DIAL.png", 917,120,90,90,3, hdg_turn_inner)






-------------------------------



--[[

--HDG DIAL 
function HDG_DIAL( direction)
     if direction ==  -1 then
         fs2020_event("HEADING_BUG_DEC")
         sound_play(dial_snd)
     elseif direction == 1 then
         fs2020_event("HEADING_BUG_INC")
         sound_play(dial_snd)
     end
end
dial_add("HDG_DIAL.png", 917,120,90,90, HDG_DIAL)


--]]



--HDG PRESS
function HDG_DIAL_click()
    --fs2020_event("HEADING_BUG_SET")  
    fs2020_event("AP_HDG_HOLD")  
    sound_play(click_snd)
end    
button_add(nil,nil, 940,140,40,40, HDG_DIAL_click) 


-----------------------------------------------------------
-- Altitude Target Knob
    function alt_callback(altitude)
        --fs2020_event("AP_ALT_VAR_SET_ENGLISH",altitude)
        TargetAlt = altitude
        return TargetAlt 
    end
    fs2020_variable_subscribe("AUTOPILOT ALTITUDE LOCK VAR", "feet", alt_callback)

    function alt_large_callback(direction)
        StepVal = 1000
        -- Direction will have the value
        if direction == 1 then
            TargetAlt =  TargetAlt + StepVal
        elseif direction == -1 then
            TargetAlt =  TargetAlt - StepVal   
        end
        fs2020_event("AP_ALT_VAR_SET_ENGLISH",TargetAlt)   
    end

    function alt_small_callback(direction)
        StepVal = 100    -- altdirection will have the value
        if direction == 1 then
            TargetAlt =  TargetAlt + StepVal
        elseif direction == -1 then
            TargetAlt =  TargetAlt - StepVal    
        end
        fs2020_event("AP_ALT_VAR_SET_ENGLISH",TargetAlt)       
    end
    alt_dial_outer = dial_add("ALT_DIAL.png", 1217,117,95,95, alt_large_callback)
    dial_click_rotate( alt_dial_outer, 6)

    alt_dial_inner = dial_add(nil, 1232,135,65,65, alt_small_callback)
    dial_click_rotate( alt_dial_inner, 6)
-- End Altitude Target Knob

--dial_add("ALT_DIAL.png", 1217,117,95,95, ALT_DIAL)

--[[
--ALT DIAL 
function ALT_DIAL( direction)
     if direction ==  -1 then
         fs2020_event("AP_ALT_VAR_DEC")
         sound_play(dial_snd)
     elseif direction == 1 then
         fs2020_event("AP_ALT_VAR_INC")
         sound_play(dial_snd)
     end
end
dial_add("ALT_DIAL.png", 1217,117,95,95, ALT_DIAL)
]]--

--ALT PRESS
--[[
function ALT_DIAL_click()
    fs2020_event("HEADING_BUG_SET")  
    sound_play(click_snd)
end    
button_add(nil,nil, 940,140,40,40, ALT_DIAL_click) 
]]--




--AP_DIS

function  AP_DIS_STATUS(AP_DIS_STATUS1)
    if AP_DIS_STATUS1 == true then
        AP_DIS_STATUS_LOCAL = true
         visible(AP_Dis_IMG_On, true)
         visible(AP_Dis_IMG_Off, false)         
    else 
        AP_DIS_STATUS_LOCAL = false
         visible(AP_Dis_IMG_On, false)
         visible(AP_Dis_IMG_Off, true)           
    end
end


function AP_DIS()
    if AP_DIS_STATUS_LOCAL == true then
        fs2020_event("AUTOPILOT_DISENGAGE_SET",0)
        sound_play(click_snd)
    else
        fs2020_event("AUTOPILOT_DISENGAGE_SET",1)
        sound_play(click_snd)
    end
end
   

button_add(nil,nil, 1515,127,170,68, AP_DIS)
fs2020_variable_subscribe("AUTOPILOT DISENGAGED","Bool", AP_DIS_STATUS)   





