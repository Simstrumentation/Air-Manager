--[[
******************************************************************************************
******************Bombardier CRJ Pedestal-Audio Control Panel************************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation

- **v1.0** 09-27-2022
    - Original Panel Created


##Left To Do:
    - RTIC Switch is currently a 3 position knob. Should probably change it to touch zones instead.
	
##Notes:
    - If using a knobster, the outer knob will turn the volume dials and the inner knob will toggle the mute. The knobster push button doesn't do anything. This is because the mute toggle is a switch and not a button.
    - This instrument has a user prop to control either the Pilot, CoPilot or Lower unit.  
        
--]]

img_add_fullscreen("background.png")
img_bg_night = img_add_fullscreen("background_night.png")

--=======Back  Lighting============
img_labels_backlight = img_add_fullscreen("backlighting.png")

function ss_backlighting(value, pwr)
    value = var_round(value*10,2) --value*0.038 if using Lvar L:ASCRJ_INTL_OVHD
    if value == 0.0 or (pwr == false ) then 
        opacity(img_labels_backlight, 0, "LOG", 0.04)
    else
        opacity(img_labels_backlight, (value), "LOG", 0.04) 
    end
end
msfs_variable_subscribe("A:Light Potentiometer:4", "Number",
                                              "A:CIRCUIT GENERAL PANEL ON","Bool", ss_backlighting)
                                              
-----------------------------------------------------------------
-- Ambient Light Control
function ss_ambient_darkness(value)
    opacity(img_bg_night, value, "LOG", 0.04)
    opacity(img_knob_selection_night, value, "LOG", 0.04)   
    opacity(img_dial_vhf1_night, value, "LOG", 0.04)    
    opacity(img_dial_vhf2_night, value, "LOG", 0.04)        
    opacity(img_dial_intsvc_night, value, "LOG", 0.04)      
    opacity(img_dial_dme1_night, value, "LOG", 0.04)    
    opacity(img_dial_dme2_night, value, "LOG", 0.04) 
    opacity(img_dial_adf1_night, value, "LOG", 0.04)    
    opacity(img_dial_adf2_night, value, "LOG", 0.04)     
    opacity(img_dial_nav1_night, value, "LOG", 0.04) 
    opacity(img_dial_nav2_night, value, "LOG", 0.04)    
    opacity(img_dial_mkr1_night, value, "LOG", 0.04) 
    opacity(img_dial_mkr2_night, value, "LOG", 0.04)      
    opacity(img_dial_spkr_night, value, "LOG", 0.04)     
    opacity(img_sw_rtic_up_night, value, "LOG", 0.04) 
    opacity(img_sw_rtic_mid_night, value, "LOG", 0.04)      
    opacity(img_sw_rtic_dn_night, value, "LOG", 0.04)        
    opacity(img_sw_voiceboth_up_night, value, "LOG", 0.04)      
    opacity(img_sw_voiceboth_dn_night, value, "LOG", 0.04)    
    opacity(img_sw_maskboom_up_night, value, "LOG", 0.04)      
    opacity(img_sw_maskboom_dn_night, value, "LOG", 0.04)   
    opacity(img_sw_emer_up_night , value, "LOG", 0.04)      
    opacity(img_sw_emer_dn_night , value, "LOG", 0.04)        

end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)
-----------------------------------------------------------------



img_dial_audioin ="round_bt.png"
img_dial_audioin_night ="round_bt_night.png"

--User Prop to set Control Panel
prop_ControlPanel = user_prop_add_enum("Audio Panel", "Pilot,CoPilot,Lower", "Pilot", "You can choose to make this instrument Pilot Side, CoPilot Side or Lower Panel")
if user_prop_get(prop_ControlPanel) == "Pilot" then
    controlside = "L:ASCRJ_AUDIO1_"
    elseif user_prop_get(prop_ControlPanel) == "CoPilot" then
    controlside = "L:ASCRJ_AUDIO2_"
    elseif user_prop_get(prop_ControlPanel) == "Lower" then 
    controlside = "L:ASCRJ_AUDIO3_"       
end   

