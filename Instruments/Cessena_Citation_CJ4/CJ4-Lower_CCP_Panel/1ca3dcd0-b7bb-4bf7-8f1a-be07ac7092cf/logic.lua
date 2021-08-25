--[[
   CJ4 Lower CCP Panel (Cursor Control Panel)
   Author Rob Verdon
   rob.verdon@gmail.com
   
   Version 1.0
   Functonal as of 3-4-2021
   
   REQUIRES Mobiflight-event-module in community folder  
   https://www.mobiflight.com/en/download.html
   
   How to in 1st post here:
   https://forums.flightsimulator.com/t/full-g1000-control-now-with-mobiflight/348509

   Zoom not functional.
   3-13-21 Chart Functional
  
--]]
  
  
--Backgroud Image before anything else
img_add_fullscreen("background.png")
--Sounds   
click_snd = sound_add("Asobo_CJ4_WT_PC_75.wav")
fail_snd = sound_add("beepfail.wav")
dial_snd = sound_add("dial.wav")



--UPR Menu Select    
function UPR_Menu()
   fs2020_event("MOBIFLIGHT.Generic_Lwr_Push_UPR_MENU")
   sound_play(click_snd)
end
button_add(nil,"UPR_Menu_pressed.png", 81,18,80,58, UPR_Menu)
--ESC Select    
function ESC()
   fs2020_event("MOBIFLIGHT.Generic_Lwr_Push_ESC")
   sound_play(click_snd)
end
button_add(nil,"ESC_pressed.png", 174,18,80,58, ESC)
--DATABASE Select    
function DATABASE()
   fs2020_event("MOBIFLIGHT.Generic_Lwr_Push_DATABASE")
   sound_play(fail_snd)
end
button_add(nil,"DATABASE_pressed.png", 267,18,80,58, DATABASE)
--NAVDATA Select    
function NAVDATA()
   fs2020_event("MOBIFLIGHT.Generic_Lwr_Push_NAVDATA")
   sound_play(fail_snd)
end
button_add(nil,"NAVDATA_pressed.png", 357,18,80,58, NAVDATA)
--CHART Select    
function CHART()
   fs2020_event("MOBIFLIGHT.Generic_Lwr_Push_CHART_1")
   sound_play(click_snd)
end
button_add(nil,"CHART_pressed.png", 450,18,80,58, CHART)
--CAS Select    
function CAS()
   fs2020_event("MOBIFLIGHT.Generic_Lwr_Push_CAS")
   sound_play(click_snd)
end
button_add(nil,"CAS_pressed.png", 543,18,80,58, CAS)
--LWR Menu Select    
function LWR_MENU()
   fs2020_event("MOBIFLIGHT.Generic_Lwr_Push_LWR_MENU")
   sound_play(click_snd)
end
button_add(nil,"LWR_MENU_pressed.png", 81,103,80,58, LWR_MENU)
--CURSR Select    
function CURSR()
   fs2020_event("MOBIFLIGHT.Generic_Lwr_Push_CURSR")
   sound_play(fail_snd)
end
button_add(nil,"CURSR_pressed.png", 81,190,80,58, CURSR)
--ENG Select    
function ENG()
   fs2020_event("MOBIFLIGHT.Generic_Lwr_Push_ENG")
   sound_play(click_snd)
end
button_add(nil,"ENG_pressed.png", 81,275,80,58, ENG)
--TERRWX Select    
function TERRWX()
   fs2020_event("MOBIFLIGHT.Generic_Lwr_Push_TERR_WX")
   sound_play(click_snd)
end
button_add(nil,"TERRWX_pressed.png", 175,275,80,58, TERRWX)
--TFC Select    
function TFC()
   fs2020_event("MOBIFLIGHT.Generic_Lwr_Push_TFC")
   sound_play(click_snd)
end
button_add(nil,"TFC_pressed.png", 265,275,80,58, TFC)
--MEM1 Select    
function MEM1()
   fs2020_event("MOBIFLIGHT.Generic_Lwr_Push_MEM1_1")
   sound_play(click_snd)
end
button_add(nil,"MEM1_pressed.png", 358,103,80,58, MEM1)
--MEM2 Select    
function MEM2()
   fs2020_event("MOBIFLIGHT.Generic_Lwr_Push_MEM2_1")
   sound_play(click_snd)
end
button_add(nil,"MEM2_pressed.png", 358,189,80,58, MEM2)
--MEM3 Select    
function MEM3()
   fs2020_event("MOBIFLIGHT.Generic_Lwr_Push_MEM3_1")
   sound_play(click_snd)
end
button_add(nil,"MEM3_pressed.png", 359,275,80,58, MEM3)
--SYS Select    
function SYS()
   fs2020_event("MOBIFLIGHT.Generic_Lwr_Push_SYS")
   sound_play(click_snd)
end
button_add(nil,"SYS_pressed.png", 451,275,80,58, SYS)
--CKLST Select    
function CKLST()
   fs2020_event("MOBIFLIGHT.Generic_Lwr_Push_CKLST_1")
   sound_play(click_snd)
end
button_add(nil,"CKLST_pressed.png", 544,275,80,58, CKLST)
--PASSBRIEF Select    
function PASSBRIEF()
   fs2020_event("MOBIFLIGHT.Generic_Lwr_Push_PASSBRIEF_1")
   sound_play(click_snd)
end
button_add(nil,"PASSBRIEF_pressed.png", 637,275,80,58, PASSBRIEF)
--ZOOMMINUS   
function ZOOMMINUS ()
   fs2020_event("MOBIFLIGHT.Generic_Lwr_Push_ZOOM_DEC")
   sound_play(fail_snd)
end
button_add(nil,"ZOOMMINUS_pressed.png", 452,187,52,60, ZOOMMINUS )
--ZOOMPLUS   
function ZOOMPLUS()
   fs2020_event("MOBIFLIGHT.Generic_Lwr_Push_ZOOM_INC")
   sound_play(fail_snd)
end
button_add(nil,"ZOOMPLUS_pressed.png", 501,187,52,60, ZOOMPLUS)
--ROTATE  
function ROTATE()
   fs2020_event("MOBIFLIGHT.Generic_Lwr_Push_ROTATE")
   sound_play(fail_snd)
end
button_add(nil,"ROTATE_pressed.png",451,103,80,58, ROTATE)




--MENU DIAL (OUTER)
function menu_turn( direction)
     if direction ==  -1 then
         fs2020_event("MOBIFLIGHT.Generic_Lwr_MENU_ADV_DEC")
         sound_play(dial_snd)
     elseif direction == 1 then
         fs2020_event("MOBIFLIGHT.Generic_Lwr_MENU_ADV_INC")
         sound_play(dial_snd)
     end
end
menu_dial = dial_add("MENU_Dial.png", 215,125,90,90, menu_turn)
--DATA DIAL (INNER)
function data_turn( direction)
     if direction ==  -1 then
         fs2020_event("MOBIFLIGHT.Generic_Lwr_Data_DEC")
         sound_play(dial_snd)
     elseif direction == 1 then
         fs2020_event("MOBIFLIGHT.Generic_Lwr_Data_INC")
         sound_play(dial_snd)
     end
end
data_dial = dial_add("DATA_Dial.png", 230,140,60,60, data_turn) 
--DATA PRESS
function data_click()
    fs2020_event("Mobiflight.Generic_Lwr_Data_PUSH")  
    sound_play(click_snd)
end    
button_add(nil,nil, 240,150,30,50, data_click) 






