--[[
******************************************************************************************
******************Bombardier CRJ-Overhead-Air Conditioning Panel*******************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation
   
- **v1.0** 03-29-2022
    - Original Panel Created

	
##Left To Do:
	- N/A	

## NOTES
	- N/A
    
******************************************************************************************
--]]
local button_delay = 50
local tgl_RAM_AIR = 0
local tgl_Pack_L = 0
local tgl_Pack_R = 0
local tgl_MANCTRL_CKPT = 0
local tgl_MANCTRL_CABIN = 0

snd_click = sound_add("click.wav")
snd_cover_close=sound_add("cover_close.wav")
snd_cover_open=sound_add("cover_open.wav")

--add backgrond image
img_add_fullscreen("background.png")
img_bg_night = img_add_fullscreen("background_night.png")

--=======Back  Lighting============
img_labels_backlight = img_add_fullscreen("backlighting.png")

function ss_backlighting(value, power, extpower, busvolts)
    value = var_round(value*10,2) --value*0.038 if using Lvar L:ASCRJ_INTL_OVHD
    if value == 0.0 or (power == false ) then 
        opacity(img_labels_backlight, 0, "LOG", 0.04)    
        opacity(img_backlight_knob_CKPT, 0, "LOG", 0.04)            
        opacity(img_backlight_knob_CABIN, 0, "LOG", 0.04)          
    else
        opacity(img_labels_backlight, (value), "LOG", 0.04)
        opacity(img_backlight_knob_CKPT, (value), "LOG", 0.04)
        opacity(img_backlight_knob_CABIN, (value), "LOG", 0.04)        
    end
end
fs2020_variable_subscribe("A:Light Potentiometer:2", "Number",
                          "ELECTRICAL MASTER BATTERY","Bool", ss_backlighting)

---------------------------------------------
--Day graphics
img_RAM_AIR_ON = img_add("light_open.png", 475,102,86,85)  visible(img_RAM_AIR_ON, false)
img_RAM_AIR_Cover_Dn = img_add("cover_down.png", 456,-10,123,209) 
img_RAM_AIR_Cover_Up = img_add("cover_up.png", 456,-10,123,209) visible(img_RAM_AIR_Cover_Up, false)
img_Pack_L_OFF= img_add("light_off.png", 76,133,100,45) visible(img_Pack_L_OFF, false)
img_Pack_L_FAULT= img_add("light_fault.png", 76,100,100,45) visible(img_Pack_L_FAULT, false)
img_Pack_R_OFF= img_add("light_off.png", 189,133,100,45) visible(img_Pack_R_OFF, false)
img_Pack_R_FAULT= img_add("light_fault.png", 189,100,100,45) visible(img_Pack_R_FAULT, false)
img_RECIRC_FAN_up = img_add("toggle_up.png", 259,62,185,182)
img_RECIRC_FAN_dn = img_add("toggle_down.png", 259,62,185,182) visible(img_RECIRC_FAN_dn, false)
img_CKPT_SW_up = img_add("toggle_up.png", 03,220,185,182)visible(img_CKPT_SW_up, false)
img_CKPT_SW_mid = img_add("toggle_mid.png", 03,220,185,182) 
img_CKPT_SW_dn = img_add("toggle_down.png", 03,220,185,182) visible(img_CKPT_SW_dn, false)
img_CABIN_SW_up = img_add("toggle_up.png", 452,220,185,182)visible(img_CABIN_SW_up, false)
img_CABIN_SW_mid = img_add("toggle_mid.png", 452,220,185,182) 
img_CABIN_SW_dn = img_add("toggle_down.png", 452,220,185,182) visible(img_CABIN_SW_dn, false)
img_MANCTRL_CKPT = img_add("light_man.png", 185,235,86,85)  visible(img_MANCTRL_CKPT, false)
img_MANCTRL_CABIN = img_add("light_man.png", 368,235,86,85)  visible(img_MANCTRL_CABIN, false)
img_AFT_CARGO_up = img_add("toggle_up.png", 230,372,185,182)
img_AFT_CARGO_dn = img_add("toggle_down.png", 230,372,185,182) visible(img_AFT_CARGO_dn, false)
img_knob_TEMPCTRL_CKPT = img_add("round_knob.png", 129,378,130,130)
img_knob_TEMPCTRL_CABIN = img_add("round_knob.png", 385,378,130,130)