-------------------------------------------------------------------
img_knob_selection = img_add("knob_square.png", 148,105,60,60) 
img_knob_selection_night = img_add("knob_square_night.png", 148,105,60,60) 

img_dial_vhf1 = img_add(img_dial_audioin, 84,24,36,36) 
img_dial_vhf1_night = img_add(img_dial_audioin_night, 84,24,36,36)

img_dial_vhf2 = img_add(img_dial_audioin, 152,28,36,36) 
img_dial_vhf2_night = img_add(img_dial_audioin_night, 152,28,36,36)

img_dial_intsvc = img_add(img_dial_audioin, 300,47,36,36) 
img_dial_intsvc_night = img_add(img_dial_audioin_night, 300,47,36,36) 

img_dial_dme1 = img_add(img_dial_audioin, 20,112,36,36) 
img_dial_dme1_night = img_add(img_dial_audioin_night, 20,112,36,36)

img_dial_dme2 = img_add(img_dial_audioin, 83,112,36,36) 
img_dial_dme2_night = img_add(img_dial_audioin_night, 83,112,36,36)

img_dial_adf1 = img_add(img_dial_audioin, 237,112,36,36) 
img_dial_adf1_night = img_add(img_dial_audioin_night, 237,112,36,36)

img_dial_adf2 = img_add(img_dial_audioin, 294,112,36,36) 
img_dial_adf2_night = img_add(img_dial_audioin_night, 294,112,36,36)

img_dial_nav1 = img_add(img_dial_audioin, 20,172,36,36) 
img_dial_nav1_night = img_add(img_dial_audioin_night, 20,172,36,36)

img_dial_nav2 = img_add(img_dial_audioin, 20,172,36,36) 
img_dial_nav2_night = img_add(img_dial_audioin_night, 20,172,36,36)

img_dial_mkr1 = img_add(img_dial_audioin, 237,172,36,36) 
img_dial_mkr1_night = img_add(img_dial_audioin_night, 237,172,36,36)

img_dial_mkr2 = img_add(img_dial_audioin, 294,172,36,36) 
img_dial_mkr2_night = img_add(img_dial_audioin_night, 294,172,36,36)

img_dial_spkr = img_add(img_dial_audioin, 181,206,36,36) 
img_dial_spkr_night = img_add(img_dial_audioin_night, 181,206,36,36)

img_sw_rtic_up = img_add("toggle_up.png", 54,206,26,54) visible(img_sw_rtic_up, false)
img_sw_rtic_mid = img_add("toggle_mid.png", 54,206,26,54) visible(img_sw_rtic_mid, false)
img_sw_rtic_dn = img_add("toggle_down.png", 54,206,26,54) visible(img_sw_rtic_dn, false)
img_sw_rtic_up_night = img_add("toggle_up_night.png", 54,206,26,54) visible(img_sw_rtic_up_night, false)
img_sw_rtic_mid_night = img_add("toggle_mid_night.png", 54,206,26,54) visible(img_sw_rtic_mid_night, false)
img_sw_rtic_dn_night = img_add("toggle_down_night.png", 54,206,26,54) visible(img_sw_rtic_dn_night, false)

img_sw_voiceboth_up = img_add("toggle_up.png", 140,206,26,54) visible(img_sw_voiceboth_up, false)
img_sw_voiceboth_dn = img_add("toggle_down.png", 140,206,26,54) visible(img_sw_voiceboth_dn, false)
img_sw_voiceboth_up_night = img_add("toggle_up_night.png", 140,206,26,54) visible(img_sw_voiceboth_up_night, false)
img_sw_voiceboth_dn_night = img_add("toggle_down_night.png", 140,206,26,54) visible(img_sw_voiceboth_dn_night, false)

img_sw_maskboom_up = img_add("toggle_up.png", 244,206,26,54) visible(img_sw_maskboom_up, false)
img_sw_maskboom_dn = img_add("toggle_down.png", 244,206,26,54) visible(img_sw_maskboom_dn, false)
img_sw_maskboom_up_night = img_add("toggle_up_night.png", 244,206,26,54) visible(img_sw_maskboom_up_night, false)
img_sw_maskboom_dn_night = img_add("toggle_down_night.png", 244,206,26,54) visible(img_sw_maskboom_dn_night, false)

