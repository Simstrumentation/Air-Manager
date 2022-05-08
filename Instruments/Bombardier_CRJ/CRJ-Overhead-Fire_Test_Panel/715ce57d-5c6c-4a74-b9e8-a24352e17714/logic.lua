--[[
******************************************************************************************
****************Bombardier CRJ-Overhead-Fire Test Panel*******************************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation
   
- **v1.0** 03-26-2022
    - Original Panel Created


##Left To Do:
    - N/A
    
##Notes:
    - N/A
******************************************************************************************
--]]

--add backgrond image
img_add_fullscreen("background.png")
img_bg_night = img_add_fullscreen("background_night.png")

snd_click=sound_add("click.wav")

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

-- Ambient Light Control
function ss_ambient_darkness(value)
    opacity(img_bg_night, value, "LOG", 0.04)      
end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)


--Fire Test
sw_wshld_test= button_add(nil,"button_pressed.png", 239,79,158,115,
    function ()
            sound_play(snd_click)
            fs2020_variable_write("L:ASCRJ_FIRE_TEST","Number",1) timer_start(100, function() fs2020_variable_write("L:ASCRJ_FIRE_TEST","Number",0)end) 
    end)
   