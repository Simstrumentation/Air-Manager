--[[
******************************************************************************************
****************Bombardier CRJ-Overhead-Cabin Pressure Panel*************************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation
   
- **v1.0** 03-27-2022
    - Original Panel Created

##Left To Do:
    - N/A
		
##Notes:
    - Manual Alt/Rate is not tested thoroughly
    - Emer Depress ON light is INOP in Virtural Cockpit, but this panel does change the LocalVariable in the sim.
    
******************************************************************************************
--]]
local tgl_EMER_DEPRESS = 0
local tgl_CONT_MAN = 0
snd_click = sound_add("click.wav")
snd_cover_close=sound_add("cover_close.wav")
snd_cover_open=sound_add("cover_open.wav")

--add backgrond image
img_add_fullscreen("background.png")
img_bg_night = img_add_fullscreen("background_night.png")

--=======Back  Lighting============
img_labels_backlight = img_add_fullscreen("backlighting.png")

function ss_backlighting(value, pwr)
    value = var_round(value*10,2) --value*0.038 if using Lvar L:ASCRJ_INTL_OVHD
    if value == 0.0 or (pwr == false ) then 
        opacity(img_labels_backlight, 0, "LOG", 0.04)
        opacity(img_backlight_knob_MAN_RATE, 0, "LOG", 0.04)                                 
    else
        opacity(img_labels_backlight, (value), "LOG", 0.04) 
        opacity(img_backlight_knob_MAN_RATE, (value), "LOG", 0.04)   
    end
end
msfs_variable_subscribe("A:Light Potentiometer:2", "Number",
                                              "A:CIRCUIT GENERAL PANEL ON","Bool", ss_backlighting)


-- Ambient Light Control
function ss_ambient_darkness(value)
    opacity(img_bg_night, value, "LOG", 0.04)
    opacity(img_LDG_ELEV_night, value, "LOG", 0.04)    
    opacity(img_EMER_DEPRESS_Cover_Up_night, value, "LOG", 0.04)
    opacity(img_EMER_DEPRESS_Cover_Up, (1-value), "LOG", 0.04) --reverses day mode     
    opacity(img_EMER_DEPRESS_Cover_Dn_night, value, "LOG", 0.04)   
    opacity(img_EMER_DEPRESS_Cover_Dn, (1-value), "LOG", 0.04) --reverses day mode          
    opacity(img_MAN_ALT_up_night, value, "LOG", 0.04)
    opacity(img_MAN_ALT_mid_night, value, "LOG", 0.04)
    opacity(img_MAN_ALT_dn_night, value, "LOG", 0.04)
    opacity(img_knob_MAN_RATE_night, value, "LOG", 0.04)
end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)
-----------------------------------------------------------------
--Day Graphics
img_MAN_ALT_up = img_add("white_toggle_up.png", 420,10,181,179)visible(img_MAN_ALT_up, false)
img_MAN_ALT_mid = img_add("white_toggle_mid.png", 420,10,181,179) 
img_MAN_ALT_dn = img_add("white_toggle_down.png", 420,10,181,179) visible(img_MAN_ALT_dn, false)

img_EMER_DEPRESS_ON = img_add("light_on.png", 97,232,86,86)  visible(img_EMER_DEPRESS_ON, false)
img_EMER_DEPRESS_Cover_Dn = img_add("cover_red_down.png", 77,120,123,209) 
img_EMER_DEPRESS_Cover_Up = img_add("cover_red_up.png", 77,120,123,209) visible(img_EMER_DEPRESS_Cover_Up, false)

img_CONT_MAN_ON= img_add("light_man.png", 262,274,100,45) visible(img_CONT_MAN_ON, false)
img_CONT_FAULT_ON= img_add("light_fault.png", 262,240,100,45) visible(img_CONT_FAULT_ON, false)

img_knob_MAN_RATE= img_add("round_knob.png", 447,215,130,130)