img_sw_emer_up = img_add("slvr_switch_up.png", 302,212,22,45) visible(img_sw_emer_up, false)
img_sw_emer_dn = img_add("slvr_switch_dn.png", 302,212,22,45) visible(img_sw_emer_dn, false)
img_sw_emer_up_night = img_add("slvr_switch_up_night.png", 302,212,22,45) visible(img_sw_emer_up_night, false)
img_sw_emer_dn_night = img_add("slvr_switch_dn_night.png", 302,212,22,45) visible(img_sw_emer_dn_night, false)

--Selection Knob
msfs_variable_subscribe(controlside.."PA_SEL", "Number",  
        function (state)
            switch_set_position(sw_knob_selection, state)
             rotate(img_knob_selection, (state *50)-50, "LOG", 0.04)
             rotate(img_knob_selection_night, (state *50)-50, "LOG", 0.04)
        end) 
function cb_knob_sel(position,direction) 
    if direction == 1 then msfs_variable_write(controlside.."PA_SEL", "Number", position+1 ) 
    else msfs_variable_write(controlside.."PA_SEL", "Number", position-1 )
    end 
end
sw_knob_selection = switch_add(nil, nil, nil, nil, 148,105,60,60, cb_knob_sel) 
---VHF1
local local_vhf1_vol = 0
msfs_variable_subscribe(controlside.."VHF1_VOL", "Number", controlside.."VHF1_VOL_Push", "Number",     
        function (vol,state)
            if state == 1 then move(group_vhf1, 84,24,nil,nil, "LINEAR", 0.1) --84,24
                else move(group_vhf1, 87,28,nil,nil, "LINEAR", 0.1) --87,29
            end            
            switch_set_position(sw_vhf1_vol_push, state)
            local_vhf1_vol = vol
             rotate(img_dial_vhf1, local_vhf1_vol *25, "LOG", 0.04)
             rotate(img_dial_vhf1_night, local_vhf1_vol *25, "LOG", 0.04)
        end) 

function cb_vhf1_vol(direction) 
    if direction == 1 then msfs_variable_write(controlside.."VHF1_VOL", "Number", var_cap(local_vhf1_vol +1,0,10) ) 
    else msfs_variable_write(controlside.."VHF1_VOL", "Number", var_cap(local_vhf1_vol -1,0,10) )
    end 
end
dial_vhf1_vol = dial_add(nil, 85,26,40,40, cb_vhf1_vol)

function cb_vhf1_push(state) 
    if state == 1 then msfs_variable_write(controlside.."VHF1_VOL_PUSH", "Number", 0 ) 
    else msfs_variable_write(controlside.."VHF1_VOL_PUSH", "Number", 1 )
    end 
end
sw_vhf1_vol_push = switch_add(nil, nil, 98,40,15,15, cb_vhf1_push)

group_vhf1 = group_add(img_dial_vhf1,img_dial_vhf1_night)

---VHF2
local local_vhf2_vol = 0
msfs_variable_subscribe(controlside.."VHF2_VOL", "Number", controlside.."VHF2_VOL_Push", "Number",     
        function (vol,state)
            if state == 1 then move(group_vhf2, 157,24,nil,nil, "LINEAR", 0.1)
            else move(group_vhf2, 160,28,nil,nil, "LINEAR", 0.1)
            end            
            switch_set_position(sw_vhf2_vol_push, state)
            local_vhf2_vol = vol
             rotate(img_dial_vhf2, local_vhf2_vol *25, "LOG", 0.04)
             rotate(img_dial_vhf2_night, local_vhf2_vol *25, "LOG", 0.04)
        end)

function cb_vhf2_vol(direction) 
    if direction == 1 then msfs_variable_write(controlside.."VHF2_VOL", "Number", var_cap(local_vhf2_vol +1,0,10) ) 
    else msfs_variable_write(controlside.."VHF2_VOL", "Number", var_cap(local_vhf2_vol -1,0,10) )
    end 
end
dial_vhf2_vol = dial_add(nil, 155,26,40,40, cb_vhf2_vol)

