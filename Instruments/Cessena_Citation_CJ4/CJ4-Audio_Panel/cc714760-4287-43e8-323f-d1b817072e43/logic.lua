--[[
   CJ4 Audio Panel
   Author Rob Verdon
   rob.verdon@gmail.com
   
   Version 1.0
   Functonal as of 3-4-2021
   
   REQUIRES Mobiflight-event-module in community folder  
   https://www.mobiflight.com/en/download.html
   
   How to in 1st post here:
   https://forums.flightsimulator.com/t/full-g1000-control-now-with-mobiflight/348509

   COM1 and COM2 Mute not functional.
   NAV1 and NAV2 Mute not functional.

--]]
  
--Backgroud Image before anything else
img_add_fullscreen("background.png")


---Sounds
click_snd = sound_add("Asobo_CJ4_WT_PC_75.wav")
fail_snd = sound_add("beepfail.wav")
dial_snd = sound_add("dial.wav")

--COM Channel Indicator
com1_light = img_add("COM_Light.png", 97,11,20,21)
com2_light = img_add("COM_Light.png", 200,11,20,21)


-- Indicator s 
com1_ind = img_add("dme_on.png", 86,127,55,55)
com2_ind = img_add("dme_on.png", 184,127,55,55)
nav1_ind = img_add("dme_on.png", 77,257,55,55) 
nav2_ind = img_add("dme_on.png", 183,257,55,55)
dme_ind = img_add("dme_on.png", 289,255,55,55)
-- no dme 2
adf_ind = img_add("dme_on.png", 605,257,55,55)
mute_ind = img_add("dme_on.png", 500,257,55,55)
 

--START--

--Com1 TX Select    
function com1()
   fs2020_event("COM1_TRANSMIT_SELECT")
   sound_play(click_snd)
end
 button_add(nil,"Buttons1.png", 87,36,41,39, com1)


--Com2 TX Select    
function com2()
   fs2020_event("COM2_TRANSMIT_SELECT")
   sound_play(click_snd)
end
button_add(nil,"Buttons1.png", 191,36,41,39, com2)

--See Which Com TX In Use
function comtx_inuse(com1active)
        if com1active == true then
           visible(com1_light, true)
           visible(com2_light, false)           
         else
           visible(com2_light, true)
           visible(com1_light, false)
         end
end





--HF Select    
function hf()
   fs2020_event("HF_TRANSMIT_SELECT")
   sound_play(fail_snd)
end
--button_add(nil,"Buttons1.png", 401,36,41,39, hf)

--PA Select    
function pa()
   fs2020_event("PA_TRANSMIT_SELECT")
   sound_play(fail_snd)
end
--button_add(nil,"Buttons1.png", 719,36,41,39, pa)

-----------------------------------
-----BUTTONS-----
--Com1 Receive All 
function mid_com1()
   --fs2020_event("COM_RECEIVE_ALL_TOGGLE")
   sound_play(fail_snd)
end
button_add(nil,nil, 86,127,55,55, mid_com1)

--Com2 Receive All 
function mid_com2()
   --fs2020_event("COM_RECEIVE_ALL_TOGGLE")
   sound_play(fail_snd)
end
button_add(nil,nil, 184,127,55,55, mid_com2)

--Nav Buttons   
function nav1_btn()
   --fs2020_event("RADIO_VOR1_IDENT_TOGGLE")
   sound_play(fail_snd)
end
button_add(nil,nil, 77,257,55,55, nav1_btn)

function nav2_btn()
   --fs2020_event("RADIO_VOR2_IDENT_TOGGLE")
   sound_play(fail_snd)
end
button_add(nil,nil, 183,257,55,55, nav2_btn)


--DME Button  
function dme_btn()
   fs2020_event("RADIO_SELECTED_DME_IDENT_TOGGLE")
end
button_add(nil,nil, 289,255,55,55, dme_btn)
--ADF Button 
function adf_btn()
   fs2020_event("RADIO_ADF_IDENT_TOGGLE")
end
button_add(nil,nil, 605,257,55,55, adf_btn)
--Mute Button 
function mute_btn()
   fs2020_event("MARKER_SOUND_TOGGLE")
   --fs2020_event("MOBIFLIGHT.AS1000_MID_MKR_Mute_Push")
end
button_add(nil,nil, 500,257,55,55, mute_btn)



---------------------------------
----Indicators------------

--Test if Nav1 is On         
function nav1_snd(nav1_sndch) 
    if nav1_sndch == true then 
        visible(nav1_ind, true)
    else 
        visible(nav1_ind, false)
    end
  end

--Test if Nav2 is On    
function nav2_snd(nav2_sndch) 
    if nav2_sndch == true then 
        visible(nav2_ind, true)
    else 
        visible(nav2_ind, false)
    end
  end 
 
--Test if DME is On    
function dme_snd(dme_sndch) 
    if dme_sndch == true then 
        visible(dme_ind, true)
    else 
        visible(dme_ind, false)
    end
  end 
--Test if ADF is On    
function adf_snd(adf_sndch) 
    if adf_sndch == true then 
        visible(adf_ind, true)
    else 
        visible(adf_ind, false)
    end
  end  
--Test if Mute is On    
function mute_snd(mute_sndch) 
    if mute_sndch == true then 
        visible(mute_ind, true)
    else 
        visible(mute_ind, false)
    end
  end  




    
fs2020_variable_subscribe("COM TRANSMIT:1","Bool", comtx_inuse)
fs2020_variable_subscribe("NAV SOUND:1","Bool", nav1_snd)    
fs2020_variable_subscribe("NAV SOUND:2","Bool", nav2_snd)    
fs2020_variable_subscribe("DME SOUND","Bool", dme_snd)  
fs2020_variable_subscribe("ADF SOUND:1","Bool", adf_snd)
fs2020_variable_subscribe("MARKER SOUND","Bool", mute_snd)