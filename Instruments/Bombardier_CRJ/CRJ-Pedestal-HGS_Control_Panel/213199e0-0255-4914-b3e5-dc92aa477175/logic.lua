--[[
******************************************************************************************
******************Bombardier CRJ Pedestal-HGS Control Panel*************************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation

- **v1.0** 06-26-2022
    - Original Panel Created


##Left To Do:
    - Requires Pop Out, Future rebuild so pop outs not required.
	
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
fs2020_variable_subscribe("A:Light Potentiometer:4", "Number",
                                              "A:CIRCUIT GENERAL PANEL ON","Bool", ss_backlighting)
-- Ambient Light Control
function ss_ambient_darkness(value)
    opacity(img_bg_night, value, "LOG", 0.04)   
end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)

--------------------------------------------------------------------------------------------

img_HGS_Visible = img_add("led.png", 32, 182, 10, 10)
fs2020_variable_subscribe("L:ASCRJ_HGS_VISIBLE", "Number", 
         function  (state)
        switch_set_position(sw_HGS_Visible, state)
        visible(img_HGS_Visible, state)
end)

sw_HGS_Visible = switch_add(nil, nil, 30, 180, 35, 15,
    function (position)
        sound_play(snd_click)
        if (position == 1) then
             fs2020_variable_write("L:ASCRJ_HGS_VISIBLE","number",0) 
             fs2020_variable_write("L:ASCRJ_HGS_COMBINER_SET","number",0) 
             fs2020_variable_write("L:ASCRJ_HGS_COMBINER_SHOW","number",0) 
        else
             fs2020_variable_write("L:ASCRJ_HGS_VISIBLE","number",1) 
             fs2020_variable_write("L:ASCRJ_HGS_COMBINER_SET","number",1) 
             fs2020_variable_write("L:ASCRJ_HGS_COMBINER_SHOW","number",1)    
        end 
end)

btn_ACT = button_add(nil, "button_pressed.png", 35, 45, 35, 15, function() fs2020_variable_write("L:ASCRJ_HUD_ACT","number",1) sound_play(snd_click) timer_start(50, function() fs2020_variable_write("L:ASCRJ_HUD_ACT","number",0)end)end )
btn_STBY = button_add(nil, "button_pressed.png", 35, 75, 35, 15, function() fs2020_variable_write("L:ASCRJ_HUD_STBY","number",1) sound_play(snd_click) timer_start(50, function() fs2020_variable_write("L:ASCRJ_HUD_STBY","number",0)end)end )
btn_RWY = button_add(nil, "button_pressed.png", 35, 105, 35, 15, function() fs2020_variable_write("L:ASCRJ_HUD_RWY","number",1) sound_play(snd_click) timer_start(50, function() fs2020_variable_write("L:ASCRJ_HUD_RWY","number",0)end)end )
img_RWY_LED = img_add("led.png", 36, 108, 10, 10) fs2020_variable_subscribe("L:ASCRJ_HUD_RWY_LED", "Number", function  (state) visible(img_RWY_LED, state)   end)
btn_GS = button_add(nil, "button_pressed.png", 35, 135, 35, 15, function() fs2020_variable_write("L:ASCRJ_HUD_GS","number",1) sound_play(snd_click) timer_start(50, function() fs2020_variable_write("L:ASCRJ_HUD_GS","number",0)end)end )
img_GS_LED = img_add("led.png", 36, 138, 10, 10) fs2020_variable_subscribe("L:ASCRJ_HUD_GS_LED", "Number", function  (state) visible(img_GS_LED, state)  end)

btn_CLR = button_add(nil, "button_pressed.png", 80, 175, 35, 15, function() fs2020_variable_write("L:ASCRJ_HUD_CLR","number",1) sound_play(snd_click) timer_start(50, function() fs2020_variable_write("L:ASCRJ_HUD_CLR","number",0)end)end )
btn_BRT = button_add(nil, "button_pressed.png", 125, 175, 35, 15, function() fs2020_variable_write("L:ASCRJ_HUD_BRT","number",1) sound_play(snd_click) timer_start(50, function() fs2020_variable_write("L:ASCRJ_HUD_BRT","number",0)end)end )
btn_DIM = button_add(nil, "button_pressed.png", 167, 175, 35, 15, function() fs2020_variable_write("L:ASCRJ_HUD_DIM","number",1) sound_play(snd_click) timer_start(50, function() fs2020_variable_write("L:ASCRJ_HUD_DIM","number",0)end)end )

btn_KEY_1 = button_add(nil, "button_pressed.png", 222, 28, 25, 28, function() fs2020_variable_write("L:ASCRJ_HUD_KEY_1","number",1) sound_play(snd_click) timer_start(50, function() fs2020_variable_write("L:ASCRJ_HUD_KEY_1","number",0)end)end )
btn_KEY_2 = button_add(nil, "button_pressed.png", 262, 28, 25, 28, function() fs2020_variable_write("L:ASCRJ_HUD_KEY_2","number",1) sound_play(snd_click) timer_start(50, function() fs2020_variable_write("L:ASCRJ_HUD_KEY2","number",0)end)end )
btn_KEY_3 = button_add(nil, "button_pressed.png", 300, 28, 25, 28, function() fs2020_variable_write("L:ASCRJ_HUD_KEY_3","number",1) sound_play(snd_click) timer_start(50, function() fs2020_variable_write("L:ASCRJ_HUD_KEY_3","number",0)end)end )
btn_KEY_4 = button_add(nil, "button_pressed.png", 222, 68, 25, 28, function() fs2020_variable_write("L:ASCRJ_HUD_KEY_4","number",1) sound_play(snd_click) timer_start(50, function() fs2020_variable_write("L:ASCRJ_HUD_KEY_4","number",0)end)end )
btn_KEY_5 = button_add(nil, "button_pressed.png", 262, 68, 25, 28, function() fs2020_variable_write("L:ASCRJ_HUD_KEY_5","number",1) sound_play(snd_click) timer_start(50, function() fs2020_variable_write("L:ASCRJ_HUD_KEY_5","number",0)end)end )
btn_KEY_6 = button_add(nil, "button_pressed.png", 300, 68, 25, 28, function() fs2020_variable_write("L:ASCRJ_HUD_KEY_6","number",1) sound_play(snd_click) timer_start(50, function() fs2020_variable_write("L:ASCRJ_HUD_KEY_6","number",0)end)end )
btn_KEY_7 = button_add(nil, "button_pressed.png", 222, 115, 25, 28, function() fs2020_variable_write("L:ASCRJ_HUD_KEY_7","number",1) sound_play(snd_click) timer_start(50, function() fs2020_variable_write("L:ASCRJ_HUD_KEY_7","number",0)end)end )
btn_KEY_8 = button_add(nil, "button_pressed.png", 262, 115, 25, 28, function() fs2020_variable_write("L:ASCRJ_HUD_KEY_8","number",1) sound_play(snd_click) timer_start(50, function() fs2020_variable_write("L:ASCRJ_HUD_KEY_8","number",0)end)end )
btn_KEY_9 = button_add(nil, "button_pressed.png", 300, 115, 25, 28, function() fs2020_variable_write("L:ASCRJ_HUD_KEY_9","number",1) sound_play(snd_click) timer_start(50, function() fs2020_variable_write("L:ASCRJ_HUD_KEY_9","number",0)end)end )
btn_KEY_ENTER = button_add(nil, "button_pressed.png", 222, 162, 25, 28, function() fs2020_variable_write("L:ASCRJ_HUD_KEY_ENTER","number",1) sound_play(snd_click) timer_start(50, function() fs2020_variable_write("L:ASCRJ_HUD_KEY_ENTER","number",0)end)end )
btn_KEY_0 = button_add(nil, "button_pressed.png", 262, 162, 25, 28, function() fs2020_variable_write("L:ASCRJ_HUD_KEY_0","number",1) sound_play(snd_click) timer_start(50, function() fs2020_variable_write("L:ASCRJ_HUD_KEY_0","number",0)end)end )
btn_KEY_TEST = button_add(nil, "button_pressed.png", 300, 162, 25, 28, function() fs2020_variable_write("L:ASCRJ_HUD_KEY_TEST","number",1) sound_play(snd_click) timer_start(50, function() fs2020_variable_write("L:ASCRJ_HUD_KEY_TEST","number",0)end)end )
img_TEST_LED = img_add("led.png", 301, 163, 10, 10) fs2020_variable_subscribe("L:ASCRJ_HUD_KEY_TEST_LED", "Number", function  (state) visible(img_TEST_LED, state)  end)