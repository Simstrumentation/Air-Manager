--[[
   CJ4 Upper DCP Menu
   Author Rob Verdon
   rob.verdon@gmail.com
   
   Version 1.0
   Functonal as of 3-3-2021
   
   REQUIRES Mobiflight-event-module in community folder  
   https://www.mobiflight.com/en/download.html
   
   How to in 1st post here:
   https://forums.flightsimulator.com/t/full-g1000-control-now-with-mobiflight/348509

   CCP Meanu, Radar Menu, TAWS Menu and Weather Tilt not functional.
  
--]]
  
  
--Backgroud Image before anything else
img_add_fullscreen("background.png")
--Sounds   
click_snd = sound_add("Asobo_CJ4_WT_PC_75.wav")
fail_snd = sound_add("beepfail.wav")
dial_snd = sound_add("dial.wav")

--NAV Select    
function nav()
   fs2020_event("MOBIFLIGHT.Generic_Upr_Push_NAV")
   sound_play(click_snd)
end
button_add(nil,"nav_pressed.png", 82,30,91,70, nav)
--PFD Select    
function pfd()
   fs2020_event("MOBIFLIGHT.Generic_Upr_Push_PFD_MENU")
   sound_play(click_snd)
end
button_add(nil,"pfd_pressed.png", 203,30,91,70, pfd)
--ESC Select    
function esc()
   fs2020_event("MOBIFLIGHT.Generic_Upr_Push_ESC")
   sound_play(click_snd)
end
button_add(nil,"ESC_pressed.png", 326,30,91,70, esc)
--ET Select    
function et()
   fs2020_event("MOBIFLIGHT.Generic_Upr_Push_ET")
   sound_play(click_snd)
end
button_add(nil,"ET_pressed.png", 446,30,91,70, et)
--FRMT Select    
function frmt()
   fs2020_event("MOBIFLIGHT.Generic_Upr_Push_FRMT")
   sound_play(click_snd)
end
button_add(nil,"frmt_pressed.png", 567,30,91,70, frmt)
--TERR Select    
function terr()
   fs2020_event("MOBIFLIGHT.Generic_Upr_Push_TERR_WX")
   sound_play(click_snd)
end
button_add(nil,"terr_pressed.png", 687,30,91,70, terr)
--TFC Select    
function tfc()
   fs2020_event("MOBIFLIGHT.Generic_Upr_Push_TFC")
   sound_play(click_snd)
end
button_add(nil,"TFC_pressed.png", 807,30,91,70, tfc)
--CCP Select    
function ccp()
   fs2020_event("MOBIFLIGHT.Generic_Upr_Push_CCP")
   sound_play(fail_snd)
end
button_add(nil,"CCP_pressed.png", 273,125,91,70, ccp)
--REFS Select    
function refs()
   fs2020_event("MOBIFLIGHT.Generic_Upr_Push_REFS_MENU")
   sound_play(click_snd)
end
button_add(nil,"REFS_pressed.png", 273,227,91,70, refs)
--RADAR Select    
function radar()
   fs2020_event("MOBIFLIGHT.Generic_Upr_Push_RADAR_MENU")
   sound_play(fail_snd)
end
button_add(nil,"RADAR_pressed.png", 606,125,91,70, radar)
--TAWS Select    
function taws()
   fs2020_event("MOBIFLIGHT.Generic_Upr_Push_TAWS_MENU")
   sound_play(fail_snd)
end
button_add(nil,"TAWS_pressed.png", 606,228,91,70, taws)


--------------------------------------------------


--BARO DIAL
function baro_turn( direction)
     if direction ==  -1 then
          fs2020_event("MOBIFLIGHT.AS1000_PFD_BARO_DEC") 
          fs2020_event("KOHLSMAN_DEC")
          sound_play(dial_snd) 
     elseif direction == 1 then
          fs2020_event("MOBIFLIGHT.AS1000_PFD_BARO_INC") 
          fs2020_event("KOHLSMAN_INC")
          sound_play(dial_snd) 
     end
end
baro_dial = dial_add("baro.png", 115,165,120,120, baro_turn)
 
--BARO STD PRESS
function baro_click()
    fs2020_event("BAROMETRIC")  
    sound_play(click_snd)
end    
button_add(nil,nil, 140,190,70,70, baro_click)

 --------------------------------------------------

--MENU DIAL (OUTER)
function menu_turn( direction)
     if direction ==  -1 then
         fs2020_event("MOBIFLIGHT.Generic_Upr_MENU_ADV_DEC")
         sound_play(dial_snd)
     elseif direction == 1 then
         fs2020_event("MOBIFLIGHT.Generic_Upr_MENU_ADV_INC")
         sound_play(dial_snd)
     end
end
menu_dial = dial_add("MENU_Dial.png", 418,165,120,120, menu_turn)
--DATA DIAL (INNER)
function data_turn( direction)
     if direction ==  -1 then
         fs2020_event("MOBIFLIGHT.Generic_Upr_Data_DEC")
         sound_play(dial_snd)
     elseif direction == 1 then
         fs2020_event("MOBIFLIGHT.Generic_Upr_Data_INC")
         sound_play(dial_snd)
     end
end
data_dial = dial_add("DATA_Dial.png", 437,182,85,85, data_turn) 
--DATA PRESS
function data_click()
    fs2020_event("Mobiflight.Generic_Upr_Data_PUSH")  
    sound_play(click_snd)
end    
button_add(nil,nil, 450,200,50,50, data_click) 
 
 --------------------------------------------------

 
 --TILT DIAL (OUTER)
function tilt_turn( direction)
     if direction ==  -1 then
         fs2020_event("MOBIFLIGHT.xx")
         sound_play(fail_snd)
     elseif direction == 1 then
         fs2020_event("MOBIFLIGHT.xx")
         sound_play(fail_snd)
     end
end
tilt_dial = dial_add("TILT_Dial.png", 735,165,120,120, tilt_turn)


--RANGE DIAL (INNER)
function range_turn( direction)
     if direction ==  -1 then
         fs2020_event("MOBIFLIGHT.Generic_Upr_RANGE_DEC")
         sound_play(dial_snd)
     elseif direction == 1 then
         fs2020_event("MOBIFLIGHT.Generic_Upr_RANGE_INC")
         sound_play(dial_snd)
     end
end
range_dial = dial_add("RANGE_Dial.png", 754,182,85,85, range_turn) 

--TILT PRESS
function tilt_click()
    fs2020_event("Mobiflight.Generic_Upr_Tilt_PUSH")  
    sound_play(fail_snd)
end    
button_add(nil,nil, 773,200,50,50, tilt_click) 



