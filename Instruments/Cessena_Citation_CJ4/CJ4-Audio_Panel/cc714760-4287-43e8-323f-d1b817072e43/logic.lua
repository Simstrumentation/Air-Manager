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
  
##Left To Do:
    - SPKR status unknown. 	
	
##Notes:
    - COM1 and COM2 Mute not functional.
    - NAV1 and NAV2 Mute not functional.

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

-- In CJ4, COM 1 monitor is always active. Permanently set switch position to on
-- if this gets fixed in the sim, changes will be required 
rotate(com1_ind, 240, "LOG", 0.05)
rotate(com1_ind_backlight, 240, "LOG", 0.05)  

function ss_com2_mon(com2_mon)
     if com2_mon == true then
           rotate(com2_ind, 240, "LOG", 0.05)  
           rotate(com2_ind_backlight, 240, "LOG", 0.05)    
         else
            rotate(com2_ind, 0, "LOG", 0.05)
           rotate(com2_ind_backlight, 0, "LOG", 0.05)  
         end
end
fs2020_variable_subscribe("COM RECIEVE ALL", "Bool", ss_com2_mon)

--HF Select    
function callback_hf()
   fs2020_event("HF_TRANSMIT_SELECT")
   sound_play(fail_snd)
end
button_add(nil,"Buttons1.png", 401,36,41,39, callback_hf)

--PA Select    
function callback_pa()
   fs2020_event("PA_TRANSMIT_SELECT")
   sound_play(fail_snd)
end
button_add(nil,"Buttons1.png", 719,36,41,39, callback_pa)

-----------------------------------
-----BUTTONS-----
--Com1 Receive All 
function callback_mid_com1()
   --fs2020_event("COM1_TRANSMIT_SELECT")
   sound_play(fail_snd)
end
button_add(nil,nil, 86,127,55,55, callback_mid_com1)

--Com2 Receive All 
function callback_mid_com2()
   fs2020_event("COM_RECEIVE_ALL_TOGGLE")
   sound_play(fail_snd)
end
button_add(nil,nil, 184,127,55,55, callback_mid_com2)

--Nav Buttons   
function callback_nav1_btn()
   fs2020_event("RADIO_VOR1_IDENT_TOGGLE")
   sound_play(fail_snd)
end
button_add(nil,nil, 77,257,55,55, callback_nav1_btn)

function callback_nav2_btn()
   fs2020_event("RADIO_VOR2_IDENT_TOGGLE")
   sound_play(fail_snd)
end
button_add(nil,nil, 183,257,55,55, callback_nav2_btn)


--DME Button  
function callback_dme_btn()
   fs2020_event("RADIO_SELECTED_DME_IDENT_TOGGLE")
end
button_add(nil,nil, 289,255,55,55, callback_dme_btn)
--ADF Button 
function callback_adf_btn()
   fs2020_event("RADIO_ADF_IDENT_TOGGLE")
end
button_add(nil,nil, 605,257,55,55, callback_adf_btn)
--Mute Button 
function callback_mute_btn()
   fs2020_event("MARKER_SOUND_TOGGLE")
end
button_add(nil,nil, 500,257,55,55, callback_mute_btn)


----Indicators------------

--Test if Nav1 is On         
function ss_nav1_snd(nav1_sndch) 
    if nav1_sndch == true then 
       rotate(nav1_ind, 240, "LOG", 0.05)
       rotate(nav1_ind_backlight, 240, "LOG", 0.05)
    else 
       rotate(nav1_ind, 0, "LOG", 0.05)
       rotate(nav1_ind_backlight, 0, "LOG", 0.05)
    end
  end
fs2020_variable_subscribe("NAV SOUND:1","Bool", ss_nav1_snd) 
--Test if Nav2 is On    
function ss_nav2_snd(nav2_sndch) 
    if nav2_sndch == true then 
       rotate(nav2_ind, 240, "LOG", 0.05) 
       rotate(nav2_ind_backlight , 240, "LOG", 0.05)
    else 
       rotate(nav2_ind, 0, "LOG", 0.05)
       rotate(nav2_ind_backlight , 0, "LOG", 0.05)
    end
  end 
fs2020_variable_subscribe("NAV SOUND:2","Bool", ss_nav2_snd)  
--Test if DME is On    
function ss_dme_snd(dme_sndch) 
    if dme_sndch == true then 
         rotate(dme_ind, 240, "LOG", 0.05)
         rotate(dme_ind_backlight, 240, "LOG", 0.05)
    else 
       rotate(dme_ind, 0, "LOG", 0.05)
       rotate(dme_ind_backlight, 0, "LOG", 0.05)
    end
  end 
fs2020_variable_subscribe("DME SOUND","Bool", ss_dme_snd)  
--Test if ADF is On    
function ss_adf_snd(adf_sndch) 
  if adf_sndch == true then 
         rotate(adf_ind, 240, "LOG", 0.05)
         rotate(adf_ind_backlight, 240, "LOG", 0.05)
    else 
       rotate(adf_ind, 0, "LOG", 0.05)
       rotate(adf_ind_backlight, 0, "LOG", 0.05)
    end
  end  
fs2020_variable_subscribe("ADF SOUND:1","Bool", ss_adf_snd)  
--Test if Marker Mute is On    
function ss_mute_snd(mute_sndch) 
    if mute_sndch == true then 
        rotate(mkr_ind, 240, "LOG", 0.05)
        rotate(mkr_ind_backlight , 240, "LOG", 0.05)
    else 
       rotate(mkr_ind, 0, "LOG", 0.05)
       rotate(mkr_ind_backlight , 0, "LOG", 0.05)
    end
  end  
fs2020_variable_subscribe("MARKER SOUND","Bool", ss_mute_snd)
