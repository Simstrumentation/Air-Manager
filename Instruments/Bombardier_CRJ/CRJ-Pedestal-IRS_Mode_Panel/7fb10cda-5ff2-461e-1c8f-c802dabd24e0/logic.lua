--[[
******************************************************************************************
******************Bombardier CRJ Pedestal-IRS Mode Panel*************************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation

- **v1.0** 06-09-2022
    - Original Panel Created


##Left To Do:
    - N/A
	
##Notes:
    - N/A
        
--]]


img_add_fullscreen("background.png")
img_bg_night = img_add_fullscreen("background_night.png")

--=======Back  Lighting============
img_labels_backlight = img_add_fullscreen("backlighting.png")

function ss_backlighting(value, pwr)
    value = var_round(value*10,2) 
    if value == 0.0 or (pwr == false ) then 
        opacity(img_labels_backlight, 0, "LOG", 0.04)
        opacity(img_backlight_knob_DSPLY, 0, "LOG", 0.04)  
        opacity(img_backlight_knob_AVI, 0, "LOG", 0.04)    
    else
        opacity(img_labels_backlight, (value), "LOG", 0.04) 
        opacity(img_backlight_knob_DSPLY, (value), "LOG", 0.04) 
        opacity(img_backlight_knob_AVI, (value), "LOG", 0.04)           
    end
end
fs2020_variable_subscribe("A:Light Potentiometer:4", "Number",
                                              "A:CIRCUIT GENERAL PANEL ON","Bool", ss_backlighting)
                                              
--Day Graphics   
img_knob_DSPLY = img_add("diamond_gray_knob.png", 58,28,65,65)
img_knob_AVI = img_add("diamond_gray_knob.png", 237,28,65,65)

--Night Graphics
img_knob_DSPLY_night = img_add("diamond_gray_knob_night.png", 58,28,65,65)
img_knob_AVI_night = img_add("diamond_gray_knob_night.png", 237,28,65,65)

--Backlighting
img_backlight_knob_DSPLY= img_add("backlight_diamond_knob.png", 58,28,65,65)
img_backlight_knob_AVI= img_add("backlight_diamond_knob.png", 237,28,65,65)

-- Ambient Light Control
function ss_ambient_darkness(value)
    opacity(img_bg_night, value, "LOG", 0.04)
    opacity(img_knob_DSPLY_night, value, "LOG", 0.04)
    opacity(img_knob_AVI_night, value, "LOG", 0.04)   
end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)

--------------------------------------------------------------------------------------------

fs2020_variable_subscribe("L:ASCRJ_IRS1_KNOB", "Number",
        function (position)
                switch_set_position(sw_DSPL_FAN, (var_round(position,0)))             
                rotate(img_knob_DSPLY, (position*52)-52,"LOG", 0.1)
                rotate(img_knob_DSPLY_night, (position*52)-52,"LOG", 0.1)
                rotate(img_backlight_knob_DSPLY, (position*52)-52,"LOG", 0.1)
        end)           

sw_DSPL_FAN = switch_add(nil,nil,nil, 58,28,65,65, "CIRCULAIR",
        function (pos,dir) fs2020_variable_write("L:ASCRJ_IRS1_KNOB","Number", pos+dir) end) 
        
fs2020_variable_subscribe("L:ASCRJ_IRS2_KNOB", "Number",
        function (position)
                switch_set_position(sw_AVI_FAN, (var_round(position,0)))             
                rotate(img_knob_AVI, (position*52)-52,"LOG", 0.1)
                rotate(img_knob_AVI_night, (position*52)-52,"LOG", 0.1)
                rotate(img_backlight_knob_AVI, (position*52)-52,"LOG", 0.1)
        end)           

sw_AVI_FAN = switch_add(nil,nil,nil, 237,28,65,65, "CIRCULAIR",
        function (pos,dir) fs2020_variable_write("L:ASCRJ_IRS2_KNOB","Number", pos+dir) end) 
