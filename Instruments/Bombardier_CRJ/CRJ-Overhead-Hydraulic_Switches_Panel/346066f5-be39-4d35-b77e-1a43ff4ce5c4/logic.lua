--[[
******************************************************************************************
*****************Bombardier CRJ-Overhead-Hydraulic Switches Panel*********************
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

function ss_backlighting(value, pwr)
    value = var_round(value*10,2) --value*0.038 if using Lvar L:ASCRJ_INTL_OVHD
    if value == 0.0 or (pwr == false ) then 
        opacity(img_labels_backlight, 0, "LOG", 0.04)                
    else
        opacity(img_labels_backlight, (value), "LOG", 0.04)
    end
end
msfs_variable_subscribe("A:Light Potentiometer:2", "Number",
                                              "A:CIRCUIT GENERAL PANEL ON","Bool", ss_backlighting)
---------------------------------------------
--Day Graphics
img_sw_hyd_1_up = img_add("toggle_up.png", 63, 36, 181,179)
img_sw_hyd_1_mid = img_add("toggle_mid.png",  63, 36, 181,179) visible(img_sw_hyd_1_mid, false)
img_sw_hyd_1_dn = img_add("toggle_down.png",  63, 36, 181,179) visible(img_sw_hyd_1_dn, false)
img_sw_hyd_3a_mid = img_add("toggle_mid.png", 190, 36, 181,179)
img_sw_hyd_3a_dn = img_add("toggle_down.png", 190, 36, 181,179) visible(img_sw_hyd_3a_dn, false)           
img_sw_hyd_3b_up = img_add("toggle_up.png", 317, 36, 181,179)
img_sw_hyd_3b_mid = img_add("toggle_mid.png", 317, 36, 181,179) visible(img_sw_hyd_3b_mid, false)
img_sw_hyd_3b_dn = img_add("toggle_down.png", 317, 36, 181,179) visible(img_sw_hyd_3b_dn, false)
img_sw_hyd_2_up = img_add("toggle_up.png", 444, 36, 181,179)
img_sw_hyd_2_mid = img_add("toggle_mid.png", 444, 36, 181,179) visible(img_sw_hyd_2_mid, false)
img_sw_hyd_2_dn = img_add("toggle_down.png", 444, 36, 181,179) visible(img_sw_hyd_2_dn, false)
--Night Graphics
img_sw_hyd_1_up_night = img_add("toggle_up_night.png", 63, 36, 181,179)
img_sw_hyd_1_mid_night = img_add("toggle_mid_night.png",  63, 36, 181,179)
img_sw_hyd_1_dn_night = img_add("toggle_down_night.png",  63, 36, 181,179) 
img_sw_hyd_3a_mid_night = img_add("toggle_mid_night.png", 190, 36, 181,179)
img_sw_hyd_3a_dn_night = img_add("toggle_down_night.png", 190, 36, 181,179)     
img_sw_hyd_3b_up_night = img_add("toggle_up_night.png", 317, 36, 181,179)
img_sw_hyd_3b_mid_night = img_add("toggle_mid_night.png", 317, 36, 181,179) 
img_sw_hyd_3b_dn_night = img_add("toggle_down_night.png", 317, 36, 181,179)
img_sw_hyd_2_up_night = img_add("toggle_up_night.png", 444, 36, 181,179)
img_sw_hyd_2_mid_night = img_add("toggle_mid_night.png", 444, 36, 181,179)
img_sw_hyd_2_dn_night = img_add("toggle_down_night.png", 444, 36, 181,179)
-----------------------------------------------------
-- Ambient Light Control
function ss_ambient_darkness(value)
    opacity(img_bg_night, value, "LOG", 0.04)      
    opacity(img_sw_hyd_1_up_night, value, "LOG", 0.04)      
   opacity(img_sw_hyd_1_mid_night, value, "LOG", 0.04)      
   opacity(img_sw_hyd_1_dn_night, value, "LOG", 0.04)      
   opacity(img_sw_hyd_3a_mid_night, value, "LOG", 0.04)      
   opacity(img_sw_hyd_3a_dn_night, value, "LOG", 0.04)      
   opacity(img_sw_hyd_3b_up_night, value, "LOG", 0.04)      
   opacity(img_sw_hyd_3b_mid_night, value, "LOG", 0.04)      
   opacity(img_sw_hyd_3b_dn_night, value, "LOG", 0.04)      
   opacity(img_sw_hyd_2_up_night, value, "LOG", 0.04)      
   opacity(img_sw_hyd_2_mid_night, value, "LOG", 0.04)      
   opacity(img_sw_hyd_2_dn_night, value, "LOG", 0.04)      
end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)
-------------------------------------------------------------
-------------------------------------------------------------
--Hyrdaulic 1

--[[
SWITCH POSITIONS:
    2 - ON
    1 - OFF
    0 - AUTO
]]--
function cb_hyd_1_pos_dec()
    if current_pos_hyd_1 == 0  then
        msfs_variable_write("L:ASCRJ_HYDR_PUMP_1", "Number", 1)
end
    if current_pos_hyd_1 == 1  then
        msfs_variable_write("L:ASCRJ_HYDR_PUMP_1", "Number", 2)
   end   
end

function cb_hyd_1_pos_inc()
        if current_pos_hyd_1 == 2  then
        msfs_variable_write("L:ASCRJ_HYDR_PUMP_1", "Number", 1)
end
    if current_pos_hyd_1 == 1  then
        msfs_variable_write("L:ASCRJ_HYDR_PUMP_1", "Number",0)
   end
end
btn_hyd_1_up = button_add(nil, nil, 117, 50, 75, 60, cb_hyd_1_pos_inc)
btn_hyd_1_dn = button_add(nil, nil, 117, 120, 75, 60, cb_hyd_1_pos_dec)

function new_hyd_1_pos(pos)
    if pos == 0 then
        visible(img_sw_hyd_1_dn, false) visible(img_sw_hyd_1_dn_night, false)
        visible(img_sw_hyd_1_mid, false) visible(img_sw_hyd_1_mid_night, false)
        visible(img_sw_hyd_1_up, true)  visible(img_sw_hyd_1_up_night, true)
    elseif pos == 1 then 
        visible(img_sw_hyd_1_dn, false) visible(img_sw_hyd_1_dn_night, false)
        visible(img_sw_hyd_1_mid, true) visible(img_sw_hyd_1_mid_night, true)
        visible(img_sw_hyd_1_up, false)  visible(img_sw_hyd_1_up_night, false)
    elseif pos == 2 then 
        visible(img_sw_hyd_1_dn, true) visible(img_sw_hyd_1_dn_night, true)
        visible(img_sw_hyd_1_mid, false) visible(img_sw_hyd_1_mid_night, false)
        visible(img_sw_hyd_1_up, false) visible(img_sw_hyd_1_up_night, false)
    end
current_pos_hyd_1 = pos
end
msfs_variable_subscribe("L:ASCRJ_HYDR_PUMP_1", "Number", new_hyd_1_pos)

--- Hydraulic 3B

--[[
SWITCH POSITIONS:
    2 - ON
    1 - OFF
    0 - AUTO
]]--
function cb_hyd_3b_pos_dec()
    if current_pos_hyd_3b == 0  then
        msfs_variable_write("L:ASCRJ_HYDR_PUMP_3B", "Number", 1)
end
    if current_pos_hyd_3b == 1  then
        msfs_variable_write("L:ASCRJ_HYDR_PUMP_3B", "Number", 2)
   end   
end

function cb_hyd_3b_pos_inc()
        if current_pos_hyd_3b == 2  then
        msfs_variable_write("L:ASCRJ_HYDR_PUMP_3B", "Number", 1)
end
    if current_pos_hyd_3b == 1  then
        msfs_variable_write("L:ASCRJ_HYDR_PUMP_3B", "Number",0)
   end
    
end

btn_hyd_3b_up = button_add(nil, nil, 372, 50, 75, 60, cb_hyd_3b_pos_inc)
btn_hyd_3b_dn = button_add(nil, nil, 372, 120, 75, 60, cb_hyd_3b_pos_dec)

function new_hyd_3b_pos(pos)
    if pos == 0 then
        visible(img_sw_hyd_3b_dn , false) visible(img_sw_hyd_3b_dn_night, false)
        visible(img_sw_hyd_3b_mid , false) visible(img_sw_hyd_3b_mid_night , false)
        visible(img_sw_hyd_3b_up, true) visible(img_sw_hyd_3b_up_night, true)
    elseif pos == 1 then 
        visible(img_sw_hyd_3b_dn , false) visible(img_sw_hyd_3b_dn_night , false)
        visible(img_sw_hyd_3b_mid , true) visible(img_sw_hyd_3b_mid_night , true)
        visible(img_sw_hyd_3b_up , false) visible(img_sw_hyd_3b_up_night , false)
    elseif pos == 2 then 
        visible(img_sw_hyd_3b_dn , true)  visible(img_sw_hyd_3b_dn_night , true)
        visible(img_sw_hyd_3b_mid , false) visible(img_sw_hyd_3b_mid_night , false)
        visible(img_sw_hyd_3b_up , false) visible(img_sw_hyd_3b_up_night , false)
    end
current_pos_hyd_3b = pos
end
msfs_variable_subscribe("L:ASCRJ_HYDR_PUMP_3B", "Number", new_hyd_3b_pos)


--- Hydraulic 2
--[[
SWITCH POSITIONS:
    2 - ON
    1 - OFF
    0 - AUTO
]]--

function cb_hyd_2_pos_dec()
    if current_pos_hyd_2 == 0  then
        msfs_variable_write("L:ASCRJ_HYDR_PUMP_2", "Number", 1)
end
    if current_pos_hyd_2 == 1  then
        msfs_variable_write("L:ASCRJ_HYDR_PUMP_2", "Number", 2)
   end   
end

function cb_hyd_2_pos_inc()
        if current_pos_hyd_2 == 2  then
        msfs_variable_write("L:ASCRJ_HYDR_PUMP_2", "Number", 1)
end
    if current_pos_hyd_2 == 1  then
        msfs_variable_write("L:ASCRJ_HYDR_PUMP_2", "Number",0)
   end
end
btn_hyd_2_up = button_add(nil, nil, 500, 50, 75, 60, cb_hyd_2_pos_inc)
btn_hyd_2_dn = button_add(nil, nil, 500, 120, 75, 60, cb_hyd_2_pos_dec)

function new_hyd_2_pos(pos)
    if pos == 0 then
        visible(img_sw_hyd_2_dn, false)  visible(img_sw_hyd_2_dn_night, false)
        visible(img_sw_hyd_2_mid, false) visible(img_sw_hyd_2_mid_night, false)
        visible(img_sw_hyd_2_up, true) visible(img_sw_hyd_2_up_night, true)
    elseif pos == 1 then 
        visible(img_sw_hyd_2_dn, false) visible(img_sw_hyd_2_dn_night, false)
        visible(img_sw_hyd_2_mid, true) visible(img_sw_hyd_2_mid_night, true)
        visible(img_sw_hyd_2_up, false)  visible(img_sw_hyd_2_up_night, false)
    elseif pos == 2 then 
        visible(img_sw_hyd_2_dn, true)  visible(img_sw_hyd_2_dn_night, true)
        visible(img_sw_hyd_2_mid, false) visible(img_sw_hyd_2_mid_night, false)
        visible(img_sw_hyd_2_up, false)  visible(img_sw_hyd_2_up_night, false)
    end
current_pos_hyd_2 = pos
end
msfs_variable_subscribe("L:ASCRJ_HYDR_PUMP_2", "Number", new_hyd_2_pos)

-- Hydraulic 3A 
msfs_variable_subscribe("L:ASCRJ_HYDR_PUMP_3A", "Number", 
        function (state)
            switch_set_position(sw_hyd_3a, state)
            visible(img_sw_hyd_3a_mid, state ==0)
            visible(img_sw_hyd_3a_mid_night, state ==0)
            visible(img_sw_hyd_3a_dn, state ==1)
            visible(img_sw_hyd_3a_dn_night, state ==1)            
        end)

function cb_sw_hyd_3a(position)
    if (position == 1 ) then
        msfs_variable_write("L:ASCRJ_HYDR_PUMP_3A","Number",0) 
    elseif (position == 0 ) then
        msfs_variable_write("L:ASCRJ_HYDR_PUMP_3A","Number",1) 
    end 
end
sw_hyd_3a = switch_add(nil,nil, 235,70,75,120, cb_sw_hyd_3a)

