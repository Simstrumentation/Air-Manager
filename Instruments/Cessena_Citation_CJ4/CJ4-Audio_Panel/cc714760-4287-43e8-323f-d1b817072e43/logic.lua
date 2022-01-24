--[[
******************************************************************************************
******************Cessna Citation CJ4 Audio Panel**************************************
******************************************************************************************
    
    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation
   
- **v1.0**  03-04-2021 Rob "FlightLevelRob" Verdon
    - Original panel created
- **v2.0**  09-25-2021  Joe "Crunchmeister" Gilker    
    - New graphics
    - Added extra button functionality and animations
    - Night mode 
    - Back lighting 
--*********END OF INTERNAL ALPHA TESTING****************
- **v2.0** 10-5-21 Rob "FlightLevelRob" Verdon and Joe "Crunchmeister" Gilker and Todd "Toddimus831" Lorey
    !!- Initial Public Release -!!
    - Variable renaming for clarity
    - Added backlight logic to account for battery, external power and bus volts status
- **v2.1** 01-06-22 Simstrumentation  
    - Fixed Com1 & Com2 Volume, can set 0-100 or click center to toggle.
    - Fixed Nav1 & Nav2 Volume
    - Added Marker Mute Button
    - Added SPKR Knob (On/Off)
    - Files capitials renamed for SI Store submittion  
   
##Left To Do:
	
##Notes:

******************************************************************************************    
--]]
  
--Backgroud Image before anything else
img_add_fullscreen("background.png")

img_bg_night = img_add_fullscreen("background_night.png")
-- Ambient Light Control
function ss_ambient_darkness(value)
   opacity(img_bg_night, value, "LOG", 0.04)
   opacity(com1_ind, 1-value, "LOG", 0.04)   
   opacity(com2_ind, 1-value, "LOG", 0.04)   
   opacity(hf_ind, 1-value, "LOG", 0.04)   
   opacity(pa_ind, 1-value, "LOG", 0.04)   
   opacity(nav1_ind, 1-value, "LOG", 0.04)   
   opacity(nav2_ind, 1-value, "LOG", 0.04)   
   opacity(dme_ind, 1-value, "LOG", 0.04)   
   opacity(dme2_ind, 1-value, "LOG", 0.04)   
   opacity(adf_ind, 1-value, "LOG", 0.04)   
   opacity(mkr_ind, 1-value, "LOG", 0.04)
   opacity(mkrMute_ind, 1-value, "LOG", 0.04)   
   opacity(vox_ind, 1-value, "LOG", 0.04)
   opacity(spkr_ind, 1-value, "LOG", 0.04)
end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)

--=======Back  Lighting============
img_labels_backlight = img_add_fullscreen("backlight.png")

function ss_backlighting(value, power, extpower, busvolts)
    value = var_round(value,2)
    
    if value == 1.0 or (power == false and extpower == false and busvolts < 5) then 
        opacity(img_labels_backlight, 0, "LOG", 0.04)  
        opacity(com1_ind_backlight,0, "LOG", 0.04) 
        opacity(com2_ind_backlight,0, "LOG", 0.04) 
        opacity(hf_ind_backlight,0, "LOG", 0.04) 
        opacity(pa_ind_backlight,0, "LOG", 0.04) 
        opacity(nav1_ind_backlight,0, "LOG", 0.04) 
        opacity(nav2_ind_backlight,0, "LOG", 0.04) 
        opacity(dme_ind_backlight,0, "LOG", 0.04) 
        opacity(dme2_ind_backlight,0, "LOG", 0.04) 
        opacity(adf_ind_backlight,0, "LOG", 0.04) 
        opacity(mkr_ind_backlight,0, "LOG", 0.04) 
        opacity(mkrMute_ind_backlight,0, "LOG", 0.04)         
        opacity(vox_ind_backlight,0, "LOG", 0.04) 
        opacity(spkr_ind_backlight,0, "LOG", 0.04)               
    else
        opacity(img_labels_backlight, ((value/2)+0.5), "LOG", 0.04)
        opacity(com1_ind_backlight,((value/2)+0.5), "LOG", 0.04)
        opacity(com2_ind_backlight,((value/2)+0.5), "LOG", 0.04)
        opacity(hf_ind_backlight,((value/2)+0.5), "LOG", 0.04)
        opacity(pa_ind_backlight,((value/2)+0.5), "LOG", 0.04)
        opacity(nav1_ind_backlight,((value/2)+0.5), "LOG", 0.04)
        opacity(nav2_ind_backlight,((value/2)+0.5), "LOG", 0.04)
        opacity(dme_ind_backlight,((value/2)+0.5), "LOG", 0.04)
        opacity(dme2_ind_backlight,((value/2)+0.5), "LOG", 0.04)
        opacity(adf_ind_backlight,((value/2)+0.5), "LOG", 0.04)
        opacity(mkr_ind_backlight,((value/2)+0.5), "LOG", 0.04)
        opacity(mkrMute_ind_backlight,((value/2)+0.5), "LOG", 0.04)        
        opacity(vox_ind_backlight,((value/2)+0.5), "LOG", 0.04)
        opacity(spkr_ind_backlight,((value/2)+0.5), "LOG", 0.04)
        end