--Night Graphics
img_RAM_AIR_Cover_Dn_night = img_add("cover_down_night.png", 456,-10,123,209) 
img_RAM_AIR_Cover_Up_night = img_add("cover_up_night.png", 456,-10,123,209) visible(img_RAM_AIR_Cover_Up_night, false)
img_RECIRC_FAN_up_night = img_add("toggle_up_night.png", 259,62,185,182) 
img_RECIRC_FAN_dn_night = img_add("toggle_down_night.png", 259,62,185,182) visible(img_RECIRC_FAN_dn_night, false)
img_CKPT_SW_up_night = img_add("toggle_up_night.png", 03,220,185,182)visible(img_CKPT_SW_up_night, false)
img_CKPT_SW_mid_night = img_add("toggle_mid_night.png", 03,220,185,182) 
img_CKPT_SW_dn_night = img_add("toggle_down_night.png", 03,220,185,182) visible(img_CKPT_SW_dn_night, false)
img_CABIN_SW_up_night = img_add("toggle_up_night.png", 452,220,185,182)visible(img_CABIN_SW_up_night, false)
img_CABIN_SW_mid_night = img_add("toggle_mid_night.png", 452,220,185,182) 
img_CABIN_SW_dn_night = img_add("toggle_down_night.png", 452,220,185,182) visible(img_CABIN_SW_dn_night, false)
img_AFT_CARGO_up_night = img_add("toggle_up_night.png", 230,372,185,182)
img_AFT_CARGO_dn_night = img_add("toggle_down_night.png", 230,372,185,182) visible(img_AFT_CARGO_dn_night, false)
img_knob_TEMPCTRL_CKPT_night = img_add("round_knob_night.png", 129,378,130,130)
img_knob_TEMPCTRL_CABIN_night = img_add("round_knob_night.png", 385,378,130,130)
img_backlight_knob_CKPT= img_add("backlight_round_knob.png", 129,378,130,130)
img_backlight_knob_CABIN= img_add("backlight_round_knob.png", 385,378,130,130)

-- Ambient Light Control
function ss_ambient_darkness(value)
    opacity(img_bg_night, value, "LOG", 0.04)
    opacity(img_RECIRC_FAN_up_night, value, "LOG", 0.04)
    opacity(img_RECIRC_FAN_dn_night, value, "LOG", 0.04)
    opacity(img_RAM_AIR_Cover_Dn_night, value, "LOG", 0.04)
    opacity(img_RAM_AIR_Cover_Dn, (1-value), "LOG", 0.04) --reverses day mode
    opacity(img_RAM_AIR_Cover_Up_night, value, "LOG", 0.04)    
    opacity(img_RAM_AIR_Cover_Up, (1-value), "LOG", 0.04)   --reverses day mode      
    opacity(img_CKPT_SW_up_night , value, "LOG", 0.04)
    opacity(img_CKPT_SW_mid_night, value, "LOG", 0.04)    
    opacity(img_CKPT_SW_dn_night, value, "LOG", 0.04)  
    opacity(img_CABIN_SW_up_night , value, "LOG", 0.04)
    opacity(img_CABIN_SW_mid_night, value, "LOG", 0.04)    
    opacity(img_CABIN_SW_dn_night, value, "LOG", 0.04)         
    opacity(img_AFT_CARGO_up_night, value, "LOG", 0.04)
    opacity(img_AFT_CARGO_dn_night, value, "LOG", 0.04)    
    opacity(img_knob_TEMPCTRL_CKPT_night, value, "LOG", 0.04)
    opacity(img_knob_TEMPCTRL_CABIN_night, value, "LOG", 0.04)      
 
end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)
---------------------------------------------
----------------------------------------------

--RAM_AIR
function cb_RAM_AIR()
        tgl_RAM_AIR = (tgl_RAM_AIR + 1) % 2
        fs2020_variable_write("L:ASCRJ_AIRC_RAM_AIR","Number",tgl_RAM_AIR)
        sound_play(snd_click)
end
btn_RAM_AIR = button_add(nil,"btn_push.png", 475,105,86,85, cb_RAM_AIR) visible(btn_RAM_AIR, false)

function  cb_RAM_AIR_Cover()
    timer_start(3000, timer_RAM_AIR_Cover)    --call timer to close cover
    visible(btn_RAM_AIR, true)                        --enable button
    visible(img_RAM_AIR_Cover_Up, true) visible(img_RAM_AIR_Cover_Up_night, true)        --show up cover
    visible(img_RAM_AIR_Cover_Dn, false) visible(img_RAM_AIR_Cover_Dn_night, false)       --hide down cover
    sound_play(snd_cover_open)    
    visible(sw_RAM_AIR_Cover, false)                --disable cover switch
    