function cb_vhf2_push(state) 
    if state == 1 then msfs_variable_write(controlside.."VHF2_VOL_PUSH", "Number", 0 ) 
    else msfs_variable_write(controlside.."VHF2_VOL_PUSH", "Number", 1 )
    end 
end
sw_vhf2_vol_push = switch_add(nil, nil, 168,36,15,15, cb_vhf2_push)

group_vhf2 = group_add(img_dial_vhf2,img_dial_vhf2_night)
                
---INTSVC
local local_intsvc_vol = 0
msfs_variable_subscribe(controlside.."INTSVC_VOL", "Number", controlside.."INTSVC_VOL_Push", "Number",     
        function (vol,state)
            if state == 1 then move(group_intsvc, 230,24,nil,nil, "LINEAR", 0.1) --84,24
                else move(group_intsvc, 233,28,nil,nil, "LINEAR", 0.1) --87,29
            end            
            switch_set_position(sw_intsvc_vol_push, state)
            local_intsvc_vol = vol
             rotate(img_dial_intsvc, local_intsvc_vol *25, "LOG", 0.04)
             rotate(img_dial_intsvc_night, local_intsvc_vol *25, "LOG", 0.04)
        end)

function cb_intsvc_vol(direction) 
    if direction == 1 then msfs_variable_write(controlside.."INTSVC_VOL", "Number", var_cap(local_intsvc_vol +1,0,10) ) 
    else msfs_variable_write(controlside.."INTSVC_VOL", "Number", var_cap(local_intsvc_vol -1,0,10) )
    end 
end
dial_intsvc_vol = dial_add(nil, 230,28,40,40, cb_intsvc_vol)

function cb_intsvc_push(state) 
    if state == 1 then msfs_variable_write(controlside.."INTSVC_VOL_PUSH", "Number", 0 ) 
    else msfs_variable_write(controlside.."INTSVC_VOL_PUSH", "Number", 1 )
    end 
end
sw_intsvc_vol_push = switch_add(nil, nil, 238,40,15,15, cb_intsvc_push)

group_intsvc = group_add(img_dial_intsvc,img_dial_intsvc_night)


---DME1 
local local_dme1_vol = 0
msfs_variable_subscribe(controlside.."DME1_VOL", "Number", controlside.."DME1_VOL_Push", "Number",     
        function (vol,state)
            if state == 1 then move(group_dme1, 23,108,nil,nil, "LINEAR", 0.1) --84,24
                else move(group_dme1, 26,112,nil,nil, "LINEAR", 0.1) --87,29
            end            
            switch_set_position(sw_dme1_vol_push, state)
            local_dme1_vol = vol
             rotate(img_dial_dme1, local_dme1_vol *25, "LOG", 0.04)
             rotate(img_dial_dme1_night, local_dme1_vol *25, "LOG", 0.04)
        end) 

function cb_dme1_vol(direction) 
    if direction == 1 then msfs_variable_write(controlside.."DME1_VOL", "Number", var_cap(local_dme1_vol +1,0,10) ) 
    else msfs_variable_write(controlside.."DME1_VOL", "Number", var_cap(local_dme1_vol -1,0,10) )
    end 
end
dial_dme1_vol = dial_add(nil, 23,108,40,40, cb_dme1_vol)

function cb_dme1_push(state) 
    if state == 1 then msfs_variable_write(controlside.."DME1_VOL_PUSH", "Number", 0 ) 
    else msfs_variable_write(controlside.."DME1_VOL_PUSH", "Number", 1 )
    end 
end
sw_dme1_vol_push = switch_add(nil, nil, 36,122,15,15, cb_dme1_push)

group_dme1 = group_add(img_dial_dme1,img_dial_dme1_night)

---DME2
local local_dme2_vol = 0
msfs_variable_subscribe(controlside.."DME2_VOL", "Number", controlside.."DME2_VOL_Push", "Number",     
        function (vol,state)
            if state == 1 then move(group_dme2, 80,108,nil,nil, "LINEAR", 0.1) --84,24
                else move(group_dme2, 83,112,nil,nil, "LINEAR", 0.1) --87,29
            end            
            switch_set_position(sw_dme2_vol_push, state)
            local_dme2_vol = vol
             rotate(img_dial_dme2, local_dme2_vol *25, "LOG", 0.04)
             rotate(img_dial_dme2_night, local_dme2_vol *25, "LOG", 0.04)
        end) 