--Night Graphics
img_MAN_ALT_up_night = img_add("white_toggle_up_night.png", 420,10,181,179) visible(img_MAN_ALT_up_night, false)
img_MAN_ALT_mid_night = img_add("white_toggle_mid_night.png", 420,10,181,179) visible(img_MAN_ALT_mid_night, false)
img_MAN_ALT_dn_night = img_add("white_toggle_down_night.png", 420,10,181,179) visible(img_MAN_ALT_dn_night, false)

img_EMER_DEPRESS_Cover_Dn_night = img_add("cover_red_down_night.png", 78,120,123,209) 
img_EMER_DEPRESS_Cover_Up_night = img_add("cover_red_up_night.png", 77,120,123,209) visible(img_EMER_DEPRESS_Cover_Up_night, false)

img_knob_MAN_RATE_night= img_add("round_knob_night.png", 447,215,130,130)
img_backlight_knob_MAN_RATE= img_add("backlight_round_knob.png", 447,215,130,130)
---------------------------------------------------------------------
--Emer Depress
function cb_EMER_DEPRESS()
        tgl_EMER_DEPRESS = (tgl_EMER_DEPRESS + 1) % 2
        msfs_variable_write("L:ASCRJ_PRESS_EMER_DEPRESS","Number",tgl_EMER_DEPRESS)
        sound_play(snd_click)
end
btn_EMER_DEPRESS = button_add(nil,"btn_push.png", 105,240,69,68, cb_EMER_DEPRESS) visible(btn_EMER_DEPRESS, true)

function  cb_EMER_DEPRESS_Cover()
    timer_start(3000, timer_EMER_DEPRESS_Cover)    --call timer to close cover
    visible(btn_EMER_DEPRESS, true)                        --enable button
    visible(img_EMER_DEPRESS_Cover_Up, true)  visible(img_EMER_DEPRESS_Cover_Up_night, true)        --show up cover
    visible(img_EMER_DEPRESS_Cover_Dn, false) visible(img_EMER_DEPRESS_Cover_Dn_night, false)        --hide down cover
    sound_play(snd_cover_open)    
    visible(sw_EMER_DEPRESS_Cover, false)               --disable cover switch
    
end
sw_EMER_DEPRESS_Cover = switch_add(nil,nil, 76,106,123,220, cb_EMER_DEPRESS_Cover)

function timer_EMER_DEPRESS_Cover()
    visible(img_EMER_DEPRESS_Cover_Dn, true) visible(img_EMER_DEPRESS_Cover_Dn_night, true)        --show dn cover
    visible(img_EMER_DEPRESS_Cover_Up, false) visible(img_EMER_DEPRESS_Cover_Up_night, false)        --hide up cover
    sound_play(snd_cover_close)    
    visible(btn_EMER_DEPRESS, false)                        --disable button
    visible(sw_EMER_DEPRESS_Cover, true)                 --enable cover switch
end


msfs_variable_subscribe("L:ASCRJ_PRESS_EMER_DEPRESS", "Number",
                                              "A:CIRCUIT GENERAL PANEL ON","Bool", 
function (on,pwr)
        visible(img_EMER_DEPRESS_ON, (on ==1 and pwr ==true))
end)

--Cont Button
function cb_CONT_MAN()
    tgl_CONT_MAN = (tgl_CONT_MAN +1) % 2  --- Toggles between 1 and zero for START and STOP -------    
    msfs_variable_write("L:ASCRJ_PRESS_PRESS_CONT","Number", tgl_CONT_MAN)
    sound_play(snd_click )
end
btn_CONT_MAN = button_add(nil,"btn_push.png", 278,245,69,68, cb_CONT_MAN)     
msfs_variable_subscribe("L:ASCRJ_PRESS_PRESS_CONT_MAN", "Number", "A:CIRCUIT GENERAL PANEL ON","Bool", 
        function (on,pwr) visible(img_CONT_MAN_ON,(on ==1 and pwr ==true)) end) 
msfs_variable_subscribe("L:ASCRJ_PRESS_PRESS_CONT_FAULT", "Number", "A:CIRCUIT GENERAL PANEL ON","Bool", 
        function (on,pwr) visible(img_CONT_FAULT_ON,(on ==1 and pwr ==true)) end)     