end
sw_RAM_AIR_Cover = switch_add(nil,nil, 470,105,100,100, cb_RAM_AIR_Cover)

function timer_RAM_AIR_Cover()
    visible(img_RAM_AIR_Cover_Dn, true)  visible(img_RAM_AIR_Cover_Dn_night, true)      --show dn cover
    visible(img_RAM_AIR_Cover_Up, false) visible(img_RAM_AIR_Cover_Up_night, false)        --hide up cover
    sound_play(snd_cover_close)    
    visible(btn_RAM_AIR, false)                        --disable button
    visible(sw_RAM_AIR_Cover, true)                 --enable cover switch
end

function ss_RAM_AIR_ON(on,pwr)
            if (pwr==true) then
                visible(img_RAM_AIR_ON, on ==1)
	    else visible(img_RAM_AIR_ON, false)
	    end                
end
fs2020_variable_subscribe("L:ASCRJ_AIRC_RAM_AIR_OPEN", "Number", 
				            "A:CIRCUIT GENERAL PANEL ON","Bool", ss_RAM_AIR_ON)    
----------------------------------------------

--Pack_L
function cb_Pack_L()
    tgl_Pack_L = (tgl_Pack_L +1) % 2  --- Toggles between 1 and zero for START and STOP -------    
    fs2020_variable_write("L:ASCRJ_AIRC_PACK_L","Number", tgl_Pack_L) 
    sound_play(snd_click )
end
btn_Pack_L = button_add(nil,"btn_push.png", 85,100,82,82, cb_Pack_L)     
fs2020_variable_subscribe("L:ASCRJ_AIRC_PACK_L_OFF", "Number","A:CIRCUIT GENERAL PANEL ON","Bool", function (on,pwr) if (pwr==true) then visible(img_Pack_L_OFF, on ==1)else visible(img_Pack_L_OFF, false)end end) 
fs2020_variable_subscribe("L:ASCRJ_AIRC_PACK_L_FAULT", "Number","A:CIRCUIT GENERAL PANEL ON","Bool", function (on,pwr) if (pwr==true) then visible(img_Pack_L_FAULT, on ==1)else visible(img_Pack_L_FAULT, false)end end) 

--Pack_R
function cb_Pack_R()
    tgl_Pack_R = (tgl_Pack_R +1) % 2  --- Toggles between 1 and zero for START and STOP -------    
    fs2020_variable_write("L:ASCRJ_AIRC_PACK_R","Number", tgl_Pack_R)
    sound_play(snd_click )
end
btn_Pack_R = button_add(nil,"btn_push.png", 195,100,82,82, cb_Pack_R)     
fs2020_variable_subscribe("L:ASCRJ_AIRC_PACK_R_OFF", "Number","A:CIRCUIT GENERAL PANEL ON","Bool", function (on,pwr) if (pwr==true) then visible(img_Pack_R_OFF, on ==1)else visible(img_Pack_R_OFF, false)end end) 
fs2020_variable_subscribe("L:ASCRJ_AIRC_PACK_R_FAULT", "Number","A:CIRCUIT GENERAL PANEL ON","Bool", function (on,pwr) if (pwr==true) then visible(img_Pack_R_FAULT, on ==1)else visible(img_Pack_R_FAULT, false)end end) 
----------------------------------------------

--RECIRC_FAN Switch
function cb_RECIRC_FAN(position)
    if (position == 0 ) then
        fs2020_variable_write("L:ASCRJ_AIRC_RECIRC_FAN","Number",1) 
    elseif (position == 1 ) then
        fs2020_variable_write("L:ASCRJ_AIRC_RECIRC_FAN","Number",0) 
    end 
end
sw_RECIRC_FAN= switch_add(nil,nil, 350,50,100,150, cb_RECIRC_FAN)

fs2020_variable_subscribe("L:ASCRJ_AIRC_RECIRC_FAN", "Number", 
        function (state)
            switch_set_position(sw_RECIRC_FAN, state)
            visible(img_RECIRC_FAN_up, state ==0)
            visible(img_RECIRC_FAN_up_night, state ==0)
            visible(img_RECIRC_FAN_dn, state ==1)
            visible(img_RECIRC_FAN_dn_night, state ==1)            
        end)
----------------------------------------------