function cb_dme2_vol(direction) 
    if direction == 1 then msfs_variable_write(controlside.."DME2_VOL", "Number", var_cap(local_dme2_vol +1,0,10) ) 
    else msfs_variable_write(controlside.."DME2_VOL", "Number", var_cap(local_dme2_vol -1,0,10) )
    end 
end
dial_dme2_vol = dial_add(nil, 83,108,40,40, cb_dme2_vol)

function cb_dme2_push(state) 
    if state == 1 then msfs_variable_write(controlside.."DME2_VOL_PUSH", "Number", 0 ) 
    else msfs_variable_write(controlside.."DME2_VOL_PUSH", "Number", 1 )
    end 
end
sw_dme2_vol_push = switch_add(nil, nil, 94,122,15,15, cb_dme2_push)

group_dme2 = group_add(img_dial_dme2,img_dial_dme2_night)

---ADF1
local local_adf1_vol = 0
msfs_variable_subscribe(controlside.."ADF1_VOL", "Number", controlside.."ADF1_VOL_Push", "Number",     
        function (vol,state)
            if state == 1 then move(group_adf1, 234,108,nil,nil, "LINEAR", 0.1) --84,24
                else move(group_adf1, 237,112,nil,nil, "LINEAR", 0.1) --87,29
            end            
            switch_set_position(sw_adf1_vol_push, state)
            local_adf1_vol = vol
             rotate(img_dial_adf1, local_adf1_vol *25, "LOG", 0.04)
             rotate(img_dial_adf1_night, local_adf1_vol *25, "LOG", 0.04)
        end) 

function cb_adf1_vol(direction) 
    if direction == 1 then msfs_variable_write(controlside.."ADF1_VOL", "Number", var_cap(local_adf1_vol +1,0,10) ) 
    else msfs_variable_write(controlside.."ADF1_VOL", "Number", var_cap(local_adf1_vol -1,0,10) )
    end 
end
dial_adf1_vol = dial_add(nil, 230,108,40,40, cb_adf1_vol)

function cb_adf1_push(state) 
    if state == 1 then msfs_variable_write(controlside.."ADF1_VOL_PUSH", "Number", 0 ) 
    else msfs_variable_write(controlside.."ADF1_VOL_PUSH", "Number", 1 )
    end 
end
sw_adf1_vol_push = switch_add(nil, nil, 246,122,15,15, cb_adf1_push)

group_adf1 = group_add(img_dial_adf1,img_dial_adf1_night)

---ADF2
local local_adf2_vol = 0
msfs_variable_subscribe(controlside.."ADF2_VOL", "Number", controlside.."ADF2_VOL_Push", "Number",     
        function (vol,state)
            if state == 1 then move(group_adf2, 291,108,nil,nil, "LINEAR", 0.1) --84,24
                else move(group_adf2, 294,112,nil,nil, "LINEAR", 0.1) --87,29
            end            
            switch_set_position(sw_adf2_vol_push, state)
            local_adf2_vol = vol
             rotate(img_dial_adf2, local_adf2_vol *25, "LOG", 0.04)
             rotate(img_dial_adf2_night, local_adf2_vol *25, "LOG", 0.04)
        end) 

function cb_adf2_vol(direction) 
    if direction == 1 then msfs_variable_write(controlside.."ADF2_VOL", "Number", var_cap(local_adf2_vol +1,0,10) ) 
    else msfs_variable_write(controlside.."ADF2_VOL", "Number", var_cap(local_adf2_vol -1,0,10) )
    end 
end
dial_adf2_vol = dial_add(nil, 290,108,40,40, cb_adf2_vol)

function cb_adf2_push(state) 
    if state == 1 then msfs_variable_write(controlside.."ADF2_VOL_PUSH", "Number", 0 ) 
    else msfs_variable_write(controlside.."ADF2_VOL_PUSH", "Number", 1 )
    end 