end
fs2020_variable_subscribe("A:LIGHT POTENTIOMETER:3", "Number",
                          "ELECTRICAL MASTER BATTERY","Bool",
                          "EXTERNAL POWER ON:1", "Bool",
                          "ELECTRICAL MAIN BUS VOLTAGE", "Volts", ss_backlighting)
						  
---Sounds
click_snd = sound_add("click.wav")
fail_snd = sound_add("beepfail.wav")
dial_snd = sound_add("dial.wav")

--COM Channel Indicator
img_com1_light = img_add("COM_Light.png", 97,11,20,21)
img_com2_light = img_add("COM_Light.png", 200,11,20,21)


----ADD KNOWB INDICATOR GRAPHICS
--COM 1 
com1_ind = img_add("smallknob_off.png", 85,127,55,55)
com1_ind_backlight = img_add("smallknob_off_backlight.png", 85,127,55,55)

--COM 2
com2_ind = img_add("smallknob_off.png", 182,127,55,55)
com2_ind_backlight = img_add("smallknob_off_backlight.png", 182,127,55,55)

--HF
hf_ind = img_add("smallknob_off.png", 393,127,55,55)
hf_ind_backlight = img_add("smallknob_off_backlight.png", 393,127,55,55)

--PA
pa_ind = img_add("smallknob_off.png", 713,127,55,55)
pa_ind_backlight = img_add("smallknob_off_backlight.png", 713,127,55,55)

--NAV 1
nav1_ind = img_add("smallknob_off.png", 77,257,55,55)
nav1_ind_backlight = img_add("smallknob_off_backlight.png", 77,257,55,55)

--NAV 2
nav2_ind = img_add("smallknob_off.png", 182,257,55,55)
nav2_ind_backlight = img_add("smallknob_off_backlight.png", 182,257,55,55)

--DME 1
dme_ind = img_add("smallknob_off.png", 289,257,55,55)
dme_ind_backlight = img_add("smallknob_off_backlight.png", 289,257,55,55)

--DME 2
dme2_ind = img_add("smallknob_off.png", 394,257,55,55)
dme2_ind_backlight = img_add("smallknob_off_backlight.png", 394,257,55,55)

-- ADF
adf_ind = img_add("smallknob_off.png", 606,257,55,55)
adf_ind_backlight = img_add("smallknob_off_backlight.png", 606,257,55,55)

--MKR
mkr_ind = img_add("smallknob_off.png", 498,257,55,55)
mkr_ind_backlight = img_add("smallknob_off_backlight.png", 498,257,55,55)

--MKRMute
mkrMute_ind = img_add("mute.png", 498,387,55,55)
mkrMute_ind_backlight = img_add("mute_night.png", 498,387,55,55)

--VOX
vox_ind = img_add("smallknob_off.png", 394,385,55,55)
vox_ind_backlight = img_add("smallknob_off_backlight.png", 394,385,55,55)

--SPKR
spkr_ind = img_add("smallknob_off.png", 606,385,55,55)
spkr_ind_backlight = img_add("smallknob_off_backlight.png", 606,385,55,55) 

--------------------------------------------------------------------------------------------

--Com1 TX Select    
function callback_com1()
   fs2020_event("COM1_TRANSMIT_SELECT")
   sound_play(click_snd)
end
 button_add(nil,nil, 87,36,41,39, callback_com1)
--Com2 TX Select    
function callback_com2()
   fs2020_event("COM2_TRANSMIT_SELECT")
   sound_play(click_snd)
end
button_add(nil,nil, 191,36,41,39, callback_com2)

--See Which Com TX In Use
function ss_comtx_inuse(com1active)
        if com1active == true then
           --indicator lights          
           visible(img_com1_light, true)
           visible(img_com2_light, false)

         else
           --indicator lights
           visible(img_com2_light, true)
           visible(img_com1_light, false)
         end
