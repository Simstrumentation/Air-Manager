--[[
******************************************************************************************
******************Bombardier CRJ Pedestal-Intercom Control Panel*************************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation

- **v1.0** 09-19-2022
    - Original Panel Created


##Left To Do:
    - N/A
	
##Notes:
    - N/A
        
--]]

snd_click = sound_add("click.wav")
img_add_fullscreen("background.png")
img_bg_night = img_add_fullscreen("background_night.png")
--=======Back  Lighting============
img_labels_backlight = img_add_fullscreen("backlighting.png")

function ss_backlighting(value, pwr)
    value = var_round(value*10,2) 
    if value == 0.0 or (pwr == false ) then 
        opacity(img_labels_backlight, 0, "LOG", 0.04)                
    else
        opacity(img_labels_backlight, (value), "LOG", 0.04)                  
    end
end
msfs_variable_subscribe("A:Light Potentiometer:4", "Number",
                                              "A:CIRCUIT GENERAL PANEL ON","Bool", ss_backlighting)
                                              
--Day Graphics  
img_calls_pa= img_add("light_green.png", 63,45,14,36)
img_calls_call= img_add("light_green.png", 205,45,14,36)
img_calls_emer= img_add("light_orange.png", 277,45,14,36)


-- Ambient Light Control
function ss_ambient_darkness(value)
    opacity(img_bg_night, value, "LOG", 0.04)          
end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)

--------------------------------------------------------------------------------------------
--PA BUTTON
function ss_calls_pa(state,pwr)
	visible(img_calls_pa, (state ==1 and pwr ==true))
end        
msfs_variable_subscribe("L:ASCRJ_CALLS_PA_ON", "Number","A:CIRCUIT GENERAL PANEL ON","Bool",  ss_calls_pa)
function calls_pa()
    msfs_variable_write("L:ASCRJ_CALLS_PA",  "Number", 1)  timer_start(100, function() msfs_variable_write("L:ASCRJ_CALLS_PA", "Number", 0) end)
    sound_play(snd_click)
end
    btn_calls_pa = button_add(nil,"btn_push.png", 58, 38, 25, 48, calls_pa) 
--CHIME
function calls_chime()
    msfs_variable_write("L:ASCRJ_CALLS_CHIME",  "Number", 1)  timer_start(100, function() msfs_variable_write("L:ASCRJ_CALLS_CHIME", "Number", 0) end)
    sound_play(snd_click)
end
    btn_calls_pa = button_add(nil,"btn_push.png", 130, 38, 25, 48, calls_chime) 
    
    
--CALL BUTTON    
function ss_calls_call(state,pwr)
	visible(img_calls_call, (state ==1 and pwr ==true))
end        
msfs_variable_subscribe("L:ASCRJ_CALLS_CALL_ON", "Number","A:CIRCUIT GENERAL PANEL ON","Bool",  ss_calls_call)
function calls_call()
    msfs_variable_write("L:ASCRJ_CALLS_CALL",  "Number", 1)  timer_start(100, function() msfs_variable_write("L:ASCRJ_CALLS_CALL", "Number", 0) end)
    sound_play(snd_click)
end
    btn_calls_call = button_add(nil,"btn_push.png", 199, 38, 25, 48, calls_call)     
--EMER BUTTON    
function ss_calls_emer(state,pwr)
	visible(img_calls_emer, (state ==1 and pwr ==true))
end        
msfs_variable_subscribe("L:ASCRJ_CALLS_EMER_ON", "Number","A:CIRCUIT GENERAL PANEL ON","Bool",  ss_calls_emer)
function calls_emer()
    msfs_variable_write("L:ASCRJ_CALLS_EMER",  "Number", 1)  timer_start(100, function() msfs_variable_write("L:ASCRJ_CALLS_EMER", "Number", 0) end)
    sound_play(snd_click)
end
    btn_calls_emer = button_add(nil,"btn_push.png", 272, 38, 25, 48, calls_emer)      