end
sw_adf2_vol_push = switch_add(nil, nil, 305,122,15,15, cb_adf2_push)

group_adf2 = group_add(img_dial_adf2,img_dial_adf2_night)

---NAV1
local local_nav1_vol = 0
msfs_variable_subscribe(controlside.."NAV1_VOL", "Number", controlside.."NAV1_VOL_Push", "Number",     
        function (vol,state)
            if state == 1 then move(group_nav1, 23,168,nil,nil, "LINEAR", 0.1) --84,24
                else move(group_nav1, 26,172,nil,nil, "LINEAR", 0.1) --87,29
            end            
            switch_set_position(sw_nav1_vol_push, state)
            local_nav1_vol = vol
             rotate(img_dial_nav1, local_nav1_vol *25, "LOG", 0.04)
             rotate(img_dial_nav1_night, local_nav1_vol *25, "LOG", 0.04)
        end) 

function cb_nav1_vol(direction) 
    if direction == 1 then msfs_variable_write(controlside.."NAV1_VOL", "Number", var_cap(local_nav1_vol +1,0,10) ) 
    else msfs_variable_write(controlside.."NAV1_VOL", "Number", var_cap(local_nav1_vol -1,0,10) )
    end 
end
dial_nav1_vol = dial_add(nil, 25,170,40,40, cb_nav1_vol)

function cb_nav1_push(state) 
    if state == 1 then msfs_variable_write(controlside.."NAV1_VOL_PUSH", "Number", 0 ) 
    else msfs_variable_write(controlside.."NAV1_VOL_PUSH", "Number", 1 )
    end 
end
sw_nav1_vol_push = switch_add(nil, nil, 36,182,15,15, cb_nav1_push)

group_nav1 = group_add(img_dial_nav1,img_dial_nav1_night)
---NAV2
local local_nav2_vol = 0
msfs_variable_subscribe(controlside.."NAV2_VOL", "Number", controlside.."NAV2_VOL_Push", "Number",     
        function (vol,state)
            if state == 1 then move(group_nav2, 81,168,nil,nil, "LINEAR", 0.1) --84,24
                else move(group_nav2, 84,172,nil,nil, "LINEAR", 0.1) --87,29
            end            
            switch_set_position(sw_nav2_vol_push, state)
            local_nav2_vol = vol
             rotate(img_dial_nav2, local_nav2_vol *25, "LOG", 0.04)
             rotate(img_dial_nav2_night, local_nav2_vol *25, "LOG", 0.04)
        end) 

function cb_nav2_vol(direction) 
    if direction == 1 then msfs_variable_write(controlside.."NAV2_VOL", "Number", var_cap(local_nav2_vol +1,0,10) ) 
    else msfs_variable_write(controlside.."NAV2_VOL", "Number", var_cap(local_nav2_vol -1,0,10) )
    end 
end
dial_nav2_vol = dial_add(nil, 83,170,40,40, cb_nav2_vol)

function cb_nav2_push(state) 
    if state == 1 then msfs_variable_write(controlside.."NAV2_VOL_PUSH", "Number", 0 ) 
    else msfs_variable_write(controlside.."NAV2_VOL_PUSH", "Number", 1 )
    end 
end
sw_nav2_vol_push = switch_add(nil, nil, 94,182,15,15, cb_nav2_push)

group_nav2 = group_add(img_dial_nav2,img_dial_nav2_night)
---MKR1
local local_mkr1_vol = 0
msfs_variable_subscribe(controlside.."MKR1_VOL", "Number", controlside.."MKR1_VOL_Push", "Number",     
        function (vol,state)
            if state == 1 then move(group_mkr1, 234,168,nil,nil, "LINEAR", 0.1) --84,24
                else move(group_mkr1, 237,172,nil,nil, "LINEAR", 0.1) --87,29
            end            
            switch_set_position(sw_mkr1_vol_push, state)
            local_mkr1_vol = vol
             rotate(img_dial_mkr1, local_mkr1_vol *25, "LOG", 0.04)
             rotate(img_dial_mkr1_night, local_mkr1_vol *25, "LOG", 0.04)
        end) 

