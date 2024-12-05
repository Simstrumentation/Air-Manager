--[[
******************************************************************************************
******************Bombardier CRJ Pedestal-Yaw Damper Panel*************************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation

- **v1.0** 06-19-2022
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
    value = var_round(value*10,2) --value*0.038 if using Lvar L:ASCRJ_INTL_OVHD
    if value == 0.0 or (pwr == false ) then 
        opacity(img_labels_backlight, 0, "LOG", 0.04)              
    else
        opacity(img_labels_backlight, (value), "LOG", 0.04)
    end
end
msfs_variable_subscribe("A:Light Potentiometer:4", "Number",
                                              "A:CIRCUIT GENERAL PANEL ON","Bool", ss_backlighting)

-- Ambient Light Control
function ss_ambient_darkness(value)
    opacity(img_bg_night, value, "LOG", 0.04)
end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)

-- YDDisc
function ydDisc()
    msfs_variable_write("L:ASCRJ_YD_DISC",  "Number", 1) timer_start(100, function() msfs_variable_write("L:ASCRJ_YD_DISC", "Number", 0) end)
    sound_play(snd_click)
end
    btn_ydDisc = button_add(nil,"circle_button_pressed.png", 49, 22, 80, 80, ydDisc) 

-- YD1
function yd1()
    msfs_variable_write("L:ASCRJ_YD1",  "Number", 1) timer_start(100, function() msfs_variable_write("L:ASCRJ_YD1", "Number", 0) end)
    sound_play(snd_click)
end
    btn_yd1 = button_add(nil,"btn_push.png", 215, 38, 45, 45, yd1) 
    
-- YD2
function yd2()
    msfs_variable_write("L:ASCRJ_YD2",  "Number", 1) timer_start(100, function() msfs_variable_write("L:ASCRJ_YD2", "Number", 0) end)
    sound_play(snd_click)
end
    btn_yd2 = button_add(nil,"btn_push.png", 280, 38, 45, 45, yd2) 