--[[
   C172 Audio Panel
   Author Rob Verdon
   
   MSFS2020
   Functions: Com1Mic, Com2Mic, Com1, Com2, DME, ADF, NAV1, NAV2,Marker Mute
   Beta Release 3-2-2021


--]]


--Backgroud Image before anything else
img_add_fullscreen("MidStack.png")

--Declare Locals
local com1mic = false
local com1select = false
local com2mic = false
local com2select = false
local nav1 = false
local nav2 = false
local dme = false
local adf = false
local LEDIndicator = "Mid_Aud_Enable.png"

--Set Images  

com1mic = img_add(LEDIndicator, 40,19,18,8)
com1select = img_add(LEDIndicator, 120,19,18,8) 

com2mic = img_add(LEDIndicator, 40,83,18,8)
com2select = img_add(LEDIndicator, 120,83,18,8)
   
nav1 = img_add(LEDIndicator, 120,392,18,8)   
nav2 = img_add(LEDIndicator, 120,450,18,8)  

dme = img_add(LEDIndicator, 40,392,18,8)
adf = img_add(LEDIndicator, 40,450,18,8)

mute = img_add(LEDIndicator, 40,325,18,8)

--Sounds   
click_snd = sound_add("knobclick.wav")
    
    
--Start 

--Com1 TX Select    
function mid_com1mic()
   fs2020_event("COM1_TRANSMIT_SELECT")
   sound_play(click_snd)
end
button_add(nil,"com1mic_pressed.png", 19,32,60,34, mid_com1mic)

--Com2 TX Select    
function mid_com2mic()
   fs2020_event("COM2_TRANSMIT_SELECT")
   sound_play(click_snd)
end
button_add(nil,"com2mic_pressed.png", 19,97,60,34, mid_com2mic)


--Com1 Receive All 
function mid_com1()
   fs2020_event("COM_RECEIVE_ALL_TOGGLE")
   sound_play(click_snd)
end
button_add(nil,"com1_pressed.png", 98,32,60,34, mid_com1)

--Com2 Receive All 
function mid_com2()
   fs2020_event("COM_RECEIVE_ALL_TOGGLE")
   sound_play(click_snd)
end
button_add(nil,"com2_pressed.png", 98,98,60,34, mid_com2)

--Nav Buttons   
function nav1_btn()
   fs2020_event("RADIO_VOR1_IDENT_TOGGLE")
   sound_play(click_snd)
end
button_add(nil,"NAV1_pressed.png", 98,406,60,34, nav1_btn)

function nav2_btn()
   fs2020_event("RADIO_VOR2_IDENT_TOGGLE")
   sound_play(click_snd)
end
button_add(nil,"NAV2_pressed.png", 98,464,60,34, nav2_btn)
--DME Button  
function dme_btn()
   fs2020_event("RADIO_SELECTED_DME_IDENT_TOGGLE")
   sound_play(click_snd)
end
button_add(nil,"DME_pressed.png", 18,406,60,34, dme_btn)
--ADF Button 
function adf_btn()
   fs2020_event("RADIO_ADF_IDENT_TOGGLE")
   sound_play(click_snd)
end
button_add(nil,"ADF_pressed.png", 18,464,60,35, adf_btn)
--Mute Button 
function mute_btn()
   fs2020_event("MARKER_SOUND_TOGGLE")
   --fs2020_event("MOBIFLIGHT.AS1000_MID_MKR_Mute_Push")
   sound_play(click_snd)
end
button_add(nil,"mute_pressed.png", 18,341,60,34, mute_btn)

--Dial
--mid_vol_dial_outer = dial_add("plain_knob_outer.png", 49,750,79,79, mid_vol_outer_turn)
--mid_vol_dial_inner = dial_add("plain_knob_inner.png", 65,766,47,47, mid_vol_inner_turn)

--Indicators LEDs on Panel

--COM LEDs
--    Test what com channel microphone is selected and see if receive all is on.
function com_inuse(com1active,com_rec_all)
        if com1active == true and com_rec_all== true then
           visible(com1mic, true)
           visible(com1select, true)
           visible(com2mic, false)
           visible(com2select, true)
        elseif com1active == true and com_rec_all== false then
           visible(com1mic, true)
           visible(com1select, true)
           visible(com2mic, false)
           visible(com2select, false)
         elseif com1active == false and com_rec_all== true then --Com2. REC all
           visible(com1mic, false)
           visible(com1select, true)
           visible(com2mic, true)
           visible(com2select, true)     
         else
           visible(com1mic, false)
           visible(com1select, false)
           visible(com2mic, true)
           visible(com2select, true) 
    end   
     end
         
--Test if Nav1 is On         
function nav1_snd(nav1_sndch) 
    if nav1_sndch == true then 
        visible(nav1, true)
    else 
        visible(nav1, false)
    end
  end

--Test if Nav2 is On    
function nav2_snd(nav2_sndch) 
    if nav2_sndch == true then 
        visible(nav2, true)
    else 
        visible(nav2, false)
    end
  end
 
--Test if DME is On    
function dme_snd(dme_sndch) 
    if dme_sndch == true then 
        visible(dme, true)
    else 
        visible(dme, false)
    end
  end 
--Test if ADF is On    
function adf_snd(adf_sndch) 
    if adf_sndch == true then 
        visible(adf, true)
    else 
        visible(adf, false)
    end
  end  
--Test if Mute is On    
function mute_snd(mute_sndch) 
    if mute_sndch == true then 
        visible(mute, true)
    else 
        visible(mute, false)
    end
  end  




fs2020_variable_subscribe("COM TRANSMIT:1","Bool",
                           "COM RECIEVE ALL","Bool", com_inuse)
fs2020_variable_subscribe("NAV SOUND:1","Bool", nav1_snd)    
fs2020_variable_subscribe("NAV SOUND:2","Bool", nav2_snd)    
fs2020_variable_subscribe("DME SOUND","Bool", dme_snd)  
fs2020_variable_subscribe("ADF SOUND:1","Bool", adf_snd)
fs2020_variable_subscribe("MARKER SOUND","Bool", mute_snd)                                      
                           