function cb_mkr1_vol(direction) 
    if direction == 1 then msfs_variable_write(controlside.."MKR1_VOL", "Number", var_cap(local_mkr1_vol +1,0,10) ) 
    else msfs_variable_write(controlside.."MKR1_VOL", "Number", var_cap(local_mkr1_vol -1,0,10) )
    end 
end
dial_mkr1_vol = dial_add(nil, 230,170,40,40, cb_mkr1_vol)

function cb_mkr1_push(state) 
    if state == 1 then msfs_variable_write(controlside.."MKR1_VOL_PUSH", "Number", 0 ) 
    else msfs_variable_write(controlside.."MKR1_VOL_PUSH", "Number", 1 )
    end 
end
sw_mkr1_vol_push = switch_add(nil, nil, 246,182,15,15, cb_mkr1_push)

group_mkr1 = group_add(img_dial_mkr1,img_dial_mkr1_night)
---MKR2
local local_mkr2_vol = 0
msfs_variable_subscribe(controlside.."MKR2_VOL", "Number", controlside.."MKR2_VOL_Push", "Number",     
        function (vol,state)
            if state == 1 then move(group_mkr2, 291,168,nil,nil, "LINEAR", 0.1) --84,24
                else move(group_mkr2, 294,172,nil,nil, "LINEAR", 0.1) --87,29
            end            
            switch_set_position(sw_mkr2_vol_push, state)
            local_mkr2_vol = vol
             rotate(img_dial_mkr2, local_mkr2_vol *25, "LOG", 0.04)
             rotate(img_dial_mkr2_night, local_mkr2_vol *25, "LOG", 0.04)
        end) 

function cb_mkr2_vol(direction) 
    if direction == 1 then msfs_variable_write(controlside.."MKR2_VOL", "Number", var_cap(local_mkr2_vol +1,0,10) ) 
    else msfs_variable_write(controlside.."MKR2_VOL", "Number", var_cap(local_mkr2_vol -1,0,10) )
    end 
end
dial_mkr2_vol = dial_add(nil, 290,170,40,40, cb_mkr2_vol)

function cb_mkr2_push(state) 
    if state == 1 then msfs_variable_write(controlside.."MKR2_VOL_PUSH", "Number", 0 ) 
    else msfs_variable_write(controlside.."MKR2_VOL_PUSH", "Number", 1 )
    end 
end
sw_mkr2_vol_push = switch_add(nil, nil, 305,182,15,15, cb_mkr2_push)

group_mkr2 = group_add(img_dial_mkr2,img_dial_mkr2_night)
---SPKR
local local_spkr_vol = 0
msfs_variable_subscribe(controlside.."SPKR_VOL", "Number", controlside.."SPKR_VOL_Push", "Number",     
        function (vol,state)
            if state == 1 then move(group_spkr, 178,204,nil,nil, "LINEAR", 0.1) --84,24
                else move(group_spkr, 181,207,nil,nil, "LINEAR", 0.1) --87,29
            end            
            switch_set_position(sw_spkr_vol_push, state)
            local_spkr_vol = vol
             rotate(img_dial_spkr, local_spkr_vol *25, "LOG", 0.04)
             rotate(img_dial_spkr_night, local_spkr_vol *25, "LOG", 0.04)
        end) 

function cb_spkr_vol(direction) 
    if direction == 1 then msfs_variable_write(controlside.."SPKR_VOL", "Number", var_cap(local_spkr_vol +1,0,10) ) 
    else msfs_variable_write(controlside.."SPKR_VOL", "Number", var_cap(local_spkr_vol -1,0,10) )
    end 
end
dial_spkr_vol = dial_add(nil, 180,205,40,40, cb_spkr_vol)

function cb_spkr_push(state) 
    if state == 1 then msfs_variable_write(controlside.."SPKR_VOL_PUSH", "Number", 0 ) 
    else msfs_variable_write(controlside.."SPKR_VOL_PUSH", "Number", 1 )
    end 
end
sw_spkr_vol_push = switch_add(nil, nil, 192,215,15,15, cb_spkr_push)

