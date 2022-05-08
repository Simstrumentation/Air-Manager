--[[
******************************************************************************************
*****************Bombardier CRJ-Overhead-Anti-Ice Panel******************************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation
   
- **v1.0** 03-24-2022
    - Original Panel Created

##Left To Do:
    - Switches edges need blurring
	
##Notes:
    - N/A
    
******************************************************************************************
--]]

click_snd = sound_add("click.wav")

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
                          "A:CIRCUIT GENERAL PANEL ON","Bool", ss_backlighting)

--Day Graphics
img_sw_wing_mid = img_add("toggle_mid.png", 74,76,181,179) 
img_sw_wing_dn = img_add("toggle_down.png", 74,76,181,179) visible(img_sw_wing_dn, false)
img_sw_cowl_L_mid = img_add("toggle_mid.png", 242,76,181,179) 
img_sw_cowl_L_dn = img_add("toggle_down.png", 242,76,181,179) visible(img_sw_cowl_L_dn, false)
img_sw_cowl_R_mid = img_add("toggle_mid.png", 366,76,181,179) 
img_sw_cowl_R_dn = img_add("toggle_down.png", 366,76,181,179) visible(img_sw_cowl_R_dn, false)

img_wshld_L_up = img_add("toggle_up.png", 24,251,181,179)
img_wshld_L_mid = img_add("toggle_mid.png", 24,251,181,179) visible(img_wshld_L_mid, false)
img_wshld_L_dn = img_add("toggle_down.png", 24,251,181,179) visible(img_wshld_L_dn, false)
img_wshld_R_up = img_add("toggle_up.png", 231,251,181,179)
img_wshld_R_mid = img_add("toggle_mid.png", 231,251,181,179) visible(img_wshld_R_mid, false)
img_wshld_R_dn = img_add("toggle_down.png", 231,251,181,179) visible(img_wshld_R_dn, false)
img_sw_pheat_L_mid = img_add("toggle_mid.png", 364,251,181,179) 
img_sw_pheat_L_dn = img_add("toggle_down.png", 364,251,181,179) visible(img_sw_pheat_L_dn, false)
img_sw_pheat_R_mid = img_add("toggle_mid.png", 489,251,181,179) 
img_sw_pheat_R_dn = img_add("toggle_down.png", 489,251,181,179) visible(img_sw_pheat_R_dn, false)
--Night Graphics
img_sw_wing_mid_night = img_add("toggle_mid_night.png", 74,76,181,179) 
img_sw_wing_dn_night = img_add("toggle_down_night.png", 74,76,181,179) visible(img_sw_wing_dn_night, false)
img_sw_cowl_L_mid_night = img_add("toggle_mid_night.png", 242,76,181,179) 
img_sw_cowl_L_dn_night = img_add("toggle_down_night.png", 242,76,181,179) visible(img_sw_cowl_L_dn_night, false)
img_sw_cowl_R_mid_night = img_add("toggle_mid_night.png", 366,76,181,179) 
img_sw_cowl_R_dn_night = img_add("toggle_down_night.png", 366,76,181,179) visible(img_sw_cowl_R_dn_night, false)

img_wshld_L_up_night = img_add("toggle_up_night.png", 24,251,181,179)
img_wshld_L_mid_night = img_add("toggle_mid_night.png", 24,251,181,179) visible(img_wshld_L_mid_night, false)
img_wshld_L_dn_night = img_add("toggle_down_night.png", 24,251,181,179) visible(img_wshld_L_dn_night, false)
img_wshld_R_up_night = img_add("toggle_up_night.png", 231,251,181,179)
img_wshld_R_mid_night = img_add("toggle_mid_night.png", 231,251,181,179) visible(img_wshld_R_mid_night, false)
img_wshld_R_dn_night = img_add("toggle_down_night.png", 231,251,181,179) visible(img_wshld_R_dn_night, false)

img_sw_pheat_L_mid_night = img_add("toggle_mid_night.png", 364,251,181,179) 
img_sw_pheat_L_dn_night = img_add("toggle_down_night.png", 364,251,181,179) visible(img_sw_pheat_L_dn_night, false)
img_sw_pheat_R_mid_night = img_add("toggle_mid_night.png", 489,251,181,179) 
img_sw_pheat_R_dn_night = img_add("toggle_down_night.png", 489,251,181,179) visible(img_sw_pheat_R_dn_night, false)

