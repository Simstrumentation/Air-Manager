--[[
******************************************************************************************
***************************Garmin GMA 1347 Audio Panel******************************
******************************************************************************************
    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation

This GMA 1347 is specifically designed for use with Microsoft Flight Simulator (2020) and 
Windows only.No compatibility with Xplane, FSX nor P3D is planned

- **v1.0** (03-02-2021)
    - Original Panel Created by Rob Verdon
    
- **v2.0** (10-22-2021) SIMSTRUMENTATION
    - New custom graphics
    - New custom sounds
    - More working events
    
- **v2.1** (01-30-2022) SIMSTRUMENTATION
    - Added SPKR button
    - Resource folder file capitials renamed for SI Store submittion  

## NOTES
- There a lot of INOP's that are inop in the sim itself. If you hear the "fail" sound that button or function is inop.
    

ATTRIBUTION:
All code, artwork and sound effects are original creations by Simstrumentation
Sharing or re-use of any code or assets is not permitted without credit to the original authors.
]]--

--***********************************************USER PROPERTY CONFIG***********************************************
-- define user selectable properties
play_sounds = user_prop_add_boolean("Play Sounds", true, "Play sounds in Air Manager")                           -- Use sounds in Air Manager    
-- end define user selectable properties

-- set user properties

-- play sound
if user_prop_get(play_sounds) then
    click_snd = sound_add("click.wav")
    dial_snd = sound_add("dial.wav")
    fail_snd = sound_add("fail.wav")    
else
    click_snd = sound_add("silence.wav")
    dial_snd = sound_add("silence.wav")
    fail_snd = sound_add("silence.wav")    
end
-- end play sound

--*********************************************END USER PROPERTY CONFIG***********************************************

--Backgroud Image before anything else
img_add_fullscreen("bg.png")

--Declare Locals
local com1mic = false
local com1select = false
local com2mic = false
local com2select = false
local nav1 = false
local nav2 = false
local dme = false
local adf = false
local hisens = false
local local_mute = false
local audio_panel_vol = nil
local LEDIndicator = "Mid_Aud_Enable.png"

-- INDICATORS
-- initial state of all indicators set to off (hidden / visibility = false)

com1mic = img_add(LEDIndicator, 51, 25,25, 13)
visible(com1mic, false)
com1select = img_add(LEDIndicator, 155,25,25, 13) 
visible(com1select , false)
com2mic = img_add(LEDIndicator, 51,117,25, 13)
visible(com2mic , false)
com2select = img_add(LEDIndicator, 155,117,25, 13)
visible(com2select , false)
com3mic = img_add(LEDIndicator, 51,199,25, 13)
visible(com3mic, false)
com3select = img_add(LEDIndicator, 155,199,25, 13)
visible(com3select, false)   
com1_2mic = img_add(LEDIndicator, 51,289,25, 13)
visible(com1_2mic, false)
tel = img_add(LEDIndicator, 155,289,25, 13)
visible(tel, false)   
pa = img_add(LEDIndicator, 51,379,25, 13)
visible(pa, false)
spkr = img_add(LEDIndicator, 155,379,25, 13)
visible(spkr, false)   
hi_sens = img_add(LEDIndicator, 155,469,25, 13)
visible(hi_sens, false)   
nav1 = img_add(LEDIndicator, 155,568,25, 13)  
visible(nav1, false)    
nav2 = img_add(LEDIndicator, 155,650,25, 13)  
visible(nav2, false)   
dme = img_add(LEDIndicator, 51,568,25, 13)
visible(dme, false)   
adf = img_add(LEDIndicator, 51,650,25, 13)
visible(adf, false)   
aux = img_add(LEDIndicator, 51,743,25, 13)
visible(aux, false)
man_seq = img_add(LEDIndicator, 51,833,25, 13)
visible(man_seq, false)
play = img_add(LEDIndicator, 155,833,25, 13)
visible(play, false)
pilot = img_add(LEDIndicator, 51,923,25, 13)
visible(pilot, false)
coplt = img_add(LEDIndicator, 155,923,25, 13)
visible(coplt, false)
mute = img_add(LEDIndicator, 51,468,25, 13)
visible(mute, false)

--BUTTONS

--Com1 TX Select    
function mid_com1mic()
   msfs_event("COM1_TRANSMIT_SELECT")
   --msfs_event("H:AS1000_MID_COM_Mic_1_Push")
   sound_play(click_snd)
