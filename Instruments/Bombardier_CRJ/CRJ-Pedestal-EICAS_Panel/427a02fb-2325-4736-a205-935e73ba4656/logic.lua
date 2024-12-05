--[[
******************************************************************************************
******************Bombardier CRJ Pedestal-EICAS Panel********************************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation

- **v1.0**  06-17-2022
    - Panel Created


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

-- Ambient Light Control
function ss_ambient_darkness(value)
    opacity(img_bg_night, value, "LOG", 0.04)   
end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)

local button_delay = 15

--Button Sizes
    ButtonWidth = 38
    ButtonHeight = 24

--First Row
button_add(nil,"button_pressed.png", 22,20,ButtonWidth,ButtonHeight, 
    function () msfs_variable_write("L:ASCRJ_ECAM_PRI","Number",1) sound_play(snd_click) timer_start(50, function() msfs_variable_write("L:ASCRJ_ECAM_PRI","Number",0) end)end)

button_add(nil,"button_pressed.png", 76,20,ButtonWidth,ButtonHeight, 
    function () msfs_variable_write("L:ASCRJ_ECAM_STAT","Number",1) sound_play(snd_click) timer_start(50, function() msfs_variable_write("L:ASCRJ_ECAM_STAT","Number",0) end)end)

button_add(nil,"button_pressed.png", 130,20,ButtonWidth,ButtonHeight, 
    function () msfs_variable_write("L:ASCRJ_ECAM_ECS","Number",1) sound_play(snd_click) timer_start(50, function() msfs_variable_write("L:ASCRJ_ECAM_ECS","Number",0) end)end)

button_add(nil,"button_pressed.png", 187,20,ButtonWidth,ButtonHeight, 
    function () msfs_variable_write("L:ASCRJ_ECAM_HYD","Number",1) sound_play(snd_click) timer_start(50, function() msfs_variable_write("L:ASCRJ_ECAM_HYD","Number",0) end)end)

button_add(nil,"button_pressed.png", 241,20,ButtonWidth,ButtonHeight, 
    function () msfs_variable_write("L:ASCRJ_ECAM_ELEC","Number",1) sound_play(snd_click) timer_start(50, function()  msfs_variable_write("L:ASCRJ_ECAM_ELEC","Number",0) end)end)   

button_add(nil,"button_pressed.png", 295,20,ButtonWidth,ButtonHeight, 
    function () msfs_variable_write("L:ASCRJ_ECAM_FUEL","Number",1) sound_play(snd_click) timer_start(50, function() msfs_variable_write("L:ASCRJ_ECAM_FUEL","Number",0) end)end)      
--Second Row
button_add(nil,"button_pressed.png", 22,68,ButtonWidth,ButtonHeight, 
    function () msfs_variable_write("L:ASCRJ_ECAM_FCTL","Number",1) sound_play(snd_click) timer_start(50, function() msfs_variable_write("L:ASCRJ_ECAM_FCTL","Number",0) end)end)           
    
button_add(nil,"button_pressed.png", 78,68,ButtonWidth,ButtonHeight, 
    function () msfs_variable_write("L:ASCRJ_ECAM_AICE","Number",1) sound_play(snd_click) timer_start(50, function() msfs_variable_write("L:ASCRJ_ECAM_AICE","Number",0) end)end)      

button_add(nil,"button_pressed.png", 132,68,ButtonWidth,ButtonHeight, 
    function () msfs_variable_write("L:ASCRJ_ECAM_DOORS","Number",1) sound_play(snd_click) timer_start(50, function() msfs_variable_write("L:ASCRJ_ECAM_DOORS","Number",0) end)end)      

button_add(nil,"circle_button_pressed.png", 216,64,28,28, 
    function () msfs_variable_write("L:ASCRJ_ECAM_SEL","Number",1) sound_play(snd_click) timer_start(50, function() msfs_variable_write("L:ASCRJ_ECAM_SEL","Number",0) end)end)      
--Third Row
button_add(nil,"button_pressed.png", 22,119,ButtonWidth,ButtonHeight, 
    function () msfs_variable_write("L:ASCRJ_ECAM_CAS","Number",1) sound_play(snd_click) timer_start(50, function() msfs_variable_write("L:ASCRJ_ECAM_CAS","Number",0) end)end)      

button_add(nil,"button_pressed.png", 77,119,ButtonWidth,ButtonHeight, 
    function () msfs_variable_write("L:ASCRJ_ECAM_BLANK","Number",1) sound_play(snd_click) timer_start(50, function() msfs_variable_write("L:ASCRJ_ECAM_BLANK","Number",0) end)end)      

button_add(nil,"button_pressed.png", 132,119,ButtonWidth,ButtonHeight, 
    function () msfs_variable_write("L:ASCRJ_ECAM_MENU","Number",1) sound_play(snd_click) timer_start(50, function() msfs_variable_write("L:ASCRJ_ECAM_MENU","Number",0) end)end)      

button_add(nil,"button_pressed.png", 186,119,ButtonWidth,ButtonHeight, 
    function () msfs_variable_write("L:ASCRJ_ECAM_UP","Number",1)  sound_play(snd_click) timer_start(50, function() msfs_variable_write("L:ASCRJ_ECAM_UP","Number",0) end)end)      

button_add(nil,"button_pressed.png", 240,119,ButtonWidth,ButtonHeight, 
    function () msfs_variable_write("L:ASCRJ_ECAM_DOWN","Number",1) sound_play(snd_click) timer_start(50, function() msfs_variable_write("L:ASCRJ_ECAM_DOWN","Number",0) end)end)          

button_add(nil,"button_pressed.png", 295,119,ButtonWidth,ButtonHeight, 
    function () msfs_variable_write("L:ASCRJ_ECAM_STEP","Number",1) sound_play(snd_click) timer_start(50, function() msfs_variable_write("L:ASCRJ_ECAM_STEP","Number",0) end)end)             