--LDG Elev   
local ldgelev_angle = 0
function cb_LDG_ELEV(direction)
    msfs_variable_write("L:ASCRJ_PRESS_LDG_ELEV_CHANGE","Number", direction) timer_start(100, function() msfs_variable_write("L:ASCRJ_PRESS_LDG_ELEV_CHANGE","Number",0)end)   
    ldgelev_angle = ldgelev_angle + (direction*10)
    rotate(img_LDG_ELEV_night, ldgelev_angle)
end
dial_LDG_ELEV = dial_add("delta_knob.png", 220,45,100,100,cb_LDG_ELEV)  
img_LDG_ELEV_night = img_add("delta_knob_night.png", 220,45,100,100)  


--Man Alt
function cb_MAN_ALT_dec()
    if current_pos_MAN_ALT == 1  then msfs_variable_write("L:ASCRJ_PRESS_MAN_ALT", "Number", 2) timer_start(50, function() msfs_variable_write("L:ASCRJ_PRESS_MAN_ALT","Number",1)end) end  
end
btn_MAN_ALT_dn = button_add(nil, nil, 485, 120, 50, 50, cb_MAN_ALT_dec)

function cb_MAN_ALT_inc()
    if current_pos_MAN_ALT == 1  then msfs_variable_write("L:ASCRJ_PRESS_MAN_ALT", "Number", 0)  timer_start(50, function() msfs_variable_write("L:ASCRJ_PRESS_MAN_ALT","Number",1)end) end
end
btn_MAN_ALT_up = button_add(nil, nil, 485, 30, 50, 50, cb_MAN_ALT_inc)

function ss_man_alt(pos)
        if pos == 0 then
            visible(img_MAN_ALT_dn , false) visible(img_MAN_ALT_mid , false) visible(img_MAN_ALT_up , true)
            visible(img_MAN_ALT_dn_night , false) visible(img_MAN_ALT_mid_night , false) visible(img_MAN_ALT_up_night , true)         
            timer_id = timer_start(200,ss_man_alt)                    
        elseif (pos == 1 and (timer_running(timer_id)==false) ) then 
            visible(img_MAN_ALT_dn , false) visible(img_MAN_ALT_mid , true) visible(img_MAN_ALT_up , false)
            visible(img_MAN_ALT_dn_night , false) visible(img_MAN_ALT_mid_night , true) visible(img_MAN_ALT_up_night , false)            
        elseif pos == 2 then 
            visible(img_MAN_ALT_dn , true) visible(img_MAN_ALT_mid , false) visible(img_MAN_ALT_up , false)
            visible(img_MAN_ALT_dn_night , true) visible(img_MAN_ALT_mid_night , false) visible(img_MAN_ALT_up_night , false) 
            timer_id = timer_start(200,ss_man_alt)           
        end
    current_pos_MAN_ALT = pos
end
msfs_variable_subscribe("L:ASCRJ_PRESS_MAN_ALT", "Number", ss_man_alt)    
    
    
--Man Rate Knob 0-26   "L:ASCRJ_PRESS_MAN_VS_RATE"
sw_MAN_RATE = switch_add(nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,  447,215,130,130, "CIRCULAIR",
        function (pos,dir) msfs_variable_write("L:ASCRJ_PRESS_MAN_VS_RATE","Number", pos+dir) end)

msfs_variable_subscribe("L:ASCRJ_PRESS_MAN_VS_RATE", "Number",
        function (position)
                switch_set_position(sw_MAN_RATE, (var_round(position,0)))             
                rotate(img_knob_MAN_RATE, (position*8.4)-110,"LOG", 0.1)       --110 is the starting offset (reverse degrees) and *8.4 is the multiplyer 
                rotate(img_knob_MAN_RATE_night, (position*8.4)-110,"LOG", 0.1)      
                rotate(img_backlight_knob_MAN_RATE, (position*8.4)-110,"LOG", 0.1)                                                                       
        end)           
