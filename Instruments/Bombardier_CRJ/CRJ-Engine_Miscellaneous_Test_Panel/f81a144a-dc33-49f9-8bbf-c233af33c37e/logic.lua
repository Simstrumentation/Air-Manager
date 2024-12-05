--[[
******************************************************************************************
******************Bombardier CRJ Engine & Miscellaneous Test Panel*********************
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
msfs_variable_subscribe("A:Light Potentiometer:4", "Number",
                                              "A:CIRCUIT GENERAL PANEL ON","Bool", ss_backlighting)
-----------------------------------------------------------------

--Day Graphics
img_dial_synch= img_add("round_knob.png",63, 58,80,80)
img_highpwr= img_add("pwr_on.png", 217, 76, 59, 49)
img_hpsched_Cover_Dn = img_add("cover_down.png", 194, -8,102,147) 
img_hpsched_Cover_Up = img_add("cover_up.png", 194, -8,102,147) visible(img_hpsched_Cover_Up, false)
img_sw_lamp_test_up = img_add("toggle_up.png",  314, 19, 144, 143)
img_sw_lamp_test_mid = img_add("toggle_mid.png",  314, 19, 144, 143)visible(img_sw_lamp_test_mid, false)
img_sw_lamp_test_dn = img_add("toggle_down.png",  314, 19, 144, 143) visible(img_sw_lamp_test_dn, false)
img_sw_indlts_up = img_add("toggle_up.png",  314, 135, 144, 143)
img_sw_indlts_dn = img_add("toggle_down.png",  314, 135, 144, 143) visible(img_sw_indlts_dn, false)


--Night Graphics
img_dial_synch_night= img_add("round_knob_night.png",63,58,80,80)
img_hpsched_Cover_Dn_night = img_add("cover_down_night.png", 194, -8,102,147)
img_hpsched_Cover_Up_night = img_add("cover_up_night.png", 194, -8,102,147) visible(img_hpsched_Cover_Up_night, false)
img_sw_lamp_test_up_night = img_add("toggle_up_night.png",  314, 19, 144, 143)
img_sw_lamp_test_mid_night = img_add("toggle_mid_night.png",  314, 19, 144, 143)visible(img_sw_lamp_test_mid_night, false)
img_sw_lamp_test_dn_night = img_add("toggle_down_night.png",  314, 19, 144, 143) visible(img_sw_lamp_test_dn_night, false)
img_sw_indlts_up_night = img_add("toggle_up_night.png",  314, 135, 144, 143)
img_sw_indlts_dn_night = img_add("toggle_down_night.png",  314, 135, 144, 143) visible(img_sw_indlts_dn_night, false)


-- Ambient Light Control
function ss_ambient_darkness(value)
    opacity(img_bg_night, value, "LOG", 0.04)
    opacity(img_dial_synch_night, value, "LOG", 0.04)        
    opacity(img_hpsched_Cover_Dn_night, value, "LOG", 0.04)    
    opacity(img_hpsched_Cover_Dn, (1-value), "LOG", 0.04) --reverses day mode       
    opacity(img_hpsched_Cover_Up_night, value, "LOG", 0.04)    
    opacity(img_hpsched_Cover_Up, (1-value), "LOG", 0.04) --reverses day mode    
    opacity(img_sw_lamp_test_up_night, value, "LOG", 0.04)        
    opacity(img_sw_lamp_test_mid_night, value, "LOG", 0.04)        
    opacity(img_sw_lamp_test_dn_night, value, "LOG", 0.04)             
    opacity(img_sw_indlts_up_night, value, "LOG", 0.04)        
    opacity(img_sw_indlts_dn_night, value, "LOG", 0.04)                    

end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)
-----------------------------------------------------------------

--ENGINE SYNCH
function ss_synch(state)
    switch_set_position(switch_synch, state)
    rotate(img_dial_synch, -(55-(state*55)))
    rotate(img_dial_synch_night, -(55-(state*55)))    
end
msfs_variable_subscribe("L:ASCRJ_ENG_SYNC", "Number", ss_synch)
function cb_sw_synch(position, direction)
 msfs_variable_write("L:ASCRJ_ENG_SYNC","number",1) 
    if (position == 0 and direction == 1 ) then
        msfs_variable_write("L:ASCRJ_ENG_SYNC","number",1) 
    elseif (position == 1 and direction == 1 ) then
        msfs_variable_write("L:ASCRJ_ENG_SYNC","number",2) 
    elseif (position == 1 and direction == -1 ) then
        msfs_variable_write("L:ASCRJ_ENG_SYNC","number",0)         
    elseif (position == 2 and direction == -1) then
        msfs_variable_write("L:ASCRJ_ENG_SYNC","number",1)               
    end 
end
switch_synch= switch_add(nil,nil,nil, 63, 58,80,80, "CIRCULAIR" , cb_sw_synch)  

--PWR SWITCH
msfs_variable_subscribe("L:ASCRJ_ENG_HPSCHED_ON", "Number","A:CIRCUIT GENERAL PANEL ON","Bool", 
    function (on,pwr) if (pwr==true) then visible(img_highpwr, on ==1)else visible(img_highpwr, false)end end) 

sw_hpsched = switch_add(nil, nil, 218, 75, 55, 55, 
        function (position)
              sound_play(snd_click)
              if position == 1 then msfs_variable_write("L:ASCRJ_ENG_HPSCHED", "Number", 1) timer_start(100, function() msfs_variable_write("L:ASCRJ_ENG_HPSCHED","Number",0)end) 
              else  msfs_variable_write("L:ASCRJ_ENG_HPSCHED", "Number", 1) timer_start(100, function() msfs_variable_write("L:ASCRJ_ENG_HPSCHED","Number",0)end) 
              end
end)
visible(sw_hpsched, false)

function  cb_hpsched_Cover()
    timer_start(3000, timer_hpsched_Cover)    --call timer to close cover
    visible(sw_hpsched, true)                        --enable button
    visible(img_hpsched_Cover_Up, true) visible(img_hpsched_Cover_Up_night, true)        --show up cover
    visible(img_hpsched_Cover_Dn, false) visible(img_hpsched_Cover_Dn_night, false)      --hide down cover
    sound_play(snd_cover_open)
    visible(sw_hpsched_Cover, false)                --disable cover switch
end
sw_hpsched_Cover = switch_add(nil, nil, 210, 60, 72, 74, cb_hpsched_Cover)

function timer_hpsched_Cover()
    visible(img_hpsched_Cover_Dn, true) visible(img_hpsched_Cover_Dn_night, true)        --show dn cover
    visible(img_hpsched_Cover_Up, false) visible(img_hpsched_Cover_Up_night, false)        --hide up cover
    sound_play(snd_cover_close)
    visible(sw_hpsched, false)                        --disable button
    visible(sw_hpsched_Cover, true)                 --enable cover switch
end


--LAMP TEST SWITCH
msfs_variable_subscribe("L:ASCRJ_ENG_LAMPTEST", "Number", 
        function (state)
            switch_set_position(sw_lamp_test, state)
            visible(img_sw_lamp_test_up, state ==0)
            visible(img_sw_lamp_test_up_night, state ==0)
            visible(img_sw_lamp_test_mid, state ==1)
            visible(img_sw_lamp_test_mid_night, state ==1)  
            visible(img_sw_lamp_test_dn, state ==2)
            visible(img_sw_lamp_test_dn_night, state ==2)              
        end)

function cb_sw_lamp_test(position,direction)
    if (position == 0 ) then
        msfs_variable_write("L:ASCRJ_ENG_LAMPTEST","Number",1) 
    elseif (position == 1 and direction == -1 ) then
        msfs_variable_write("L:ASCRJ_ENG_LAMPTEST","Number",0) 
    elseif (position == 1 and direction == 1 ) then
        msfs_variable_write("L:ASCRJ_ENG_LAMPTEST","Number",2)        
    elseif (position == 2 and direction == -1 ) then
        msfs_variable_write("L:ASCRJ_ENG_LAMPTEST","Number",1)        
    end 
end
sw_lamp_test= switch_add(nil,nil,nil, 362, 28, 50, 100, cb_sw_lamp_test)

--IND LTS SWITCH
msfs_variable_subscribe("L:ASCRJ_ENG_INDLTS", "Number", 
        function  (state)
            switch_set_position(sw_IndLts, state)
            visible(img_sw_indlts_up, state ==0)
            visible(img_sw_indlts_up_night, state ==0)
            visible(img_sw_indlts_dn, state ==1)
            visible(img_sw_indlts_dn_night, state ==1)              
end)

sw_IndLts = switch_add(nil,nil, 362, 140, 50 ,110, 
        function (position)
              if position == 1 then msfs_variable_write("L:ASCRJ_ENG_INDLTS", "Number", 0)
              else  msfs_variable_write("L:ASCRJ_ENG_INDLTS", "Number", 1)
              end
end)

--FDR EVENT BUTTON
button_add(nil, "circle_pressed.png", 72, 172, 60 ,60, 
        function ()
              msfs_variable_write("L:ASCRJ_ENG_FDR_EVENT", "Number", 1)
end)