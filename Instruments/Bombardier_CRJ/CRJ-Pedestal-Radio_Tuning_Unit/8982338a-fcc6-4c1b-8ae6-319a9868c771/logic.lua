--[[
******************************************************************************************
******************Bombardier CRJ-Pedestal-Radio Tuning Unit*****************************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation

- **v1.0** 05-10-2022
    - Original Panel Created


##Left To Do:
    - N/A
	
##Notes:
    - This instrument has a user prop to control either the Pilot or CoPilot side unit.  
        
--]]

snd_click = sound_add("click.wav")
snd_dial = sound_add("dial.wav")
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
msfs_variable_subscribe("A:Light Potentiometer:4", "Number",
                                              "A:CIRCUIT GENERAL PANEL ON","Bool", ss_backlighting)
                                              
-----------------------------------------------------------------
                                                                                            
LSKButtonPressed ="btn_push.png"
ButtonPressed ="btn_push.png"

-- Ambient Light Control
function ss_ambient_darkness(value)
    opacity(img_bg_night, value, "LOG", 0.04)
    opacity(img_tuning_outer_night, value, "LOG", 0.04)    
    opacity(img_tuning_inner_night, value, "LOG", 0.04)

end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)
-----------------------------------------------------------------
--User Prop to set RTU
prop_RTU = user_prop_add_enum("RTU Side", "COM1/NAV1,COM2/NAV2", "COM1/NAV1", "You can choose to make this instrument COM1/NAV1 or COM2/NAV2")
if user_prop_get(prop_RTU) == "COM1/NAV1" then
    controlside = "L:ASCRJ_RTU1_"
    else controlside = "L:ASCRJ_RTU2_"
end   

--Left LSK
button_add(nil,LSKButtonPressed, 12,50,20,15,
    function () msfs_variable_write(controlside.."LSK1L","number",1) sound_play(snd_click)
                timer_start(50, function() msfs_variable_write(controlside.."LSK1L","number",0) end)end)
button_add(nil,LSKButtonPressed, 12,90,20,15,
    function () msfs_variable_write(controlside.."LSK2L","number",1) sound_play(snd_click)
                timer_start(50, function() msfs_variable_write(controlside.."LSK2L","number",0) end)end)                
button_add(nil,LSKButtonPressed, 12,130,20,15,
    function () msfs_variable_write(controlside.."LSK3L","number",1) sound_play(snd_click)
                timer_start(50, function() msfs_variable_write(controlside.."LSK3L","number",0) end)end)      
button_add(nil,LSKButtonPressed, 12,175,20,15,
    function () msfs_variable_write(controlside.."LSK4L","number",1) sound_play(snd_click)
                timer_start(50, function() msfs_variable_write(controlside.."LSK4L","number",0) end)end)      

---Right LSK                        
button_add(nil,LSKButtonPressed, 265,47,20,20,
    function () msfs_variable_write(controlside.."LSK1R","number",1) sound_play(snd_click)
                timer_start(50, function() msfs_variable_write(controlside.."LSK1R","number",0) end)end)
button_add(nil,LSKButtonPressed,  265,90,20,15,
    function () msfs_variable_write(controlside.."LSK2R","number",1) sound_play(snd_click)
                timer_start(50, function() msfs_variable_write(controlside.."LSK2R","number",0) end)end)                
button_add(nil,LSKButtonPressed, 265,130,20,15,
    function () msfs_variable_write(controlside.."LSK3R","number",1) sound_play(snd_click)
                timer_start(50, function() msfs_variable_write(controlside.."LSK3R","number",0) end)end)      
button_add(nil,LSKButtonPressed, 265,170,20,15,
    function () msfs_variable_write(controlside.."LSK4R","number",1) sound_play(snd_click)
                timer_start(50, function() msfs_variable_write(controlside.."LSK4R","number",0) end)end)      
button_add(nil,LSKButtonPressed, 265,212,20,15,
    function () msfs_variable_write(controlside.."LSK3R","number",1) sound_play(snd_click)
                timer_start(50, function() msfs_variable_write(controlside.."LSK3R","number",0) end)end)     
--Side Buttons
button_add(nil,ButtonPressed,  310,35,25,25,
    function () msfs_variable_write(controlside.."IDENT","number",1) sound_play(snd_click)
                timer_start(50, function() msfs_variable_write(controlside.."IDENT","number",0) end)end)   
button_add(nil,ButtonPressed,  310,93,25,25,
    function () msfs_variable_write(controlside.."DMEH","number",1) sound_play(snd_click)
                timer_start(50, function() msfs_variable_write(controlside.."DMEH","number",0) end)end)
button_add(nil,ButtonPressed,  310,150,25,25,
    function () msfs_variable_write(controlside.."1_2","number",1) sound_play(snd_click)
                timer_start(50, function() msfs_variable_write(controlside.."1_2","number",0) end)end)     
--Tuning Knobs
    
local knob_outer_position = 0
function cb_knob_outer(direction)
    sound_play(snd_dial) 
    knob_outer_position =knob_outer_position + (direction*10)
    if direction == 1 then   
        msfs_variable_write(controlside.."KNOB_OUTER_CHANGE","number",1) rotate(img_tuning_outer_night, knob_outer_position)   
                timer_start(50, function() msfs_variable_write(controlside.."KNOB_OUTER_CHANGE","number",0) end)
    else
        msfs_variable_write(controlside.."KNOB_OUTER_CHANGE","number",-1) rotate(img_tuning_outer_night, knob_outer_position)   
                timer_start(50, function() msfs_variable_write(controlside.."KNOB_OUTER_CHANGE","number",0) end)    
    end    
end
dial_tuning_outer =dial_add("double_outer_knob.png", 275,185,65,65, cb_knob_outer) 
img_tuning_outer_night =img_add("double_outer_knob_night.png", 275,185,65,65)
                
local knob_inner_position = 0
function cb_knob_inner(direction)
    sound_play(snd_dial)
   knob_inner_position =knob_inner_position + (direction*10)
    if direction == 1 then
        msfs_variable_write(controlside.."KNOB_INNER_CHANGE","number",1) rotate(img_tuning_inner_night, knob_inner_position)   
                timer_start(50, function() msfs_variable_write(controlside.."KNOB_INNER_CHANGE","number",0) end)
    else
        msfs_variable_write(controlside.."KNOB_INNER_CHANGE","number",-1) rotate(img_tuning_inner_night, knob_inner_position)   
                timer_start(50, function() msfs_variable_write(controlside.."KNOB_INNER_CHANGE","number",0) end)    
    end
end
dial_tuning_inner = dial_add("double_inner_knob.png", 290,200,35,35, cb_knob_inner)   
img_tuning_inner_night = img_add("double_inner_knob_night.png", 290,200,35,35)   