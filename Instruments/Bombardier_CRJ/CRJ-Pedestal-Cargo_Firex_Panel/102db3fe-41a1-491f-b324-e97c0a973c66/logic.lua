--[[
******************************************************************************************
*****************Bombardier CRJ Pedestal-Cargo Firex Panel***************************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation

- **v1.0** 06-21-2022
    - Original Panel Created


##Left To Do:
    - N/A
	
##Notes:
    - N/A
        
--]]

snd_click = sound_add("click.wav")
snd_cover_close=sound_add("cover_close.wav")
snd_cover_open=sound_add("cover_open.wav")
img_add_fullscreen("background.png")
img_bg_night = img_add_fullscreen("background_night.png")

--=======Back  Lighting============
img_labels_backlight = img_add_fullscreen("backlighting.png")

function ss_backlighting(value, pwr)
    value = var_round(value*10,2) 
    if value == 0.0 or (pwr == false ) then 
        opacity(img_labels_backlight, 0, "LOG", 0.04) 
    else
        opacity(img_labels_backlight, (value), "LOG", 0.04)          
    end
end
msfs_variable_subscribe("A:Light Potentiometer:4", "Number",
                                              "A:CIRCUIT GENERAL PANEL ON","Bool", ss_backlighting)

img_fwd = img_add("smokepush.png", 57, 70, 62, 54) visible(img_fwd, false)
img_aft = img_add("smokepush.png", 57, 180, 62, 54) visible(img_fwd, false)
img_arm_light = img_add("armed.png", 247, 132, 48, 51) visible(img_fwd, false)

img_fwd_Cover_Dn = img_add("cover_down.png", 50,10,75,120) 
img_fwd_Cover_Up = img_add("cover_up.png", 50,10,75,120) visible(img_fwd_Cover_Up, false)
img_aft_Cover_Dn = img_add("cover_down.png", 50,120,75,120) 
img_aft_Cover_Up = img_add("cover_up.png", 50,120,75,120) visible(img_aft_Cover_Up, false)

--Night Graphics
img_fwd_Cover_Dn_night= img_add("cover_down_night.png", 50,10,75,120) 
img_fwd_Cover_Up_night = img_add("cover_up_night.png", 50,10,75,120) visible(img_fwd_Cover_Up_night, false)
img_aft_Cover_Dn_night = img_add("cover_down_night.png", 50,120,75,120) 
img_aft_Cover_Up_night = img_add("cover_up_night.png", 50,120,75,120) visible(img_aft_Cover_Up_night, false)



-- Ambient Light Control
function ss_ambient_darkness(value)
    opacity(img_bg_night, value, "LOG", 0.04)
    opacity(img_fwd_Cover_Dn_night, value, "LOG", 0.04) 
    opacity(img_fwd_Cover_Up_night, value, "LOG", 0.04)     
    opacity(img_aft_Cover_Dn_night, value, "LOG", 0.04)
    opacity(img_aft_Cover_Up_night, value, "LOG", 0.04)

end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)

-- FWD
function ss_fwd(state,pwr)
	visible(img_fwd, (state ==1 and pwr ==true))
end        
msfs_variable_subscribe("L:ASCRJ_CARGO_FWD_ARMED", "Number", "A:CIRCUIT GENERAL PANEL ON", "Bool",  ss_fwd)

function cb_fwd()
    msfs_variable_write("L:ASCRJ_CARGO_FWD",  "Number", 1) --timer_start(100, function() msfs_variable_write("L:ASCRJ_STAB_TRIM_CH1_TRIGGER", "Number", 0) end)
    sound_play(snd_click)
end
btn_fwd = button_add(nil,"btn_push.png", 65, 78, 48, 45, cb_fwd)     visible(btn_fwd, false)  

function  cb_fwd_Cover()
    timer_start(3000, timer_fwd_Cover)    --call timer to close cover
    visible(btn_fwd, true)                        --enable button
    visible(img_fwd_Cover_Up, true) visible(img_fwd_Cover_Up_night, true)        --show up cover
    visible(img_fwd_Cover_Dn, false) visible(img_fwd_Cover_Dn_night, false)       --hide down cover
    sound_play(snd_cover_open)    
    visible(sw_fwd_Cover, false)                --disable cover switch
end
sw_fwd_Cover = switch_add(nil,nil, 57, 70, 62, 54, cb_fwd_Cover)

function timer_fwd_Cover()
    visible(img_fwd_Cover_Dn, true)  visible(img_fwd_Cover_Dn_night, true)      --show dn cover
    visible(img_fwd_Cover_Up, false) visible(img_fwd_Cover_Up_night, false)        --hide up cover
    sound_play(snd_cover_close)    
    visible(btn_fwd, false)                        --disable button
    visible(sw_fwd_Cover, true)                 --enable cover switch
end



-- AFT
function ss_aft(state,pwr)
	visible(img_aft, (state ==1 and pwr ==true))
end        
msfs_variable_subscribe("L:ASCRJ_CARGO_AFT_ARMED", "Number", "A:CIRCUIT GENERAL PANEL ON", "Bool",  ss_aft)

function cb_aft()
    msfs_variable_write("L:ASCRJ_CARGO_AFT",  "Number", 1)msfs_variable_write("L:ASCRJ_CARGO_AFT",  "Number", 1) timer_start(500, function() msfs_variable_write("L:ASCRJ_CARGO_AFT_ANIM", "Number", 0) end)
    sound_play(snd_click)
end
btn_aft = button_add(nil,"btn_push.png", 65, 188, 48, 45, cb_aft)
 
function  cb_aft_Cover()
    timer_start(3000, timer_aft_Cover)    --call timer to close cover
    visible(btn_aft, true)                        --enable button
    visible(img_aft_Cover_Up, true) visible(img_aft_Cover_Up_night, true)        --show up cover
    visible(img_aft_Cover_Dn, false) visible(img_aft_Cover_Dn_night, false)       --hide down cover
    sound_play(snd_cover_open)    
    visible(sw_aft_Cover, false)                --disable cover switch
end
sw_aft_Cover = switch_add(nil,nil,  57, 180, 62, 54, cb_aft_Cover)

function timer_aft_Cover()
    visible(img_aft_Cover_Dn, true)  visible(img_aft_Cover_Dn_night, true)      --show dn cover
    visible(img_aft_Cover_Up, false) visible(img_aft_Cover_Up_night, false)        --hide up cover
    sound_play(snd_cover_close)    
    visible(btn_aft, false)                        --disable button
    visible(sw_aft_Cover, true)                 --enable cover switch
end 

-- ARM_LIGHT
function ss_arm_light(state,pwr)
	visible(img_arm_light, (state ==1 and pwr ==true))
end        
msfs_variable_subscribe("L:ASCRJ_CARGO_ARM_LIGHT", "Number", "A:CIRCUIT GENERAL PANEL ON", "Bool",  ss_arm_light)

function cb_arm_light()
    msfs_variable_write("L:ASCRJ_CARGO_ARM",  "Number", 1) --timer_start(100, function() msfs_variable_write("L:ASCRJ_STAB_TRIM_CH1_TRIGGER", "Number", 0) end)
    sound_play(snd_click)
end
btn_arm_light = button_add(nil,"btn_push.png", 247, 132, 48, 51, cb_arm_light) 