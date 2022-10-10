--[[
******************************************************************************************
*****************Bombardier CRJ Pedestal-Aileron Rudder Trim Panel******************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation

- **v1.0** 06-17-2022
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
        opacity(img_backlight_knob_RUDTrim, 0, "LOG", 0.04)  
    else
        opacity(img_labels_backlight, (value), "LOG", 0.04) 
        opacity(img_backlight_knob_RUDTrim, (value), "LOG", 0.04) 
    end
end
fs2020_variable_subscribe("A:Light Potentiometer:4", "Number",
                                              "A:CIRCUIT GENERAL PANEL ON","Bool", ss_backlighting)
                                              
--Day Graphics   
img_knob_RUDTrim = img_add("large_round.png", 198,15,85,85)
img_knob_AilUpperTrim = img_add("ail_upper.png", 88,30,35,30)
img_knob_AilLowerTrim = img_add("ail_lower.png", 88,59,35,30)

--Night Graphics
img_knob_RUDTrim_night = img_add("large_round_night.png", 198,15,85,85)
img_knob_AilUpperTrim_night = img_add("ail_upper_night.png", 88,30,35,30)
img_knob_AilLowerTrim_night = img_add("ail_lower_night.png", 88,59,35,30)

--Backlighting
img_backlight_knob_RUDTrim = img_add("backlight_large_round.png", 198,15,85,85)


-- Ambient Light Control
function ss_ambient_darkness(value)
    opacity(img_bg_night, value, "LOG", 0.04)
    opacity(img_knob_RUDTrim_night, value, "LOG", 0.04)
    opacity(img_knob_AilUpperTrim_night, value, "LOG", 0.04)
    opacity(img_knob_AilLowerTrim_night, value, "LOG", 0.04)        
  
end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)

--------------------------------------------------------------------------------------------

--Aileron Upper Trim
fs2020_variable_subscribe("L:ASCRJ_TRIM_AIL_UPR", "Number",
        function (position)
                switch_set_position(sw_AilUpperTrim, (var_round(position,0)))             
                move(img_knob_AilUpperTrim, 74-(1-position*15),30,35,30,"LOG", 0.1)
                move(img_knob_AilUpperTrim_night, 74-(1-position*15),30,35,30,"LOG", 0.1)
        end)

sw_AilUpperTrim = switch_add(nil,nil,nil, 70,30,70,30, "HORIZONTAL",
        function (pos,dir) fs2020_variable_write("L:ASCRJ_TRIM_AIL_UPR","Number", pos+dir) end) 

--Aileron Lower Trim
fs2020_variable_subscribe("L:ASCRJ_TRIM_AIL_LWR", "Number",
        function (position)
                switch_set_position(sw_AilLowerTrim, (var_round(position,0)))             
                move(img_knob_AilLowerTrim, 74-(1-position*15),59,35,30,"LOG", 0.1)
                move(img_knob_AilLowerTrim_night, 74-(1-position*15),59,35,30,"LOG", 0.1)
        end)

sw_AilLowerTrim = switch_add(nil,nil,nil, 70,59,70,30, "HORIZONTAL",
        function (pos,dir) fs2020_variable_write("L:ASCRJ_TRIM_AIL_LWR","Number", pos+dir) end) 

--Rudder Trim
fs2020_variable_subscribe("L:ASCRJ_TRIM_RUD", "Number",
        function (position)
                switch_set_position(sw_RudTrim, (var_round(position,0)))             
                rotate(img_knob_RUDTrim, (position*45)-45,"LOG", 0.1)
                rotate(img_knob_RUDTrim_night, (position*45)-45,"LOG", 0.1)
                rotate(img_backlight_knob_RUDTrim, (position*45)-45,"LOG", 0.1)
        end)

sw_RudTrim = switch_add(nil,nil,nil, 198,15,85,85, "CIRCULAIR",
        function (pos,dir) fs2020_variable_write("L:ASCRJ_TRIM_RUD","Number", pos+dir) end) 