end
fs2020_variable_subscribe("COM TRANSMIT:1","Bool", ss_comtx_inuse)

function ss_com1_vol(value)
           value = var_round(value,2)
           rotate(com1_ind, value*2.5, "LOG", 0.1)  
           rotate(com1_ind_backlight, value*2.5, "LOG", 0.1)    
           switch_set_position(sw_com1_vol, value/5)
end
fs2020_variable_subscribe("A:COM VOLUME:1", "Percent", ss_com1_vol) 

function ss_com2_vol(value)
           value = var_round(value,2)
           rotate(com2_ind, value*2.5, "LOG", 0.1)  
           rotate(com2_ind_backlight, value*2.5, "LOG", 0.1)    
            switch_set_position(sw_com2_vol, value/5)
end
fs2020_variable_subscribe("A:COM VOLUME:2", "Percent", ss_com2_vol)

--NAV VOLUME
function ss_nav1_vol(value)
           value = var_round(value,2)
           rotate(nav1_ind, value*2.5, "LOG", 0.1)  
           rotate(nav1_ind_backlight, value*2.5, "LOG", 0.1)    
           switch_set_position(sw_nav1_vol, value/5)
end
fs2020_variable_subscribe("A:NAV VOLUME:1", "Percent", ss_nav1_vol) 

function ss_nav2_vol(value)
           value = var_round(value,2)
           rotate(nav2_ind, value*2.5, "LOG", 0.1)  
           rotate(nav2_ind_backlight, value*2.5, "LOG", 0.1)    
            switch_set_position(sw_nav2_vol, value/5)
end
fs2020_variable_subscribe("A:NAV VOLUME:2", "Percent", ss_nav2_vol)

--HF Select    
function callback_hf()
   fs2020_event("HF_TRANSMIT_SELECT")
   sound_play(fail_snd)
end
button_add(nil,"button.png", 401,36,41,39, callback_hf)

--PA Select    
function callback_pa()
   fs2020_event("PA_TRANSMIT_SELECT")
   sound_play(fail_snd)
end
button_add(nil,"button.png", 719,36,41,39, callback_pa)

-----------------------------------
-----BUTTONS-----
--Com1 Receive
function callback_com1_vol(position,direction)
    if direction == 1 then
        fs2020_event("COM1_VOLUME_SET", var_cap(((position*5)+5),0,100))
    else
        fs2020_event("COM1_VOLUME_SET", var_cap(((position*5)-5),0,100))
    end
end
sw_com1_vol=switch_add(nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil, 86,127,55,55, callback_com1_vol)

function callback_com1_vol_click()
    position = switch_get_position(sw_com1_vol)
    if position <= 0 then
        fs2020_event("COM1_VOLUME_SET",100)
        sound_play(click_snd)
    else 
        fs2020_event("COM1_VOLUME_SET",0)
        sound_play(click_snd)
     end
end
button_add(nil,nil, 92,137,40,40,callback_com1_vol_click)
--Com2 Receive 
function callback_com2_vol(position,direction)
    if direction == 1 then
        fs2020_event("COM2_VOLUME_SET", var_cap(((position*5)+5),0,100))
    else
        fs2020_event("COM2_VOLUME_SET", var_cap(((position*5)-5),0,100))
    end
end
sw_com2_vol=switch_add(nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil, 180,127,55,55, callback_com2_vol)
function callback_com2_vol_click()
    position = switch_get_position(sw_com2_vol)
    if position <= 0 then
        fs2020_event("COM2_VOLUME_SET",100)
        sound_play(click_snd)
    else 
        fs2020_event("COM2_VOLUME_SET",0)
        sound_play(click_snd)
     end
end
button_add(nil,nil, 190,137,40,40,callback_com2_vol_click)

--Nav Volumes 
function callback_nav1_vol(position,direction)
    if direction == 1 then
        fs2020_event("NAV1_VOLUME_SET_EX1", var_cap(((position*5)+5),0,100))
    else
        fs2020_event("NAV1_VOLUME_SET_EX1", var_cap(((position*5)-5),0,100))
    end
end
sw_nav1_vol=switch_add(nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil, 77,257,55,55, callback_nav1_vol)

function callback_nav2_vol(position,direction)
    if direction == 1 then
        fs2020_event("NAV2_VOLUME_SET_EX1", var_cap(((position*5)+5),0,100))
    else
        fs2020_event("NAV2_VOLUME_SET_EX1", var_cap(((position*5)-5),0,100))
    end
