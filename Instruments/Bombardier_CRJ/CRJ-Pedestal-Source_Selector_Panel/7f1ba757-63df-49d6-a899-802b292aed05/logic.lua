--[[
******************************************************************************************
******************Bombardier CRJ Pedestal-Source Selector Panel*************************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation

- **v1.0** 09-18-2022
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
        opacity(img_backlight_knob_ATTD, 0, "LOG", 0.04)  
        opacity(img_backlight_knob_EICAS, 0, "LOG", 0.04)    
        opacity(img_backlight_knob_DATA, 0, "LOG", 0.04)  
        opacity(img_backlight_knob_DSPL, 0, "LOG", 0.04)                  
    else
        opacity(img_labels_backlight, (value), "LOG", 0.04) 
        opacity(img_backlight_knob_ATTD, (value), "LOG", 0.04) 
        opacity(img_backlight_knob_EICAS, (value), "LOG", 0.04)          
        opacity(img_backlight_knob_DATA, (value), "LOG", 0.04)  
        opacity(img_backlight_knob_DSPL, (value), "LOG", 0.04)                   
    end
end
fs2020_variable_subscribe("A:Light Potentiometer:4", "Number",
                                              "A:CIRCUIT GENERAL PANEL ON","Bool", ss_backlighting)
                                              
--Day Graphics   
img_knob_ATTD = img_add("round_knob.png", 42,28,65,65)
img_knob_EICAS = img_add("round_knob.png", 182,28,65,65)
img_knob_DATA = img_add("round_knob.png", 114,126,65,65)
img_knob_DSPL = img_add("round_knob.png", 256,126,65,65)

--Night Graphics
img_knob_ATTD_night = img_add("round_knob_night.png", 42,28,65,65)
img_knob_EICAS_night = img_add("round_knob_night.png", 182,28,65,65)
img_knob_DATA_night = img_add("round_knob_night.png", 114,126,65,65)
img_knob_DSPL_night = img_add("round_knob_night.png", 256,126,65,65)

--Backlighting
img_backlight_knob_ATTD = img_add("backlight_round_knob.png", 42,28,65,65)
img_backlight_knob_EICAS = img_add("backlight_round_knob.png", 182,28,65,65)
img_backlight_knob_DATA = img_add("backlight_round_knob.png", 114,126,65,65)
img_backlight_knob_DSPL = img_add("backlight_round_knob.png", 256,126,65,65)

-- Ambient Light Control
function ss_ambient_darkness(value)
    opacity(img_bg_night, value, "LOG", 0.04)
    opacity(img_knob_ATTD_night, value, "LOG", 0.04)
    opacity(img_knob_EICAS_night, value, "LOG", 0.04)   
    opacity(img_knob_DATA_night, value, "LOG", 0.04)   
    opacity(img_knob_DSPL_night, value, "LOG", 0.04)           
end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)

--------------------------------------------------------------------------------------------
fs2020_variable_subscribe("L:ASCRJ_ATTD_HDG", "Number",
        function (position)
                switch_set_position(sw_ATTD, (var_round(position,0)))             
                rotate(img_knob_ATTD, (position*52)-52,"LOG", 0.1)
                rotate(img_knob_ATTD_night, (position*52)-52,"LOG", 0.1)
                rotate(img_backlight_knob_ATTD, (position*52)-52,"LOG", 0.1)
        end)           

sw_ATTD = switch_add(nil,nil,nil, 42,28,65,65, "CIRCULAIR",
        function (pos,dir) fs2020_variable_write("L:ASCRJ_ATTD_HDG","Number", pos+dir) end) 
        
fs2020_variable_subscribe("L:ASCRJ_EICAS", "Number",
        function (position)
                switch_set_position(sw_EICAS, (var_round(position,0)))             
                rotate(img_knob_EICAS, (position*52)-52,"LOG", 0.1)
                rotate(img_knob_EICAS_night, (position*52)-52,"LOG", 0.1)
                rotate(img_backlight_knob_EICAS, (position*52)-52,"LOG", 0.1)
        end)           

sw_EICAS = switch_add(nil,nil,nil, 182,28,65,65, "CIRCULAIR",
        function (pos,dir) fs2020_variable_write("L:ASCRJ_EICAS","Number", pos+dir) end)         
        
fs2020_variable_subscribe("L:ASCRJ_AIR_DATA", "Number",
        function (position)
                switch_set_position(sw_DATA, (var_round(position,0)))             
                rotate(img_knob_DATA, (position*52)-52,"LOG", 0.1)
                rotate(img_knob_DATA_night, (position*52)-52,"LOG", 0.1)
                rotate(img_backlight_knob_DATA, (position*52)-52,"LOG", 0.1)
        end)           

sw_DATA = switch_add(nil,nil,nil, 114,126,65,65, "CIRCULAIR",
        function (pos,dir) fs2020_variable_write("L:ASCRJ_AIR_DATA","Number", pos+dir) end)          
        
fs2020_variable_subscribe("L:ASCRJ_DSPL_CONT", "Number",
        function (position)
                switch_set_position(sw_DSPL, (var_round(position,0)))             
                rotate(img_knob_DSPL, (position*52)-52,"LOG", 0.1)
                rotate(img_knob_DSPL_night, (position*52)-52,"LOG", 0.1)
                rotate(img_backlight_knob_DSPL, (position*52)-52,"LOG", 0.1)
        end)           

sw_DSPL = switch_add(nil,nil,nil, 256,126,65,65, "CIRCULAIR",
        function (pos,dir) fs2020_variable_write("L:ASCRJ_DSPL_CONT","Number", pos+dir) end)                