end
button_add(nil,"com1mic_pressed.png", 19,41,90, 66, mid_com1mic)

--Com2 TX Select    
function mid_com2mic()
   msfs_event("COM2_TRANSMIT_SELECT")
   --msfs_event("H:AS1000_MID_COM_Mic_2_Push")
   sound_play(click_snd)
end
button_add(nil,"com2mic_pressed.png", 18,135,89, 64, mid_com2mic)

--Com3 TX Select    
function mid_com3mic()
   --currently INOP
   --msfs_event("H:AS1000_MID_COM_Mic_3_Push")
   --sound_play(click_snd)
   sound_play(fail_snd)
end
button_add(nil,"com3mic_pressed.png", 18,219,89, 64, mid_com3mic)

--Com1_2 TX Select    
function mid_com1_2mic()
   msfs_event("H:AS1000_MID_COM_Swap_1_2_Push")
   sound_play(click_snd)
end
button_add(nil,"com1-2_pressed.png", 18,311,89, 64, mid_com1_2mic)

--Com1 Receive
function mid_com1()
   msfs_event("COM_RECEIVE_ALL_TOGGLE")
   sound_play(click_snd)
end
button_add(nil,"com1_pressed.png", 122,41,90, 66, mid_com1)

--Com2 Receive
function mid_com2()
   msfs_event("COM_RECEIVE_ALL_TOGGLE")
   sound_play(click_snd)
end
button_add(nil,"com2_pressed.png", 122,135,90, 66, mid_com2)

--Com3 Receive
function mid_com3()
    --currently INOP
   --msfs_event("H:AS1000_MID_COM_3_Push")
   sound_play(fail_snd)
end
button_add(nil,"com3_pressed.png", 122,218,90, 66, mid_com3)

--Tel
function mid_tel()
    --currently INOP
   --msfs_event("H:AS1000_MID_TEL_Push")
   sound_play(fail_snd)
end
button_add(nil,"tel_pressed.png", 122,310,90, 66, mid_tel)

--PA
function pa_btn()
   --currently INOP
   --msfs_event("H:AS1000_MID_PA_Push")
   --sound_play(click_snd)
   sound_play(fail_snd)
end
button_add(nil,"pa_pressed.png", 18,400,89, 64, pa_btn)

--Spkr
function spkr_btn()
   msfs_event("K:Toggle_SPEAKER")
   sound_play(click_snd)
end
button_add(nil,"spkr_pressed.png", 122,399,89, 64, spkr_btn)

--Hi Sens
function hisens_btn()
  --msfs_event("H:AS1000_MID_HI_SENS_Push")
  
  --    msfs_variable_write("A:LIGHT CABIN:3", "BOOL", true)
  --    msfs_event("K:ELECTRICAL_CIRCUIT_TOGGLE",49, "Int",1)
    -- msfs_variable_write("A:MARKER BEACON SENSITIVITY HIGH","BOOL",false)
    
    if hisens == true then
        msfs_event("MARKER_BEACON_SENSITIVITY_HIGH",0)
    else 
        msfs_event("MARKER_BEACON_SENSITIVITY_HIGH",1)
    end

   sound_play(click_snd)
end
button_add(nil,"hisens_pressed.png", 122,489,89, 64, hisens_btn)

--Nav 1
function nav1_btn()
   msfs_event("RADIO_VOR1_IDENT_TOGGLE")
   sound_play(click_snd)
end
button_add(nil,"NAV1_pressed.png", 121,583,90, 66, nav1_btn)

--Nav 2
function nav2_btn()
   msfs_event("RADIO_VOR2_IDENT_TOGGLE")
   sound_play(click_snd)
end
button_add(nil,"NAV2_pressed.png", 121,669,90, 66, nav2_btn)

--DME Button  
function dme_btn()
   msfs_event("RADIO_SELECTED_DME_IDENT_TOGGLE")
   sound_play(click_snd)
end
button_add(nil,"DME_pressed.png", 18,583,90, 66, dme_btn)

--ADF Button 
function adf_btn()
   msfs_event("RADIO_ADF_IDENT_TOGGLE")
   sound_play(click_snd)
end
button_add(nil,"ADF_pressed.png", 17,669,90, 66, adf_btn)

--Aux Button 
function aux()
   --currently INOP
   --msfs_event("H:AS1000_MID_AUX_Push")
   --sound_play(click_snd)
   sound_play(fail_snd)