end
sw_nav2_vol=switch_add(nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil, 183,257,55,55, callback_nav2_vol)

--DME1 Button  
function callback_dme1_btn()
   fs2020_event("RADIO_DME1_IDENT_TOGGLE")
end
button_add(nil,nil, 289,255,55,55, callback_dme1_btn)
--DME2 Button  
function callback_dme2_btn()
   fs2020_event("RADIO_DME2_IDENT_TOGGLE")
end
button_add(nil,nil, 389,255,55,55, callback_dme2_btn)
--ADF Button 
function callback_adf_btn()
   fs2020_event("RADIO_ADF_IDENT_TOGGLE")
end
button_add(nil,nil, 605,257,55,55, callback_adf_btn)
--Marker Button 
function callback_marker_btn()
   fs2020_event("MARKER_SOUND_TOGGLE")
end
button_add(nil,nil, 500,257,55,55, callback_marker_btn)
--Mute Button 
function callback_markermute_btn(position)
   if position == 1 then
       fs2020_event("MARKER_BEACON_TEST_MUTE",1)
   else 
       fs2020_event("MARKER_BEACON_TEST_MUTE",0)
    end
end
sw_markermute = switch_add(nil,nil, 500,380,55,55, callback_markermute_btn)
--Speaker Button 
function callback_speaker_btn()
   fs2020_event("TOGGLE_SPEAKER")
end
button_add(nil,nil, 600,387,65,65, callback_speaker_btn)


--Test if DME1 is On    
function ss_dme_snd(dme_sndch) 
    if dme_sndch == true then 
         rotate(dme_ind, 240, "LOG", 0.1)
         rotate(dme_ind_backlight, 240, "LOG", 0.1)
    else 
       rotate(dme_ind, 0, "LOG", 0.1)
       rotate(dme_ind_backlight, 0, "LOG", 0.1)
    end
  end 
fs2020_variable_subscribe("DME SOUND:1","Bool", ss_dme_snd)  
--Test if DME2 is On    
function ss_dme2_snd(dme_sndch) 
    if dme_sndch == true then 
         rotate(dme2_ind, 240, "LOG", 0.1)
         rotate(dme2_ind_backlight, 240, "LOG", 0.1)
    else 
       rotate(dme2_ind, 0, "LOG", 0.1)
       rotate(dme2_ind_backlight, 0, "LOG", 0.1)
    end
  end 
fs2020_variable_subscribe("DME SOUND:2","Bool", ss_dme2_snd)  
--Test if ADF is On    
function ss_adf_snd(adf_sndch) 
  if adf_sndch == true then 
         rotate(adf_ind, 240, "LOG", 0.1)
         rotate(adf_ind_backlight, 240, "LOG", 0.1)
    else 
       rotate(adf_ind, 0, "LOG", 0.1)
       rotate(adf_ind_backlight, 0, "LOG", 0.1)
    end
  end  
fs2020_variable_subscribe("ADF SOUND:1","Bool", ss_adf_snd)  
--Test Marker Volume    
function ss_marker_snd(marker_sndch) 
    if marker_sndch == true then 
        rotate(mkr_ind, 240, "LOG", 0.1)
        rotate(mkr_ind_backlight , 240, "LOG", 0.1)
    else 
       rotate(mkr_ind, 0, "LOG", 0.1)
       rotate(mkr_ind_backlight , 0, "LOG", 0.1)
    end
  end  
fs2020_variable_subscribe("MARKER SOUND","Bool", ss_marker_snd)
--Test Marker Mute    
function ss_mute_snd(mute_sndch) 
    if mute_sndch == true then 
        visible(mkrMute_ind, false)
        visible(mkrMute_ind_backlight, true)
        switch_set_position(sw_markermute, 0)
    else 
        visible(mkrMute_ind, true)
        visible(mkrMute_ind_backlight , false)
        switch_set_position(sw_markermute, 1)
    end
  end  
fs2020_variable_subscribe("MARKER BEACON TEST MUTE", "Bool", ss_mute_snd) 
--Test if SPKR is On    
function ss_spkr_snd(position) 
  if position == true then 
         rotate(spkr_ind, 240, "LOG", 0.1)
         rotate(spkr_ind_backlight, 240, "LOG", 0.1)
    else 
       rotate(spkr_ind, 0, "LOG", 0.1)
       rotate(spkr_ind_backlight, 0, "LOG", 0.1)
    end
  end  
fs2020_variable_subscribe("SPEAKER ACTIVE","Bool", ss_spkr_snd)  
