--[[
******************************************************************************************
************Bombardier CRJ-Overhead-Pass & Emer Lights and ELT Panel*****************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation
   
- **v1.0** 03-16-2022
    - Original Panel Created

	
##Left To Do:
    - N/A
	
##Notes:
    - N/A
******************************************************************************************
--]]
snd_click=sound_add("click.wav")
--add backgrond image
img_add_fullscreen("background.png")
img_bg_night = img_add_fullscreen("background_night.png")

--=======Back  Lighting============
img_labels_backlight = img_add_fullscreen("backlighting.png")

function ss_backlighting(value, power, extpower, busvolts)
    value = var_round(value*10,2) --value*0.038 if using Lvar L:ASCRJ_INTL_OVHD
    if value == 0.0 or (power == false ) then 
        opacity(img_labels_backlight, 0, "LOG", 0.04)            
    else
        opacity(img_labels_backlight, (value), "LOG", 0.04)
    end
end
fs2020_variable_subscribe("A:Light Potentiometer:2", "Number",
                                              "ELECTRICAL MASTER BATTERY","Bool", ss_backlighting)

---------------------------------------------
--Day Graphics
nosmk_dn = img_add("toggle_down.png", -25,61,181,179)
nosmk_mid = img_add("toggle_mid.png", -25,61,181,179) visible(nosmk_mid, false)
nosmk_up = img_add("toggle_up.png", -25,61,181,179) visible(nosmk_up, false)
seat_dn = img_add("toggle_down.png", 105,61,181,179)
seat_mid = img_add("toggle_mid.png", 105,61,181,179) visible(seat_mid, false)
seat_up = img_add("toggle_up.png", 105,61,181,179) visible(seat_up, false)

emer_up = img_add("lrg_toggle_up.png", 346,-10,108,300) visible(emer_up, false)
emer_mid = img_add("lrg_toggle_mid.png", 346,-10,108,300) 
emer_dn = img_add("lrg_toggle_down.png", 346,-10,108,300) visible(emer_dn, false)
img_elt_up = img_add("lrg_toggle_up.png",  534,-10,108,300) 
img_elt_dn = img_add("lrg_toggle_down.png", 534,-10,108,300) visible(img_elt_dn, false)

--Night Graphics
nosmk_dn_night = img_add("toggle_down_night.png", -25,61,181,179)
nosmk_mid_night = img_add("toggle_mid_night.png", -25,61,181,179)
nosmk_up_night = img_add("toggle_up_night.png", -25,61,181,179)
seat_dn_night = img_add("toggle_down_night.png", 105,61,181,179)
seat_mid_night = img_add("toggle_mid_night.png", 105,61,181,179)
seat_up_night = img_add("toggle_up_night.png", 105,61,181,179)
emer_up_night = img_add("lrg_toggle_up_night.png", 346,-10,108,300)
emer_mid_night = img_add("lrg_toggle_mid_night.png", 346,-10,108,300) 
emer_dn_night = img_add("lrg_toggle_down_night.png", 346,-10,108,300)
img_elt_up_night = img_add("lrg_toggle_up_night.png", 534,-10,108,300) 
img_elt_dn_night = img_add("lrg_toggle_down_night.png", 534,-10,108,300)

-- Ambient Light Control
function ss_ambient_darkness(value)
    opacity(img_bg_night, value, "LOG", 0.04)
    opacity(nosmk_up_night, value, "LOG", 0.04)
    opacity(nosmk_dn_night, value, "LOG", 0.04)
    opacity(nosmk_mid_night, value, "LOG", 0.04)
    opacity(seat_dn_night, value, "LOG", 0.04) 
    opacity(seat_mid_night, value, "LOG", 0.04) 
    opacity(seat_up_night, value, "LOG", 0.04) 
    opacity(emer_up_night, value, "LOG", 0.04) 
    opacity(emer_mid_night, value, "LOG", 0.04) 
    opacity(emer_dn_night, value, "LOG", 0.04) 
    opacity(img_elt_up_night, value, "LOG", 0.04) 
    opacity(img_elt_dn_night, value, "LOG", 0.04)     
end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)
---------------------------------------------
----------------------------------------------
--No Smoking Switch

--[[
SWITCH POSITIONS:
    2 - ON
    1 - OFF
    0 - AUTO
]]--
function cb_nosmk_pos_dec()
    if current_pos_nosmk == 0  then
        fs2020_variable_write("L:ASCRJ_OVHD_NO_SMOKING", "Number", 1)
end
    if current_pos_nosmk == 1  then
        fs2020_variable_write("L:ASCRJ_OVHD_NO_SMOKING", "Number", 2)
   end   
end

function cb_nosmk_pos_inc()
        if current_pos_nosmk == 2  then
        fs2020_variable_write("L:ASCRJ_OVHD_NO_SMOKING", "Number", 1)
end
    if current_pos_nosmk == 1  then
        fs2020_variable_write("L:ASCRJ_OVHD_NO_SMOKING", "Number",0)
   end
    
end

btn_nosmk_up = button_add(nil, nil, 30, 140, 75, 75, cb_nosmk_pos_inc)
btn_nosmk_dn = button_add(nil, nil, 30, 65, 75, 75, cb_nosmk_pos_dec)