-- Ambient Light Control
function ss_ambient_darkness(value)
    opacity(img_bg_night, value, "LOG", 0.04)
    opacity(img_sw_wing_mid_night, value, "LOG", 0.04)
    opacity(img_sw_wing_dn_night, value, "LOG", 0.04)        
    opacity(img_sw_cowl_L_mid_night, value, "LOG", 0.04)        
    opacity(img_sw_cowl_L_dn_night, value, "LOG", 0.04)     
    opacity(img_sw_cowl_R_mid_night, value, "LOG", 0.04)        
    opacity(img_sw_cowl_R_dn_night, value, "LOG", 0.04)       
    opacity(img_wshld_L_up_night, value, "LOG", 0.04)      
    opacity(img_wshld_L_mid_night, value, "LOG", 0.04) 
    opacity(img_wshld_L_dn_night, value, "LOG", 0.04)            
    opacity(img_wshld_R_up_night, value, "LOG", 0.04)      
    opacity(img_wshld_R_mid_night, value, "LOG", 0.04) 
    opacity(img_wshld_R_dn_night, value, "LOG", 0.04)     
    opacity(img_sw_pheat_L_mid_night, value, "LOG", 0.04)  
    opacity(img_sw_pheat_L_dn_night, value, "LOG", 0.04)       
    opacity(img_sw_pheat_R_mid_night, value, "LOG", 0.04)  
    opacity(img_sw_pheat_R_dn_night, value, "LOG", 0.04)       
end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)
---------------------------------------------
----------------------------------------------
--Wing
fs2020_variable_subscribe("L:ASCRJ_AICE_WING", "Number", 
        function (state)
            switch_set_position(sw_wing, state)
            visible(img_sw_wing_mid, state ==0)
            visible(img_sw_wing_mid_night, state ==0)
            visible(img_sw_wing_dn, state ==1)
            visible(img_sw_wing_dn_night, state ==1)               
        end)

sw_wing= switch_add(nil,nil, 74,76,181,179,
    function (position)
        if (position == 1 ) then
            fs2020_variable_write("L:ASCRJ_AICE_WING","Number",0) 
        elseif (position == 0 ) then
            fs2020_variable_write("L:ASCRJ_AICE_WING","Number",1) 
        end
    end)

--Cowl L
fs2020_variable_subscribe("L:ASCRJ_AICE_COWL_L", "Number", 
        function (state)
            switch_set_position(sw_cowl_L, state)
            visible(img_sw_cowl_L_mid, state ==0)
            visible(img_sw_cowl_L_mid_night, state ==0)
            visible(img_sw_cowl_L_dn, state ==1)
            visible(img_sw_cowl_L_dn_night, state ==1)              
        end)

sw_cowl_L= switch_add(nil,nil, 242,76,181,179,
    function (position)
        if (position == 1 ) then
            fs2020_variable_write("L:ASCRJ_AICE_COWL_L","Number",0) 
        elseif (position == 0 ) then
            fs2020_variable_write("L:ASCRJ_AICE_COWL_L","Number",1) 
        end
    end)

--Cowl R
fs2020_variable_subscribe("L:ASCRJ_AICE_COWL_R", "Number", 
        function (state)
            switch_set_position(sw_cowl_R, state)
            visible(img_sw_cowl_R_mid, state ==0)
            visible(img_sw_cowl_R_mid_night, state ==0)
            visible(img_sw_cowl_R_dn, state ==1)
            visible(img_sw_cowl_R_dn_night, state ==1)       
        end)

sw_cowl_R= switch_add(nil,nil, 366,76,181,179,
    function (position)
        if (position == 1 ) then
            fs2020_variable_write("L:ASCRJ_AICE_COWL_R","Number",0) 
        elseif (position == 0 ) then
            fs2020_variable_write("L:ASCRJ_AICE_COWL_R","Number",1) 
        end
    end)

img_ice_det_on = img_add("light_ice.png", 526,104,86,85)  visible(img_ice_det_on, false)
fs2020_variable_subscribe("L:ASCRJ_AICE_DETECT_ICE", "Number", 
                                             "A:CIRCUIT GENERAL PANEL ON","Bool",
    function (pos,pwr)
        if (pwr==true and pos == 1) then
             visible(img_ice_det_on , true)
        else
            visible(img_ice_det_on , false)
        end
end)

--ICE Det Push Button
function cb_ice_det_test()
    fs2020_variable_write("L:ASCRJ_AICE_DETECT","Number",1)
    sound_play(click_snd)
    timer_start(50, function() fs2020_variable_write("L:ASCRJ_AICE_DETECT","Number",0)end)   
end
btn_ice_det_test = button_add(nil,"btn_push.png", 528,107,82,82, cb_ice_det_test)

-------------------------------------------------------------------------------------------
--- WSHLD L
function cb_wshld_L_dec()
    if current_pos_wshld_L == 0  then fs2020_variable_write("L:ASCRJ_AICE_WSHLD_L", "Number", 1) end
    if current_pos_wshld_L == 1  then fs2020_variable_write("L:ASCRJ_AICE_WSHLD_L", "Number", 2) end   
end
btn_wshld_L_dn = button_add(nil, nil, 90, 345, 65, 80, cb_wshld_L_dec)

function cb_wshld_L_inc()
    if current_pos_wshld_L == 2  then fs2020_variable_write("L:ASCRJ_AICE_WSHLD_L", "Number", 1) end
    if current_pos_wshld_L == 1  then fs2020_variable_write("L:ASCRJ_AICE_WSHLD_L", "Number", 0)  end
