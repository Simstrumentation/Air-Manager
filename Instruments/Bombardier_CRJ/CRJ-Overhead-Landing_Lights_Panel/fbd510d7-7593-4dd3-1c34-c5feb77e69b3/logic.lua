--[[
******************************************************************************************
**************Bombardier CRJ-Overhead-Landing Lights Panel**************************
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
msfs_variable_subscribe("A:Light Potentiometer:2", "Number",
                          "ELECTRICAL MASTER BATTERY","Bool", ss_backlighting)

---------------------------------------------
--Day graphics
img_lft_mid = img_add("toggle_mid.png", -24,61,181,179) 
img_lft_dn = img_add("toggle_down.png", -24,61,181,179) visible(img_lft_dn, false)
img_nose_mid = img_add("toggle_mid.png", 105,61,181,179) 
img_nose_dn = img_add("toggle_down.png", 105,61,181,179) visible(img_nose_dn, false)
img_rgt_mid = img_add("toggle_mid.png",  230,61,181,179) 
img_rgt_dn = img_add("toggle_down.png",  230,61,181,179) visible(img_rgt_dn, false)
img_taxi_mid = img_add("toggle_mid.png",  429,61,181,179) 
img_taxi_dn = img_add("toggle_down.png", 429,61,181,179) visible(img_taxi_dn, false)
--Night Graphics
img_lft_mid_night = img_add("toggle_mid_night.png", -24,61,181,179) 
img_lft_dn_night = img_add("toggle_down_night.png", -24,61,181,179) 
img_nose_mid_night = img_add("toggle_mid_night.png", 105,61,181,179) 
img_nose_dn_night = img_add("toggle_down_night.png", 105,61,181,179)
img_rgt_mid_night = img_add("toggle_mid_night.png",  230,61,181,179) 
img_rgt_dn_night = img_add("toggle_down_night.png",  230,61,181,179)
img_taxi_mid_night = img_add("toggle_mid_night.png",  429,61,181,179) 
img_taxi_dn_night = img_add("toggle_down_night.png", 429,61,181,179)


-- Ambient Light Control
function ss_ambient_darkness(value)
    opacity(img_bg_night, value, "LOG", 0.04)
    opacity(img_lft_mid_night, value, "LOG", 0.04)
    opacity(img_lft_dn_night, value, "LOG", 0.04)
    opacity(img_nose_mid_night, value, "LOG", 0.04) 
    opacity(img_nose_dn_night, value, "LOG", 0.04) 
    opacity(img_rgt_mid_night, value, "LOG", 0.04) 
    opacity(img_rgt_dn_night, value, "LOG", 0.04) 
    opacity(img_taxi_mid_night, value, "LOG", 0.04) 
    opacity(img_taxi_dn_night, value, "LOG", 0.04) 

 
end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)
---------------------------------------------
----------------------------------------------
--Left Switch
msfs_variable_subscribe("L:ASCRJ_OVHD_LDG_LEFT", "Number", 
        function (state)
            switch_set_position(sw_lft, state)
            visible(img_lft_mid, state ==0)
            visible(img_lft_mid_night, state ==0)
            visible(img_lft_dn, state ==1)
            visible(img_lft_dn_night, state ==1)  
        end)

function cb_sw_lft(position)
    if (position == 0 ) then
        msfs_variable_write("L:ASCRJ_OVHD_LDG_LEFT","Number",1) 
    elseif (position == 1 ) then
        msfs_variable_write("L:ASCRJ_OVHD_LDG_LEFT","Number",0) 
    end 
end

sw_lft= switch_add(nil,nil, -24,61,181,179, cb_sw_lft)

--Nose Switch
msfs_variable_subscribe("L:ASCRJ_OVHD_LDG_NOSE", "Number", 
        function (state)
            switch_set_position(sw_nose, state)
            visible(img_nose_mid, state ==0)
            visible(img_nose_mid_night, state ==0)
            visible(img_nose_dn, state ==1)
            visible(img_nose_dn_night, state ==1)            
        end)

function cb_sw_nose(position)
    if (position == 0 ) then
        msfs_variable_write("L:ASCRJ_OVHD_LDG_NOSE","Number",1) 
    elseif (position == 1 ) then
        msfs_variable_write("L:ASCRJ_OVHD_LDG_NOSE","Number",0) 
    end 
end

sw_nose= switch_add(nil,nil, 105,61,181,179, cb_sw_nose)

--Right Switch
msfs_variable_subscribe("L:ASCRJ_OVHD_LDG_RIGHT", "Number", 
        function (state)
            switch_set_position(sw_rgt, state)
            visible(img_rgt_mid, state ==0)
            visible(img_rgt_mid_night, state ==0)
            visible(img_rgt_dn, state ==1)
            visible(img_rgt_dn_night, state ==1)            
        end)

function cb_sw_rgt(position)
    if (position == 0 ) then
        msfs_variable_write("L:ASCRJ_OVHD_LDG_RIGHT","Number",1) 
    elseif (position == 1 ) then
        msfs_variable_write("L:ASCRJ_OVHD_LDG_RIGHT","Number",0) 
    end 
end

sw_rgt= switch_add(nil,nil, 230,61,181,179, cb_sw_rgt)

--Recog Taxi Lights Switch
msfs_variable_subscribe("L:ASCRJ_OVHD_TAXI", "Number", 
        function (state)
            switch_set_position(sw_taxi, state)
            visible(img_taxi_mid, state ==0)
            visible(img_taxi_mid_night, state ==0)
            visible(img_taxi_dn, state ==1)
            visible(img_taxi_dn_night, state ==1)            
        end)

function cb_sw_taxi(position)
    if (position == 0 ) then
        msfs_variable_write("L:ASCRJ_OVHD_TAXI","Number",1) 
    elseif (position == 1 ) then
        msfs_variable_write("L:ASCRJ_OVHD_TAXI","Number",0) 
    end 
end

sw_taxi= switch_add(nil,nil, 429,61,181,179, cb_sw_taxi)