end
button_add(nil,"aux_pressed.png", 17,762,90, 66, aux)

--Man Sq
function mansq()
   --currently INOP
   --msfs_event("H:AS1000_MID_MAN_SQ_Push")
   --sound_play(click_snd)
   sound_play(fail_snd)
end
button_add(nil,"mansq_pressed.png", 17,850,90, 66, mansq)

--Play
function play()
   --currently INOP
   --msfs_event("H:AS1000_MID_Play_Push")
   --sound_play(click_snd)
   sound_play(fail_snd)
end
button_add(nil,"play_pressed.png", 120,850,90, 66, play)

--Pilot
function pilot()
   --currently INOP
   --msfs_event("H:AS1000_MID_Isolate_Pilot_Push")
   --sound_play(click_snd)
   sound_play(fail_snd)
end
button_add(nil,"pilot_pressed.png", 18,942,90, 66, pilot)

--Coplt
function coplt()
   --currently INOP
   --msfs_event("H:AS1000_MID_Isolate_Copilot_Push")
   --sound_play(click_snd)
   sound_play(fail_snd)
end
button_add(nil,"coplt_pressed.png", 120,942,90, 66, coplt)

--Mute Button 
function mute_btn()
   --msfs_event("MARKER_SOUND_TOGGLE")
      if local_mute == true then
        msfs_event("MARKER_BEACON_TEST_MUTE",0)
    else 
        msfs_event("MARKER_BEACON_TEST_MUTE",1)
    end  
   sound_play(click_snd)
end
button_add(nil,"mute_pressed.png", 17,489,90, 66, mute_btn)

-- Volume knobs

--CoPilot currently INOP
function coplt_vol(direction)
    if direction == 1 then
    --inop
    elseif direction == -1 then
    --inop
    end
    sound_play(fail_snd)
end
copilot_vol = dial_add("vol_outer.png", 59, 1081, 112, 112, coplt_vol)

function plt_vol(direction)
    if direction == 1 then
            audio_panel_vol = var_cap((audio_panel_vol + 5), 0, 100)
    elseif direction == -1 then
            audio_panel_vol = var_cap((audio_panel_vol - 5), 0, 100)
    end
    msfs_event("AUDIO_PANEL_VOLUME_SET", audio_panel_vol)
    sound_play(dial_snd)
end
pilot_vol= dial_add("vol_inner.png", 76, 1099, 78, 78, plt_vol)

-- display backup 
function display_backup()
    msfs_event("AS1000_MID_Display_Backup_Set")
    sound_play(fail_snd)
end
dsp_bkup= button_add(nil, "red_button_pressed.png", 83, 1225, 64,  65, display_backup)

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
     
     
--Test if SPKR is On    
function spkr_snd(spkr_snd) 
    if spkr_snd == true then 
        visible(spkr, true)
    else 
        visible(spkr, false)
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
  
-- Test if Hi Sen is On
--hisens_on
function hisens_on(high) 
    if high == true then 
        visible(hi_sens, true)
        hisens = true
    else 
        visible(hi_sens, false)
        hisens = false
    end
end   
    
--Test if Mute is On    
function mute_snd(mute_sndch) 
    if mute_sndch == true then 
        visible(mute, true)
        local_mute = true
    else 
        visible(mute, false)
        local_mute = false
    end    
  end  
  
function update_audio_vol(val)
    audio_panel_vol = val
end


msfs_variable_subscribe("COM TRANSMIT:1","Bool",
                           "COM RECIEVE ALL","Bool", com_inuse)
msfs_variable_subscribe("SPEAKER ACTIVE","Bool", spkr_snd)                               
msfs_variable_subscribe("NAV SOUND:1","Bool", nav1_snd)    
msfs_variable_subscribe("NAV SOUND:2","Bool", nav2_snd)    
msfs_variable_subscribe("DME SOUND","Bool", dme_snd)  
msfs_variable_subscribe("ADF SOUND:1","Bool", adf_snd)
msfs_variable_subscribe("MARKER BEACON TEST MUTE","Bool", mute_snd)     
msfs_variable_subscribe("MARKER BEACON SENSITIVITY HIGH", "Bool", hisens_on)   
msfs_variable_subscribe("AUDIO PANEL VOLUME", "Percent", update_audio_vol)                              
                           