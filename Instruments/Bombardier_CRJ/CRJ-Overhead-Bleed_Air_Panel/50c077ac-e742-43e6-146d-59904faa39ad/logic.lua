--[[
******************************************************************************************
*****************Bombardier CRJ-Overhead-Bleed Air Panel**************************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation
   
- **v1.0** 02-09-2022
    - Original Panel Created


##Left To Do:
    - Bleed Source Knob, can't go from position 3 to position 0 since it's a swtich, may need to change to dial.
	
##Notes:
    - N/A
    
******************************************************************************************
--]]

img_add_fullscreen("background.png")
img_bg_night = img_add_fullscreen("background_night.png")

--=======Back  Lighting============
img_labels_backlight = img_add_fullscreen("backlighting.png")

function ss_backlighting(value, pwr)
    value = var_round(value*10,2) --value*0.038 if using Lvar L:ASCRJ_INTL_OVHD
    if value == 0.0 or (pwr == false ) then 
        opacity(img_labels_backlight, 0, "LOG", 0.04)              
        opacity(img_backlight_crossbleed_knob, 0, "LOG", 0.04)       
        opacity(img_backlight_bleedvalves_knob, 0, "LOG", 0.04)            
        opacity(img_backlight_bleedsource_knob, 0, "LOG", 0.04)                 
    else
        opacity(img_labels_backlight, (value), "LOG", 0.04)
        opacity(img_backlight_crossbleed_knob, (value), "LOG", 0.04)     
        opacity(img_backlight_bleedvalves_knob, (value), "LOG", 0.04)              
        opacity(img_backlight_bleedsource_knob, (value), "LOG", 0.04)   
    end
end
msfs_variable_subscribe("A:Light Potentiometer:2", "Number",
                                              "A:CIRCUIT GENERAL PANEL ON","Bool", ss_backlighting)
--Day Graphics
img_sw_isol_up= img_add("toggle_up.png", 230,255,185,182)
img_sw_isol_down= img_add("toggle_down.png", 230,255,185,182)visible(img_sw_isol_up, false)
img_dial_crossbleed= img_add("triangle_knob.png", 267,125,100,100)
img_dial_bleedvalves= img_add("diamond_knob.png", 92,292,100,100)
img_dial_bleedsource= img_add("clover_knob.png", 440,290,100,100)
--Night Graphics
img_sw_isol_up_night= img_add("toggle_up_night.png", 230,255,185,182) visible(img_sw_isol_up_night, false)
img_sw_isol_down_night= img_add("toggle_down_night.png", 230,255,185,182)
img_dial_crossbleed_night= img_add("triangle_knob_night.png",267,125,100,100)
img_dial_bleedvalves_night= img_add("diamond_knob_night.png", 92,292,100,100)
img_dial_bleedsource_night= img_add("clover_knob_night.png", 440,290,100,100)


img_backlight_crossbleed_knob = img_add("backlight_triangle_knob.png", 267,125,100,100)
img_backlight_bleedvalves_knob= img_add("backlight_diamond_knob.png", 92,292,100,100)
img_backlight_bleedsource_knob = img_add("backlight_clover_knob.png", 440,290,100,100)

-- Ambient Light Control
function ss_ambient_darkness(value)
    opacity(img_bg_night, value, "LOG", 0.04)
    opacity(img_sw_isol_up_night, value, "LOG", 0.04)
    opacity(img_sw_isol_down_night, value, "LOG", 0.04)
    opacity(img_dial_crossbleed_night, value, "LOG", 0.04)
    opacity(img_dial_bleedvalves_night, value, "LOG", 0.04)   
    opacity(img_dial_bleedsource_night, value, "LOG", 0.04)       
end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)

--Cross Bleed

function ss_crossbleed(state)
    switch_set_position(switch_crossbleed, state)
    rotate(img_dial_crossbleed, -(40-(state*40)))
    rotate(img_dial_crossbleed_night, -(40-(state*40)))    
    rotate(img_backlight_crossbleed_knob, -(40-(state*40)))        
end
msfs_variable_subscribe("L:ASCRJ_AIR_CROSS_BLEED", "Number", ss_crossbleed)
function cb_sw_crossbleed(position, direction)
 msfs_variable_write("L:ASCRJ_AIR_CROSS_BLEED","number",1) 
    if (position == 0 and direction == 1 ) then
        msfs_variable_write("L:ASCRJ_AIR_CROSS_BLEED","number",1) 
    elseif (position == 1 and direction == 1 ) then
        msfs_variable_write("L:ASCRJ_AIR_CROSS_BLEED","number",2) 
    elseif (position == 1 and direction == -1 ) then
        msfs_variable_write("L:ASCRJ_AIR_CROSS_BLEED","number",0)         
    elseif (position == 2 and direction == -1) then
        msfs_variable_write("L:ASCRJ_AIR_CROSS_BLEED","number",1)               
    end 
