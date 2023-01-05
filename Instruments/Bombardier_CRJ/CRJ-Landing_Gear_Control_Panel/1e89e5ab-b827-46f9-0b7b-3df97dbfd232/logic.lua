--[[
******************************************************************************************
******************Bombardier CRJ Landing Gear Control Panel**************************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation
   
- **v1.0** 02-19-2022
    - Original Panel Created
- **v1.1** 12-30-2022
    - Panel split apart
    - Graphics Redone
    - Ambient Light Added
    - Backlighting Added

## Left To Do:
  - N/A
	
## Notes:
  - N/A
   
******************************************************************************************
--]]


img_add_fullscreen("background.png")
img_bg_night= img_add_fullscreen("background_night.png")
snd_click=sound_add("click.wav")
snd_cover_close=sound_add("cover_close.wav")
snd_cover_open=sound_add("cover_open.wav")


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
fs2020_variable_subscribe("A:Light Potentiometer:4", "Number",
                                              "A:CIRCUIT GENERAL PANEL ON","Bool", ss_backlighting)
-----------------------------------------------------------------

--Day Graphics
img_sw_up ="toggle_up.png"
img_sw_md ="toggle_mid.png"
img_sw_dn ="toggle_down.png"
img_horn_muted= img_add("muted.png", 157, 42, 59, 49)
img_horn_muted_Cover_Dn = img_add("cover_down.png", 134,-40,102,147) 
img_horn_muted_Cover_Up = img_add("cover_up.png", 134,-40,102,147) visible(img_horn_muted_Cover_Up, false)
img_sw_skid_up = img_add("toggle_up.png",  10,128,144,143)
img_sw_skid_dn = img_add("toggle_down.png",  10,128,144,143) visible(img_sw_skid_dn, false)
img_sw_bay_ovht_up = img_add("toggle_up.png",  10, 256, 144, 143)
img_sw_bay_ovht_dn = img_add("toggle_down.png",  10, 256, 144, 143) visible(img_sw_bay_ovht_dn, false)
img_sw_bay_ovht_test_up = img_add("toggle_up.png",  115,256,144,143)
img_sw_bay_ovht_test_dn = img_add("toggle_down.png",  115,256,144,143) visible(img_sw_bay_ovht_test_dn, false)
img_gear = img_add("gear.png", 330, 130, 90, 299)
img_gear_release = img_add("release.png", 264, 260, 40, 40)

--Night Graphics
img_horn_muted_Cover_Dn_night = img_add("cover_down_night.png", 132,-40,102,147) 
img_horn_muted_Cover_Up_night = img_add("cover_up_night.png", 132,-40,102,147) visible(img_horn_muted_Cover_Up_night, false)
img_sw_skid_up_night = img_add("toggle_up_night.png",  10,128,144,143)
img_sw_skid_dn_night = img_add("toggle_down_night.png",  10,128,144,143) 
img_sw_bay_ovht_up_night = img_add("toggle_up_night.png",  10, 256, 144, 143)
img_sw_bay_ovht_dn_night = img_add("toggle_down_night.png",  10, 256, 144, 143) visible(img_sw_bay_ovht_dn_night, false)
img_sw_bay_ovht_test_up_night = img_add("toggle_up_night.png",  115,256,144,143)
img_sw_bay_ovht_test_dn_night = img_add("toggle_down_night.png",  115,256,144,143) visible(img_sw_bay_ovht_test_dn_night, false)
img_gear_night = img_add("gear_night.png",  330, 130, 90, 299)
img_gear_release_night = img_add("release_night.png", 264, 260, 40, 40)