function new_nosmk_pos(pos)
    if pos == 0 then
        visible(nosmk_up , false) visible(nosmk_up_night, false)
        visible(nosmk_mid , false) visible(nosmk_mid_night, false)
        visible(nosmk_dn , true) visible(nosmk_dn_night, true)
    elseif pos == 1 then 
        visible(nosmk_up , false)   visible(nosmk_up_night, false)
        visible(nosmk_mid , true) visible(nosmk_mid_night, true)
        visible(nosmk_dn , false) visible(nosmk_dn_night, false)
    elseif pos == 2 then 
        visible(nosmk_up , true) visible(nosmk_up_night, true)
        visible(nosmk_mid , false) visible(nosmk_mid_night, false)
        visible(nosmk_dn , false) visible(nosmk_dn_night, false)
    end
current_pos_nosmk = pos
end

fs2020_variable_subscribe("L:ASCRJ_OVHD_NO_SMOKING", "Number", new_nosmk_pos)

-- Seat Belt Switch
--[[
SWITCH POSITIONS:
    2 - ON
    1 - OFF
    0 - AUTO
]]--

function cb_seat_pos_dec()
    if current_pos_seat == 0  then
        fs2020_variable_write("L:ASCRJ_OVHD_SEAT_BELTS", "Number", 1)
end
    if current_pos_seat == 1  then
        fs2020_variable_write("L:ASCRJ_OVHD_SEAT_BELTS", "Number", 2)
   end   
end

function cb_seat_pos_inc()
        if current_pos_seat == 2  then
        fs2020_variable_write("L:ASCRJ_OVHD_SEAT_BELTS", "Number", 1)
end
    if current_pos_seat == 1  then
        fs2020_variable_write("L:ASCRJ_OVHD_SEAT_BELTS", "Number",0)
   end
    
end

btn_seat_up = button_add(nil, nil, 158, 140, 75, 75, cb_seat_pos_inc)
btn_seat_dn = button_add(nil, nil, 158, 65, 75, 75, cb_seat_pos_dec)

function new_seat_pos(pos)
    if pos == 0 then
        visible(seat_up , false) visible(seat_up_night, false)
        visible(seat_mid , false) visible(seat_mid_night, false)
        visible(seat_dn , true) visible(seat_dn_night, true)
    elseif pos == 1 then 
        visible(seat_up , false) visible(seat_up_night, false)
        visible(seat_mid , true) visible(seat_mid_night, true)
        visible(seat_dn , false)  visible(seat_dn_night, false)
    elseif pos == 2 then 
        visible(seat_up , true) visible(seat_up_night, true)
        visible(seat_mid , false) visible(seat_mid_night, false)
        visible(seat_dn , false) visible(seat_dn_night, false)
    end
current_pos_seat = pos
end

fs2020_variable_subscribe("L:ASCRJ_OVHD_SEAT_BELTS", "Number", new_seat_pos)


-- Emergency Lights
--[[SWITCH POSITIONS:
    2 - ON
    1 - OFF
    0 - AUTO
]]--

function cb_emer_pos_dec()
    if current_pos_emer == 0  then
        fs2020_variable_write("L:ASCRJ_OVHD_EMER_LTS", "Number", 1)
end
    if current_pos_emer == 1  then
        fs2020_variable_write("L:ASCRJ_OVHD_EMER_LTS", "Number", 2)
   end   
end

function cb_emer_pos_inc()
        if current_pos_emer == 2  then
        fs2020_variable_write("L:ASCRJ_OVHD_EMER_LTS", "Number", 1)
end
    if current_pos_emer == 1  then
        fs2020_variable_write("L:ASCRJ_OVHD_EMER_LTS", "Number",0)
   end
end

btn_emer_up = button_add(nil, nil, 355, 140, 75, 75, cb_emer_pos_inc)
btn_emer_dn = button_add(nil, nil, 355, 65, 75, 75, cb_emer_pos_dec)

function new_emer_pos(pos)
    if pos == 0 then
        visible(emer_up , false) visible(emer_up_night, false)
        visible(emer_mid , false)  visible(emer_mid_night, false)
        visible(emer_dn , true) visible(emer_dn_night, true)
    elseif pos == 1 then 
        visible(emer_up , false)   visible(emer_up_night, false)
        visible(emer_mid , true) visible(emer_mid_night, true)
        visible(emer_dn , false) visible(emer_dn_night, false)
    elseif pos == 2 then 
        visible(emer_up , true) visible(emer_up_night, true)
        visible(emer_mid , false) visible(emer_mid_night, false)
        visible(emer_dn , false)   visible(emer_dn_night, false)
    end
    current_pos_emer = pos
end

fs2020_variable_subscribe("L:ASCRJ_OVHD_EMER_LTS", "Number", new_emer_pos)

-- ELT
fs2020_variable_subscribe("L:ASCRJ_OVHD_ELT", "Number", 
        function (state)
            switch_set_position(sw_elt, state)
            visible(img_elt_up, state ==0)
            visible(img_elt_up_night, state ==0)
            visible(img_elt_dn, state ==1)
            visible(img_elt_dn_night, state ==1)   
        end)

function cb_sw_elt(position)
    if (position == 0 ) then
        fs2020_variable_write("L:ASCRJ_OVHD_ELT","Number",1) 
    elseif (position == 1 ) then
        fs2020_variable_write("L:ASCRJ_OVHD_ELT","Number",0) 
    end 
end
sw_elt= switch_add(nil,nil, 498,61,181,179, cb_sw_elt)

