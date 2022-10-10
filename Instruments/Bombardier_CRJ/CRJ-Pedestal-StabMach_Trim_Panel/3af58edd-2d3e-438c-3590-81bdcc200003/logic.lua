--[[
******************************************************************************************
******************Bombardier CRJ Pedestal-StabMach Trim Panel*********************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation

- **v1.0** 06-08-2022
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
fs2020_variable_subscribe("A:Light Potentiometer:4", "Number",
                                              "A:CIRCUIT GENERAL PANEL ON","Bool", ss_backlighting)

--Day Graphics
img_btn_mach_inop= img_add("btn_inop.png", 238,49,48,48)
img_btn_stab1= img_add("btn_stab1.png", 56,52,42,41)
img_btn_stab2= img_add("btn_stab2.png", 112,52,42,41)

-- Ambient Light Control
function ss_ambient_darkness(value)
    opacity(img_bg_night, value, "LOG", 0.04)

end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)

-----------------------------------------------------------
function ss_mach_inop(inop,pwr)
	visible(img_btn_mach_inop, (inop ==1 and pwr ==true))
end        
fs2020_variable_subscribe("L:ASCRJ_MACH_TRIM_INOP", "Number", "A:CIRCUIT GENERAL PANEL ON", "Bool",  ss_mach_inop)

function mach_inop()
    fs2020_variable_write("L:ASCRJ_MACH_TRIM",  "Number", 1) timer_start(100, function() fs2020_variable_write("L:ASCRJ_MACH_TRIM", "Number", 0) end)
    sound_play(snd_click)
end
btn_mach_inop = button_add(nil,"btn_push.png", 237,49,50,50, mach_inop) 
    
-- Stab Trim
function ss_stab1(state,pwr)
	visible(img_btn_stab1, (state ==1 and pwr ==true))
end        
fs2020_variable_subscribe("L:ASCRJ_STAB_TRIM_CH1", "Number", "A:CIRCUIT GENERAL PANEL ON", "Bool",  ss_stab1)

function stab1()
    fs2020_variable_write("L:ASCRJ_STAB_TRIM_CH1_TRIGGER",  "Number", 1) timer_start(100, function() fs2020_variable_write("L:ASCRJ_STAB_TRIM_CH1_TRIGGER", "Number", 0) end)
    sound_play(snd_click)
end
btn_stab1 = button_add(nil,"btn_push.png", 56,52,42,41, stab1) 

function ss_stab2(state,pwr)
	visible(img_btn_stab2, (state ==1 and pwr ==true))
end        
fs2020_variable_subscribe("L:ASCRJ_STAB_TRIM_CH2", "Number", "A:CIRCUIT GENERAL PANEL ON", "Bool",  ss_stab2)

function stab2()
    fs2020_variable_write("L:ASCRJ_STAB_TRIM_CH2_TRIGGER",  "Number", 1) timer_start(100, function() fs2020_variable_write("L:ASCRJ_STAB_TRIM_CH2_TRIGGER", "Number", 0) end)
    sound_play(snd_click)
end
btn_stab2 = button_add(nil,"btn_push.png", 112,52,42,41, stab2) 