-- Ambient Light Control
function ss_ambient_darkness(value)
    opacity(img_bg_night, value, "LOG", 0.04)
    opacity(img_horn_muted_Cover_Dn_night, value, "LOG", 0.04)    
    opacity(img_horn_muted_Cover_Dn, (1-value), "LOG", 0.04) --reverses day mode     
    opacity(img_horn_muted_Cover_Up_night, value, "LOG", 0.04)  
    opacity(img_horn_muted_Cover_Up, (1-value), "LOG", 0.04) --reverses day mode     
    opacity(img_sw_skid_up_night, value, "LOG", 0.04)  
    opacity(img_sw_skid_dn_night, value, "LOG", 0.04)         
    opacity(img_sw_bay_ovht_up_night, value, "LOG", 0.04)  
    opacity(img_sw_bay_ovht_dn_night, value, "LOG", 0.04)         
    opacity(img_sw_bay_ovht_test_up_night, value, "LOG", 0.04)  
    opacity(img_sw_bay_ovht_test_dn_night, value, "LOG", 0.04)             
    opacity(img_gear_night, value, "LOG", 0.04)  
    opacity(img_gear_release_night, value, "LOG", 0.04)     
end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)
-----------------------------------------------------------------


--BTMS RESET
my_button = button_add(nil,nil, 65, 50, 35, 30, 
    function ()
            fs2020_variable_write("L:ASCRJ_GEAR_BTMS_RESET_BTN_ANIM","number",1) 
            timer_id1 = timer_start(200,BTMS_Clear)
end)

function BTMS_Clear()
    fs2020_variable_write("L:ASCRJ_GEAR_BTMS_RESET","number",1) 
    fs2020_variable_write("L:ASCRJ_GEAR_BTMS_RESET_BTN_ANIM","number",0)
end

--MUTE HORN SWITCH
fs2020_variable_subscribe("L:ASCRJ_GEAR_HORN_MUTE_ON", "Number","A:CIRCUIT GENERAL PANEL ON","Bool", 
    function (on,pwr) if (pwr==true) then visible(img_horn_muted, on ==1)else visible(img_Horn_Muted, false)end end) 

sw_horn_muted = switch_add(nil, "btn_push.png", 162, 45, 49, 50, 
    function ()
            sound_play(snd_click)
            fs2020_variable_write("L:ASCRJ_GEAR_HORN_MUTE", "Number", 1) timer_start(100, function() fs2020_variable_write("L:ASCRJ_GEAR_HORN_MUTE","Number",0)end) 
    end) visible(sw_horn_muted, false)

function  cb_horn_muted_Cover()
    timer_start(3000, timer_horn_muted_Cover)    --call timer to close cover
    visible(sw_horn_muted, true)                        --enable button
    visible(img_horn_muted_Cover_Up, true) visible(img_horn_muted_Cover_Up_night, true)        --show up cover
    visible(img_horn_muted_Cover_Dn, false) visible(img_horn_muted_Cover_Dn_night, false)      --hide down cover
    sound_play(snd_cover_open)
    visible(sw_horn_muted_Cover, false)                --disable cover switch
end
sw_horn_muted_Cover = switch_add(nil,nil, 157, 42, 59, 49, cb_horn_muted_Cover)

function timer_horn_muted_Cover()
    visible(img_horn_muted_Cover_Dn, true) visible(img_horn_muted_Cover_Dn_night, true)        --show dn cover
    visible(img_horn_muted_Cover_Up, false) visible(img_horn_muted_Cover_Up_night, false)        --hide up cover
    sound_play(snd_cover_close)
    visible(sw_horn_muted, false)                        --disable button
    visible(sw_horn_muted_Cover, true)                 --enable cover switch
end


--ANTI SKID SWITCH
fs2020_variable_subscribe("L:ASCRJ_GEAR_ANTISKID_ARM", "Number", 
        function (state)
            switch_set_position(sw_skid, state)
            visible(img_sw_skid_up, state ==1)
            visible(img_sw_skid_up_night, state ==1)
            visible(img_sw_skid_dn, state ==0)
            visible(img_sw_skid_dn_night, state ==0)              
        end)

function cb_sw_skid(position)
        fs2020_variable_write("L:ASCRJ_GEAR_ANTISKID_ARM","Number",5)  --this is used to trick AM into getting position.
    if (position == 0 ) then
        fs2020_variable_write("L:ASCRJ_GEAR_ANTISKID_ARM","Number",1) 
    elseif (position == 1 ) then
        fs2020_variable_write("L:ASCRJ_GEAR_ANTISKID_ARM","Number",0) 
    end 
end
sw_skid= switch_add(nil, nil, 60,125,50,110, cb_sw_skid)