end
btn_wshld_L_up = button_add(nil, nil, 90, 235, 65, 80, cb_wshld_L_inc)

fs2020_variable_subscribe("L:ASCRJ_AICE_WSHLD_L", "Number", 
    function (pos)
        if pos == 0 then
            visible(img_wshld_L_dn , false) visible(img_wshld_L_mid , false) visible(img_wshld_L_up , true)
            visible(img_wshld_L_dn_night , false) visible(img_wshld_L_mid_night , false) visible(img_wshld_L_up_night , true)
        elseif pos == 1 then 
            visible(img_wshld_L_dn , false) visible(img_wshld_L_mid , true) visible(img_wshld_L_up , false)
            visible(img_wshld_L_dn_night , false) visible(img_wshld_L_mid_night , true) visible(img_wshld_L_up_night , false)
        elseif pos == 2 then 
            visible(img_wshld_L_dn , true) visible(img_wshld_L_mid , false) visible(img_wshld_L_up , false)
            visible(img_wshld_L_dn_night , true) visible(img_wshld_L_mid_night , false) visible(img_wshld_L_up_night , false)
        end
    current_pos_wshld_L = pos
end)

--WSHLD TEST
sw_wshld_test= button_add(nil,"button_pressed.png", 137,268,158,115,
    function ()
            fs2020_variable_write("L:ASCRJ_AICE_WSHLD_TEST","Number",1) 
    end)
    
--- WSHLD R
function cb_wshld_R_dec()
    if current_pos_wshld_R == 0  then fs2020_variable_write("L:ASCRJ_AICE_WSHLD_R", "Number", 1) end
    if current_pos_wshld_R == 1  then fs2020_variable_write("L:ASCRJ_AICE_WSHLD_R", "Number", 2) end   
end
btn_wshld_R_dn = button_add(nil, nil, 290, 345, 65, 80, cb_wshld_R_dec)

function cb_wshld_R_inc()
    if current_pos_wshld_R == 2  then fs2020_variable_write("L:ASCRJ_AICE_WSHLD_R", "Number", 1) end
    if current_pos_wshld_R == 1  then fs2020_variable_write("L:ASCRJ_AICE_WSHLD_R", "Number", 0)  end
end
btn_wshld_R_up = button_add(nil, nil, 290, 235, 65, 70, cb_wshld_R_inc)

fs2020_variable_subscribe("L:ASCRJ_AICE_WSHLD_R", "Number", 
    function (pos)
        if pos == 0 then
            visible(img_wshld_R_dn , false) visible(img_wshld_R_mid , false) visible(img_wshld_R_up , true)
            visible(img_wshld_R_dn_night , false) visible(img_wshld_R_mid_night , false) visible(img_wshld_R_up_night , true)
        elseif pos == 1 then 
            visible(img_wshld_R_dn , false) visible(img_wshld_R_mid , true) visible(img_wshld_R_up , false)
            visible(img_wshld_R_dn_night , false) visible(img_wshld_R_mid_night , true) visible(img_wshld_R_up_night , false)
        elseif pos == 2 then 
            visible(img_wshld_R_dn , true) visible(img_wshld_R_mid , false) visible(img_wshld_R_up , false)
            visible(img_wshld_R_dn_night , true) visible(img_wshld_R_mid_night , false) visible(img_wshld_R_up_night , false)
        end
    current_pos_wshld_R = pos
end)

------------------------------------------------------------------------------
--Probes L
fs2020_variable_subscribe("L:ASCRJ_AICE_PHEAT_L", "Number", 
        function (state)
            switch_set_position(sw_pheat_L, state)
            visible(img_sw_pheat_L_mid, state ==0)
            visible(img_sw_pheat_L_mid_night, state ==0)
            visible(img_sw_pheat_L_dn, state ==1)
            visible(img_sw_pheat_L_dn_night, state ==1)            
        end)

sw_pheat_L= switch_add(nil,nil, 364,251,181,179,
    function (position)
        if (position == 1 ) then
            fs2020_variable_write("L:ASCRJ_AICE_PHEAT_L","Number",0) 
        elseif (position == 0 ) then
            fs2020_variable_write("L:ASCRJ_AICE_PHEAT_L","Number",1) 
        end
    end)

--Probes R
fs2020_variable_subscribe("L:ASCRJ_AICE_PHEAT_R", "Number", 
        function (state)
            switch_set_position(sw_pheat_R, state)
            visible(img_sw_pheat_R_mid, state ==0)
            visible(img_sw_pheat_R_mid_night, state ==0)
            visible(img_sw_pheat_R_dn, state ==1)
            visible(img_sw_pheat_R_dn_night, state ==1)               
        end)

sw_pheat_R= switch_add(nil,nil, 489,251,181,179,
    function (position)
        if (position == 1 ) then
            fs2020_variable_write("L:ASCRJ_AICE_PHEAT_R","Number",0) 
        elseif (position == 0 ) then
            fs2020_variable_write("L:ASCRJ_AICE_PHEAT_R","Number",1) 
        end
    end)
