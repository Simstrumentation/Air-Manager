--[[
******************************************************************************************
******************Bombardier CRJ-Overhead-Misc Lights Panel************************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation
   
- **v1.0** 03-24-2022
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
        opacity(img_backlight_knob_ovhd, 0, "LOG", 0.04)                 
    else
        opacity(img_labels_backlight, (value), "LOG", 0.04)
        opacity(img_backlight_knob_ovhd, (value), "LOG", 0.04)        
    end
end
msfs_variable_subscribe("A:Light Potentiometer:2", "Number",
                                              "A:CIRCUIT GENERAL PANEL ON","Bool", ss_backlighting)
---------------------------------------------
--Day Graphics
img_sw_dome_mid = img_add("toggle_mid.png",  129,76,181,179)
img_sw_dome_dn = img_add("toggle_down.png",  129,76,181,179) visible(img_sw_dome_dn, false)
img_sw_complt_up = img_add("toggle_up.png", 264,76,181,179)visible(img_sw_complt_up, false)
img_sw_complt_mid = img_add("toggle_mid.png", 264,76,181,179) 
img_sw_complt_dn = img_add("toggle_down.png", 264,76,181,179) visible(img_sw_complt_dn, false)

img_knob_dspl = img_add("round_knob.png", 409,70,130,130)


--Night Graphics
img_sw_dome_mid_night = img_add("toggle_mid_night.png",  129,76,181,179)
img_sw_dome_dn_night = img_add("toggle_down_night.png",  129,76,181,179) 
img_sw_complt_up_night = img_add("toggle_up_night.png", 264,76,181,179)
img_sw_complt_mid_night = img_add("toggle_mid_night.png", 264,76,181,179) 
img_sw_complt_dn_night = img_add("toggle_down_night.png", 264,76,181,179)
img_knob_dspl_night = img_add("round_knob_night.png", 409,70,130,130)
img_backlight_knob_ovhd= img_add("backlight_round_knob.png", 409,70,130,130)

-----------------------------------------------------
-- Ambient Light Control
function ss_ambient_darkness(value)
    opacity(img_bg_night, value, "LOG", 0.04)
    opacity(img_sw_dome_mid_night, value, "LOG", 0.04)
    opacity(img_sw_dome_dn_night, value, "LOG", 0.04)
    opacity(img_sw_complt_up_night, value, "LOG", 0.04)
    opacity(img_sw_complt_mid_night, value, "LOG", 0.04)          
    opacity(img_sw_complt_dn_night, value, "LOG", 0.04)
    opacity(img_knob_dspl_night, value, "LOG", 0.04)  
   
end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)
-------------------------------------------------------------
-------------------------------------------------------------
--Dome Light

msfs_variable_subscribe("L:ASCRJ_INTL_DOME", "Number", 
        function (state)
            switch_set_position(sw_dome, state)
            visible(img_sw_dome_mid, state ==0)
            visible(img_sw_dome_mid_night, state ==0)
            visible(img_sw_dome_dn, state ==1)
            visible(img_sw_dome_dn_night, state ==1)   
        end)

function cb_sw_dome(position)
    if (position == 1 ) then
        msfs_variable_write("L:ASCRJ_INTL_DOME","Number",0) 
    elseif (position == 0 ) then
        msfs_variable_write("L:ASCRJ_INTL_DOME","Number",1) 
    end 
end

sw_dome= switch_add(nil,nil, 129,76,181,179, cb_sw_dome)

--- Stand By Compass Light
--[[
SWITCH POSITIONS:
    2 - DIM
    1 - OFF
    0 - ON
]]--

function cb_complt_pos_dec()
    if current_pos_complt == 0  then
        msfs_variable_write("L:ASCRJ_INTL_COMP", "Number", 1)
end
    if current_pos_complt == 1  then
        msfs_variable_write("L:ASCRJ_INTL_COMP", "Number", 2)
   end   
end

function cb_complt_pos_inc()
        if current_pos_complt == 2  then
        msfs_variable_write("L:ASCRJ_INTL_COMP", "Number", 1)
end
    if current_pos_complt == 1  then
        msfs_variable_write("L:ASCRJ_INTL_COMP", "Number",0)
   end
    
end

btn_complt_up = button_add(nil, nil, 325, 60, 65, 80, cb_complt_pos_inc)
btn_complt_dn = button_add(nil, nil, 325, 145, 65, 80, cb_complt_pos_dec)

function new_complt_pos(pos)
    if pos == 0 then
        --  switch_set_position(start_switch_id, 0)
        visible(img_sw_complt_dn, false) visible(img_sw_complt_dn_night, false)
        visible(img_sw_complt_mid, false) visible(img_sw_complt_mid_night, false)
        visible(img_sw_complt_up, true) visible(img_sw_complt_up_night, true)
    elseif pos == 1 then 
        -- switch_set_position(start_switch_id, 1)
        visible(img_sw_complt_dn, false)  visible(img_sw_complt_dn_night, false)
        visible(img_sw_complt_mid, true) visible(img_sw_complt_mid_night, true)
        visible(img_sw_complt_up, false) visible(img_sw_complt_up_night, false)
    elseif pos == 2 then 
        --  switch_set_position(start_switch_id, 2)
        visible(img_sw_complt_dn, true) visible(img_sw_complt_dn_night, true)
        visible(img_sw_complt_mid, false) visible(img_sw_complt_mid_night, false)
        visible(img_sw_complt_up, false) visible(img_sw_complt_up_night, false)
    end
current_pos_complt = pos
end

msfs_variable_subscribe("L:ASCRJ_INTL_COMP", "Number", new_complt_pos)


--- Overhead Panel Light

local local_light_dspl = 0


msfs_variable_subscribe("L:ASCRJ_INTL_OVHD", "Number",     
        function (state)
            local_light_dspl = state
             rotate(img_knob_dspl, ((local_light_dspl*10)-120))
             rotate(img_knob_dspl_night, ((local_light_dspl*10)-120))             
             rotate(img_backlight_knob_ovhd, ((local_light_dspl*10)-120))            
        end) 

function cb_light_dspl(direction) 
    if direction == 1 then msfs_variable_write("L:ASCRJ_INTL_OVHD", "Number", var_cap(local_light_dspl+1,0,26) ) 
    else msfs_variable_write("L:ASCRJ_INTL_OVHD", "Number", var_cap(local_light_dspl-1,0,26) )
    end 
end
dial_light_dspl = dial_add(nil, 420,85,112,112, cb_light_dspl)