--GEAR BAY OVHT SWITCH
fs2020_variable_subscribe("L:ASCRJ_GEAR_MLG_TEST", "Number", 
        function (state)
            switch_set_position(sw_bay_ovht, state)
            visible(img_sw_bay_ovht_up, state ==1)
            visible(img_sw_bay_ovht_up_night, state ==1)
            visible(img_sw_bay_ovht_dn, state ==0)
            visible(img_sw_bay_ovht_dn_night, state ==0)               
        end)

function cb_sw_bay_ovht(position)
    if (position == 0 ) then
        fs2020_variable_write("L:ASCRJ_GEAR_MLG_TEST","Number",1) 
    elseif (position == 1 ) then
        fs2020_variable_write("L:ASCRJ_GEAR_MLG_TEST","Number",0) 
    end 
end
sw_bay_ovht= switch_add(nil,nil, 60, 256, 50,110, cb_sw_bay_ovht)

--GEAR OVHT TEST SWITCH
fs2020_variable_subscribe("L:ASCRJ_GEAR_TEST_FAIL_TEST", "Number", 
        function (state)
            switch_set_position(sw_bay_ovht_test, state)
            visible(img_sw_bay_ovht_test_up, state ==1)
            visible(img_sw_bay_ovht_test_up_night, state ==1)
            visible(img_sw_bay_ovht_test_dn, state ==0)
            visible(img_sw_bay_ovht_test_dn_night, state ==0)                  
        end)
function cb_sw_bay_ovht_test_nothing(position)
        --NOT NEEDED
end
function cb_sw_bay_ovht_test(position)
        fs2020_variable_write("L:ASCRJ_GEAR_TEST_FAIL_TEST","Number",1) 
end
function cb_sw_bay_ovht_test_release(position)
        fs2020_variable_write("L:ASCRJ_GEAR_TEST_FAIL_TEST","Number",0) 
end
sw_bay_ovht_test= switch_add(nil,nil, 160,256,50,110,  cb_sw_bay_ovht_test_nothing,  cb_sw_bay_ovht_test, cb_sw_bay_ovht_test_release)

--LANDING GEAR SWITCH
fs2020_variable_subscribe("L:ASCRJ_GEAR_GEAR_LEVER", "Number", 
        function  (state)
            switch_set_position(sw_Gear, state)
            if (state == 1) then move(img_gear, 330, 130, nil, nil,  'LINEAR', 0.05)move(img_gear_night, 330, 130, nil, nil,  'LINEAR', 0.05)
            else move(img_gear, 330, 40, nil, nil,  'LINEAR', 0.05)move(img_gear_night, 330, 40, nil, nil,  'LINEAR', 0.05)
            end
end)

sw_Gear = switch_add(nil, nil, 340, 80, 90, 240, 
        function (position)
        fs2020_variable_write("L:ASCRJ_GEAR_GEAR_LEVER", "Number", 5)  --this is used to trick AM into getting position
              if position == 1 then fs2020_variable_write("L:ASCRJ_GEAR_GEAR_LEVER", "Number", 0) 
              else  fs2020_variable_write("L:ASCRJ_GEAR_GEAR_LEVER", "Number", 1)  
              end
end)

--Landing Gear Release Button
fs2020_variable_subscribe("L:ASCRJ_GEAR_LOCK_RELEASE", "Number", 
        function  (state)
            switch_set_position(sw_Gear_Release, state)
            if (state == 1) then move(img_gear_release, 270, 285, nil, nil,  'LINEAR', 0.05)move(img_gear_release_night, 270, 285, nil, nil,  'LINEAR', 0.05)
            else move(img_gear_release, 264, 260, nil, nil,  'LINEAR', 0.05)move(img_gear_release_night, 264, 260, nil, nil,  'LINEAR', 0.05)
            end
end)

sw_Gear_Release = switch_add(nil, nil, 260, 260, 40, 60, 
        function() end,
        function () fs2020_variable_write("L:ASCRJ_GEAR_LOCK_RELEASE", "Number", 1) end,
        function () fs2020_variable_write("L:ASCRJ_GEAR_LOCK_RELEASE", "Number", 0) end)