--CKPT_SW Switch
function cb_CKPT_SW_dec()
    if current_pos_CKPT_SW == 1  then fs2020_variable_write("L:ASCRJ_AIRC_HOTCOLD_CKPT", "Number", 2) timer_start(100, function() fs2020_variable_write("L:ASCRJ_AIRC_HOTCOLD_CKPT","Number",1)end) end      
end
btn_CKPT_SW_dn = button_add(nil, nil, 70, 315, 50, 50, cb_CKPT_SW_dec)

function cb_CKPT_SW_inc()
    if current_pos_CKPT_SW == 1  then fs2020_variable_write("L:ASCRJ_AIRC_HOTCOLD_CKPT", "Number", 0)  timer_start(100, function() fs2020_variable_write("L:ASCRJ_AIRC_HOTCOLD_CKPT","Number",1)end) end   
end
btn_CKPT_SW_up = button_add(nil, nil, 70, 215, 50, 50, cb_CKPT_SW_inc)

fs2020_variable_subscribe("L:ASCRJ_AIRC_HOTCOLD_CKPT", "Number", 
    function (pos)
        if pos == 0 then
            visible(img_CKPT_SW_dn , false) visible(img_CKPT_SW_mid , false) visible(img_CKPT_SW_up , true)
            visible(img_CKPT_SW_dn_night , false) visible(img_CKPT_SW_mid_night , false) visible(img_CKPT_SW_up_night , true)            
        elseif pos == 1 then 
            visible(img_CKPT_SW_dn , false) visible(img_CKPT_SW_mid , true) visible(img_CKPT_SW_up , false)
            visible(img_CKPT_SW_dn_night , false) visible(img_CKPT_SW_mid_night , true) visible(img_CKPT_SW_up_night , false)            
        elseif pos == 2 then 
            visible(img_CKPT_SW_dn , true) visible(img_CKPT_SW_mid , false) visible(img_CKPT_SW_up , false)
            visible(img_CKPT_SW_dn_night , true) visible(img_CKPT_SW_mid_night , false) visible(img_CKPT_SW_up_night , false)            
        end
    current_pos_CKPT_SW = pos
end)    
    
--CABIN_SW Switch
function cb_CABIN_SW_dec()
    if current_pos_CABIN_SW == 1  then fs2020_variable_write("L:ASCRJ_AIRC_HOTCOLD_CABIN", "Number", 2) timer_start(100, function() fs2020_variable_write("L:ASCRJ_AIRC_HOTCOLD_CABIN","Number",1)end) end   
end
btn_CABIN_SW_dn = button_add(nil, nil, 525, 315, 50, 50, cb_CABIN_SW_dec)

function cb_CABIN_SW_inc()
    if current_pos_CABIN_SW == 1  then fs2020_variable_write("L:ASCRJ_AIRC_HOTCOLD_CABIN", "Number", 0) timer_start(100, function() fs2020_variable_write("L:ASCRJ_AIRC_HOTCOLD_CABIN","Number",1)end)end
end
btn_CABIN_SW_up = button_add(nil, nil, 525, 215, 50, 50, cb_CABIN_SW_inc)

fs2020_variable_subscribe("L:ASCRJ_AIRC_HOTCOLD_CABIN", "Number", 
    function (pos)
        if pos == 0 then
            visible(img_CABIN_SW_dn , false) visible(img_CABIN_SW_mid , false) visible(img_CABIN_SW_up , true)
            visible(img_CABIN_SW_dn_night , false) visible(img_CABIN_SW_mid_night , false) visible(img_CABIN_SW_up_night , true)            
        elseif pos == 1 then 
            visible(img_CABIN_SW_dn , false) visible(img_CABIN_SW_mid , true) visible(img_CABIN_SW_up , false)
            visible(img_CABIN_SW_dn_night , false) visible(img_CABIN_SW_mid_night , true) visible(img_CABIN_SW_up_night , false)            
        elseif pos == 2 then 
            visible(img_CABIN_SW_dn , true) visible(img_CABIN_SW_mid , false) visible(img_CABIN_SW_up , false)
            visible(img_CABIN_SW_dn_night , true) visible(img_CABIN_SW_mid_night , false) visible(img_CABIN_SW_up_night , false)            
        end
    current_pos_CABIN_SW = pos
end)        
----------------------------------------------
--MANCTRL_CKPT
function cb_MANCTRL_CKPT()
    tgl_MANCTRL_CKPT = (tgl_MANCTRL_CKPT +1) % 2  --- Toggles between 1 and zero for START and STOP -------    
    fs2020_variable_write("L:ASCRJ_AIRC_MANCTRL_CKPT","Number", tgl_MANCTRL_CKPT)
    sound_play(snd_click )