group_spkr = group_add(img_dial_spkr,img_dial_spkr_night)
--RTIC
msfs_variable_subscribe(controlside.."RTIC", "Number",   
        function (state)
            if state == 0 then visible(img_sw_rtic_up, true) visible(img_sw_rtic_mid, false) visible(img_sw_rtic_dn, false) visible(img_sw_rtic_up_night, true) visible(img_sw_rtic_mid_night, false) visible(img_sw_rtic_dn_night, false) 
            elseif state == 1 then  visible(img_sw_rtic_up, false) visible(img_sw_rtic_mid, true) visible(img_sw_rtic_dn, false) visible(img_sw_rtic_up_night, false) visible(img_sw_rtic_mid_night, true) visible(img_sw_rtic_dn_night, false)
            elseif state == 2 then  visible(img_sw_rtic_up, false) visible(img_sw_rtic_mid, false) visible(img_sw_rtic_dn, true) visible(img_sw_rtic_up_night, false) visible(img_sw_rtic_mid_night, false) visible(img_sw_rtic_dn_night, true) 
            end
            switch_set_position(sw_rtic, state)
        end) 
function cb_rtic(position, direction) 
    if direction == 1 then msfs_variable_write(controlside.."RTIC", "Number", position+1 ) 
    elseif direction == -1 then msfs_variable_write(controlside.."RTIC", "Number", position-1 )
    end 
end
sw_rtic = switch_add(nil,nil,nil, 55,225,20,20,"VERTICAL", cb_rtic) 
--VOICEBOTH
msfs_variable_subscribe(controlside.."VOICEBOTH", "Number",   
        function (state)
            if state == 1 then visible(img_sw_voiceboth_up, false) visible(img_sw_voiceboth_dn, true) visible(img_sw_voiceboth_up_night, false) visible(img_sw_voiceboth_dn_night, true) 
            else  visible(img_sw_voiceboth_up, true) visible(img_sw_voiceboth_dn, false)  visible(img_sw_voiceboth_up_night, true) visible(img_sw_voiceboth_dn_night, false) 
            end
            switch_set_position(sw_voiceboth, state)
        end) 
function cb_voiceboth(state) 
    if state == 1 then msfs_variable_write(controlside.."VOICEBOTH", "Number", 0 ) 
    else msfs_variable_write(controlside.."VOICEBOTH", "Number", 1 )
    end 
end
sw_voiceboth = switch_add(nil, nil, 140,208,26,54, cb_voiceboth) 
--MASKBOOM
msfs_variable_subscribe(controlside.."MASKBOOM", "Number",   
        function (state)
            if state == 1 then visible(img_sw_maskboom_up, false) visible(img_sw_maskboom_dn, true) visible(img_sw_maskboom_up_night, false) visible(img_sw_maskboom_dn_night, true) 
            else  visible(img_sw_maskboom_up, true) visible(img_sw_maskboom_dn, false) visible(img_sw_maskboom_up_night, true) visible(img_sw_maskboom_dn_night, false)
            end
            switch_set_position(sw_maskboom, state)
        end) 
function cb_maskboom(state) 
    if state == 1 then msfs_variable_write(controlside.."MASKBOOM", "Number", 0 ) 
    else msfs_variable_write(controlside.."MASKBOOM", "Number", 1 )
    end 
end
sw_maskboom = switch_add(nil, nil, 244,208,26,54, cb_maskboom)  
--EMERGENCY SWITCH
msfs_variable_subscribe(controlside.."EMERNORM", "Number",   
        function (state)
            if state == 1 then visible(img_sw_emer_up, false) visible(img_sw_emer_dn, true) visible(img_sw_emer_up_night, false) visible(img_sw_emer_dn_night, true)
            else  visible(img_sw_emer_up, true) visible(img_sw_emer_dn, false) visible(img_sw_emer_up_night, true) visible(img_sw_emer_dn_night, false) 
            end
            switch_set_position(sw_emernorm, state)
        end) 
function cb_emernorm(state) 
    if state == 1 then msfs_variable_write(controlside.."EMERNORM", "Number", 0 ) 
    else msfs_variable_write(controlside.."EMERNORM", "Number", 1 )
    end 
end
sw_emernorm = switch_add(nil, nil, 302,212,22,43, cb_emernorm)        