end
switch_crossbleed= switch_add(nil,nil,nil, 267,130,100,100, "CIRCULAIR" , cb_sw_crossbleed)  

--Bleed Valves

function ss_bleedvalves(state)
    switch_set_position(switch_bleedvalves, state)
    rotate(img_dial_bleedvalves, -(40-(state*40)))
    rotate(img_dial_bleedvalves_night, -(40-(state*40)))  
    rotate(img_backlight_bleedvalves_knob, -(40-(state*40)))     
end
msfs_variable_subscribe("L:ASCRJ_AIR_BLEED_VALVES", "Number", ss_bleedvalves)
function cb_sw_bleedvalves(position, direction)
    if (position == 0 and direction == 1 ) then
        msfs_variable_write("L:ASCRJ_AIR_BLEED_VALVES","number",1) 
    elseif (position == 1 and direction == 1 ) then
        msfs_variable_write("L:ASCRJ_AIR_BLEED_VALVES","number",2) 
    elseif (position == 1 and direction == -1 ) then
        msfs_variable_write("L:ASCRJ_AIR_BLEED_VALVES","number",0)         
    elseif (position == 2 and direction == -1) then
        msfs_variable_write("L:ASCRJ_AIR_BLEED_VALVES","number",1)               
    end 
end
switch_bleedvalves= switch_add(nil,nil,nil, 90,295,100,100, "CIRCULAIR" , cb_sw_bleedvalves) 


--ISOL SWITCH
msfs_variable_subscribe("L:ASCRJ_AIR_BLEED_SOURCE_ISOL", "Number", 
        function (state)
            switch_set_position(sw_isol, state)
            visible(img_sw_isol_up, state ==0)
            visible(img_sw_isol_up_night, state ==0)
            visible(img_sw_isol_down, state ==1)
            visible(img_sw_isol_down_night, state ==1) 
        end)

function cb_sw_isol(position)
    if (position == 0 ) then
        msfs_variable_write("L:ASCRJ_AIR_BLEED_SOURCE_ISOL","Number",1) 
    elseif (position == 1 ) then
        msfs_variable_write("L:ASCRJ_AIR_BLEED_SOURCE_ISOL","Number",0) 
    end 
end
sw_isol= switch_add(nil,nil, 230,255,185,182, cb_sw_isol)


--Bleed Source

function ss_bleedsource(state)
       --print(state) 
       switch_set_position(switch_bleedsource, state)
    rotate(img_dial_bleedsource, -(90-(state*90)))
    rotate(img_dial_bleedsource_night, -(90-(state*90)))    
    rotate(img_backlight_bleedsource_knob, -(90-(state*90)))      
end
msfs_variable_subscribe("L:ASCRJ_AIR_BLEED_SOURCE", "Number", ss_bleedsource)
function cb_sw_bleedsource(position, direction)
    if (position == 0 and direction == 1 ) then
        msfs_variable_write("L:ASCRJ_AIR_BLEED_SOURCE","number",1)
   elseif (position == 0 and direction == -1 ) then
        msfs_variable_write("L:ASCRJ_AIR_BLEED_SOURCE","number",3)         
    elseif (position == 1 and direction == 1 ) then
        msfs_variable_write("L:ASCRJ_AIR_BLEED_SOURCE","number",2) 
    elseif (position == 1 and direction == -1 ) then
        msfs_variable_write("L:ASCRJ_AIR_BLEED_SOURCE","number",0)         
    elseif (position == 2 and direction == 1) then
        msfs_variable_write("L:ASCRJ_AIR_BLEED_SOURCE","number",3)               
    elseif (position == 2 and direction == -1) then
        msfs_variable_write("L:ASCRJ_AIR_BLEED_SOURCE","number",1)   
    elseif (position == 3 and direction == 1) then
        msfs_variable_write("L:ASCRJ_AIR_BLEED_SOURCE","number",0)               
    elseif (position == 3 and direction == -1) then
        msfs_variable_write("L:ASCRJ_AIR_BLEED_SOURCE","number",2)                        
    end 
end
switch_bleedsource= switch_add(nil,nil,nil,nil, 440,290,100,100, "CIRCULAIR" , cb_sw_bleedsource) 