end
btn_MANCTRL_CKPT = button_add(nil, "btn_push.png", 190,235,82,82, cb_MANCTRL_CKPT)     
fs2020_variable_subscribe("L:ASCRJ_AIRC_MANCTRL_CKPT_MAN", "Number","A:CIRCUIT GENERAL PANEL ON","Bool", function (on,pwr) if (pwr==true) then visible(img_MANCTRL_CKPT, on ==1)else visible(img_MANCTRL_CKPT, false)end end) 
--MANCTRL_CABIN
function cb_MANCTRL_CABIN()
    tgl_MANCTRL_CABIN = (tgl_MANCTRL_CABIN +1) % 2  --- Toggles between 1 and zero for START and STOP -------    
    fs2020_variable_write("L:ASCRJ_AIRC_MANCTRL_CABIN","Number", tgl_MANCTRL_CABIN)
    sound_play(snd_click )
end
btn_MANCTRL_CABIN = button_add(nil, "btn_push.png", 370,235,82,82, cb_MANCTRL_CABIN)     
fs2020_variable_subscribe("L:ASCRJ_AIRC_MANCTRL_CABIN_MAN", "Number","A:CIRCUIT GENERAL PANEL ON","Bool", function (on,pwr) if (pwr==true) then visible(img_MANCTRL_CABIN, on ==1)else visible(img_MANCTRL_CABIN, false)end end) 
----------------------------------------------

--AFT_CARGO Switch
function cb_AFT_CARGO(position)
    if (position == 0 ) then
        fs2020_variable_write("L:ASCRJ_AIRC_AFT_CARGO","Number",1) 
    elseif (position == 1 ) then
        fs2020_variable_write("L:ASCRJ_AIRC_AFT_CARGO","Number",0) 
    end 
end
sw_AFT_CARGO= switch_add(nil,nil, 270,360,104,150, cb_AFT_CARGO)

fs2020_variable_subscribe("L:ASCRJ_AIRC_AFT_CARGO", "Number", 
        function (state)
            switch_set_position(sw_AFT_CARGO, state)
            visible(img_AFT_CARGO_up, state ==0)
            visible(img_AFT_CARGO_up_night, state ==0)            
            visible(img_AFT_CARGO_dn, state ==1)
            visible(img_AFT_CARGO_dn_night, state ==1)            
        end)
----------------------------------------------    
                
--Temperature Control Knobs CKPT
sw_TEMPCTRL_CKPT = switch_add(nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,  150,395,90,90, "CIRCULAIR",
        function (pos,dir) fs2020_variable_write("L:ASCRJ_AIRC_TEMPCTRL_CKPT","Number", pos+dir) end)

fs2020_variable_subscribe("L:ASCRJ_AIRC_TEMPCTRL_CKPT", "Number",
        function (position)
                switch_set_position(sw_TEMPCTRL_CKPT, (var_round(position,0)))             
                rotate(img_knob_TEMPCTRL_CKPT, (position*8.4)-110,"LOG", 0.1)       --110 is the starting offset (reverse degrees) and *8.4 is the multiplyer              
                rotate(img_knob_TEMPCTRL_CKPT_night, (position*8.4)-110,"LOG", 0.1)
                rotate(img_backlight_knob_CKPT, (position*8.4)-110,"LOG", 0.1)                
        end)           
--Temperature Control Knobs Cabin
sw_TEMPCTRL_CABIN = switch_add(nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,  410,395,90,90, "CIRCULAIR",
        function (pos,dir) fs2020_variable_write("L:ASCRJ_AIRC_TEMPCTRL_CABIN","Number", pos+dir) end)

fs2020_variable_subscribe("L:ASCRJ_AIRC_TEMPCTRL_CABIN", "Number",
        function (position)
                switch_set_position(sw_TEMPCTRL_CABIN, (var_round(position,0)))             
                rotate(img_knob_TEMPCTRL_CABIN, (position*8.4)-110,"LOG", 0.1)       --110 is the starting offset (reverse degrees) and *8.4 is the multiplyer              
                rotate(img_knob_TEMPCTRL_CABIN_night, (position*8.4)-110,"LOG", 0.1)   
                rotate(img_backlight_knob_CABIN, (position*8.4)-110,"LOG", 0.1)                 
        end)  
----------------------------------------------    