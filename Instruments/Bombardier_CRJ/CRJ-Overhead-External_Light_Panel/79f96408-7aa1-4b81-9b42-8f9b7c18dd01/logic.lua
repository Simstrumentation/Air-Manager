--[[
******************************************************************************************
************Bombardier CRJ-Overhead- External Lights Panel***************************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation
   
- **v1.0** 03-16-2022
    - Original Panel Created

	
##Notes:
    - 
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
fs2020_variable_subscribe("A:Light Potentiometer:2", "Number",
                                              "A:CIRCUIT GENERAL PANEL ON","Bool", ss_backlighting)
---------------------------------------------
--Day Graphics
img_sw_nav_mid = img_add("toggle_mid.png",  07,69,181,179)
img_sw_nav_dn = img_add("toggle_down.png",  07,69,181,179) visible(img_sw_nav_dn, false)
img_sw_beac_mid = img_add("toggle_mid.png",  121,70,181,179)
img_sw_beac_dn = img_add("toggle_down.png",  121,70,181,179) visible(img_sw_beac_dn, false)
img_sw_strb_mid = img_add("toggle_mid.png",  233,70,181,179)
img_sw_strb_dn = img_add("toggle_down.png",  233,70,181,179) visible(img_sw_strb_dn, false)
img_sw_logo_mid = img_add("toggle_mid.png",   346,70,181,179)
img_sw_logo_dn = img_add("toggle_down.png",   346,70,181,179) visible(img_sw_logo_dn, false)
img_sw_wng_mid = img_add("toggle_mid.png",  459,70,181,179)
img_sw_wng_dn = img_add("toggle_down.png",  459,70,181,179) visible(img_sw_wng_dn, false)

--Night Graphics
img_sw_nav_mid_night = img_add("toggle_mid_night.png",  07,69,181,179)
img_sw_nav_dn_night = img_add("toggle_down_night.png",  07,69,181,179)
img_sw_beac_mid_night = img_add("toggle_mid_night.png",  121,70,181,179)
img_sw_beac_dn_night = img_add("toggle_down_night.png",  121,70,181,179)
img_sw_strb_dn_night = img_add("toggle_down_night.png",  233,70,181,179)
img_sw_strb_mid_night = img_add("toggle_mid_night.png",  233,70,181,179)
img_sw_logo_mid_night = img_add("toggle_mid_night.png",   346,70,181,179)
img_sw_logo_dn_night = img_add("toggle_down_night.png",  346,70,181,179)
img_sw_wng_mid_night = img_add("toggle_mid_night.png",  459,70,181,179)
img_sw_wng_dn_night = img_add("toggle_down_night.png",  459,70,181,179)

-----------------------------------------------------
-- Ambient Light Control
function ss_ambient_darkness(value)
    opacity(img_bg_night, value, "LOG", 0.04)
    opacity(img_sw_nav_mid_night, value, "LOG", 0.04)
    opacity(img_sw_nav_dn_night, value, "LOG", 0.04)
    opacity(img_sw_beac_mid_night, value, "LOG", 0.04)
    opacity(img_sw_beac_dn_night, value, "LOG", 0.04)          
    opacity(img_sw_strb_mid_night, value, "LOG", 0.04)
    opacity(img_sw_strb_dn_night, value, "LOG", 0.04)  
    opacity(img_sw_logo_mid_night, value, "LOG", 0.04)
    opacity(img_sw_logo_dn_night, value, "LOG", 0.04)    
    opacity(img_sw_wng_mid_night, value, "LOG", 0.04)
    opacity(img_sw_wng_dn_night, value, "LOG", 0.04)    
end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)
-------------------------------------------------------------
-------------------------------------------------------------

--Nav Switch
fs2020_variable_subscribe("L:ASCRJ_EXTL_NAV", "Number", 
        function (state)
            switch_set_position(sw_nav, state)
            visible(img_sw_nav_mid, state ==0)
            visible(img_sw_nav_mid_night, state ==0)
            visible(img_sw_nav_dn, state ==1)
            visible(img_sw_nav_dn_night, state ==1)   
        end)

function cb_sw_nav(position)
    if (position == 0 ) then
        fs2020_variable_write("L:ASCRJ_EXTL_NAV","Number",1) 
    elseif (position == 1 ) then
        fs2020_variable_write("L:ASCRJ_EXTL_NAV","Number",0) 
    end 
end

sw_nav= switch_add(nil,nil, 50,80,100,130, cb_sw_nav)

--Beacon Switch
fs2020_variable_subscribe("L:ASCRJ_EXTL_BEACON", "Number", 
        function (state)
            switch_set_position(sw_beac, state)
            visible(img_sw_beac_mid, state ==0)
            visible(img_sw_beac_mid_night, state ==0)
            visible(img_sw_beac_dn, state ==1)
            visible(img_sw_beac_dn_night, state ==1)               
        end)

function cb_sw_beac(position)
    if (position == 0 ) then
        fs2020_variable_write("L:ASCRJ_EXTL_BEACON","Number",1) 
    elseif (position == 1 ) then
        fs2020_variable_write("L:ASCRJ_EXTL_BEACON","Number",0) 
    end 
end

sw_beac= switch_add(nil,nil, 170,80,100,130, cb_sw_beac)

--Strobe Switch
fs2020_variable_subscribe("L:ASCRJ_EXTL_STROBE", "Number", 
        function (state)
            switch_set_position(sw_strb, state)
            visible(img_sw_strb_mid, state ==0)
            visible(img_sw_strb_mid_night, state ==0)
            visible(img_sw_strb_dn, state ==1)
            visible(img_sw_strb_dn_night, state ==1)               
        end)

function cb_sw_strb(position)
    if (position == 0 ) then
        fs2020_variable_write("L:ASCRJ_EXTL_STROBE","Number",1) 
    elseif (position == 1 ) then
        fs2020_variable_write("L:ASCRJ_EXTL_STROBE","Number",0) 
    end 
end

sw_strb= switch_add(nil,nil, 280,80,100,130, cb_sw_strb)

--Logo Switch
fs2020_variable_subscribe("L:ASCRJ_EXTL_LOGO", "Number", 
        function (state)
            switch_set_position(sw_logo, state)
            visible(img_sw_logo_mid, state ==0)
            visible(img_sw_logo_mid_night, state ==0)
            visible(img_sw_logo_dn, state ==1)
            visible(img_sw_logo_dn_night, state ==1)               
        end)

function cb_sw_logo(position)
    if (position == 0 ) then
        fs2020_variable_write("L:ASCRJ_EXTL_LOGO","Number",1) 
    elseif (position == 1 ) then
        fs2020_variable_write("L:ASCRJ_EXTL_LOGO","Number",0) 
    end 
end

sw_logo= switch_add(nil,nil, 390,80,100,130
, cb_sw_logo)

--Wing Inspection Switch
fs2020_variable_subscribe("L:ASCRJ_EXTL_WING", "Number", 
        function (state)
            switch_set_position(sw_wng, state)
            visible(img_sw_wng_mid, state ==0)
            visible(img_sw_wng_mid_night, state ==0)
            visible(img_sw_wng_dn, state ==1)
            visible(img_sw_wng_dn_night, state ==1)               
        end)

function cb_sw_wng(position)
    if (position == 0 ) then
        fs2020_variable_write("L:ASCRJ_EXTL_WING","Number",1) 
    elseif (position == 1 ) then
        fs2020_variable_write("L:ASCRJ_EXTL_WING","Number",0) 
    end 
end

sw_wng= switch_add(nil,nil, 500,80,100,130, cb_sw_wng)

