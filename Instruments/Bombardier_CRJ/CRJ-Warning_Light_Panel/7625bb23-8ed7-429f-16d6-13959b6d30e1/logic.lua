--[[
*****************************************************************
************Bombardier CRJ - Warning Light Panel*************
*****************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation
   
- **v1.0** 04-05-2022
    - Original Panel Created
- **v1.1** 03-06-2023
    - Graphics Replaced
    - Ambient Light Dimming Added

## Left To Do:
    - N/A
	
## Notes:
    - N/A
******************************************************************************************
--]]


img_add_fullscreen("background.png")
img_bg_night= img_add_fullscreen("background_night.png")
snd_click=sound_add("click.wav")
snd_cover_close=sound_add("cover_close.wav")
snd_cover_open=sound_add("cover_open.wav")

img_rollsel = img_add("rollsel.png", 27, 87, 53, 25) visible(img_rollsel,false)
img_pltroll = img_add("pltroll.png", 27, 114, 53, 25) visible(img_pltroll,false)
img_master_warning = img_add("warning.png", 106, 73, 69, 67) visible(img_master_warning,false)
img_master_caution =  img_add("caution.png", 199, 73, 69, 67) visible(img_master_caution,false)
img_stall =  img_add("stall.png", 291, 73, 69, 67) visible(img_stall,false)
img_pullup =  img_add("pullup.png", 386, 72, 66, 32) visible(img_pullup,false)
img_gndprox =  img_add("gndprox.png", 386, 107, 66, 32) visible(img_gndprox,false)
img_lh_fire =  img_add("lh_fire.png", 500, 37, 68, 67) visible(img_lh_fire,false)
img_lh_bottle =  img_add("lh_bottle.png", 509, 124, 52, 52) visible(img_lh_bottle,false)
img_apu_fire =  img_add("apu_fire.png", 617, 50, 40, 39) visible(img_apu_fire,false)
img_apu_bottle =  img_add("apu_bottle.png", 613, 126, 48, 48) visible(img_apu_bottle,false)
img_rh_fire =  img_add("rh_fire.png", 705, 37, 68, 67) visible(img_rh_fire,false)
img_rh_bottle =  img_add("rh_bottle.png", 713, 124, 52, 52) visible(img_rh_bottle,false)

img_stall_Cover_Dn = img_add("cover_fire_down.png", 276,44,102,114) 
img_stall_Cover_Up = img_add("cover_fire_up.png", 276,44,102,114) visible(img_stall_Cover_Up, false)
img_rh_fire_Cover_Dn = img_add("cover_fire_down.png", 688,6,102,114) 
img_rh_fire_Cover_Up = img_add("cover_fire_up.png", 688,6,102,114) visible(img_rh_fire_Cover_Up, false)
img_lh_fire_Cover_Dn = img_add("cover_fire_down.png", 484,6,102,114) 
img_lh_fire_Cover_Up = img_add("cover_fire_up.png", 484,6,102,114) visible(img_lh_fire_Cover_Up, false)
img_apu_fire_Cover_Dn = img_add("cover_fire_down.png", 603,28,68,76) 
img_apu_fire_Cover_Up = img_add("cover_fire_up.png", 603,28,68,76) visible(img_apu_fire_Cover_Up, false)

--Night
img_stall_Cover_Dn_night = img_add("cover_fire_down_night.png", 276,44,102,114) 
img_stall_Cover_Up_night = img_add("cover_fire_up_night.png", 276,44,102,114) visible(img_stall_Cover_Up_night, false)
img_rh_fire_Cover_Dn_night = img_add("cover_fire_down_night.png", 688,6,102,114) 
img_rh_fire_Cover_Up_night = img_add("cover_fire_up_night.png", 688,6,102,114) visible(img_rh_fire_Cover_Up_night, false)
img_lh_fire_Cover_Dn_night = img_add("cover_fire_down_night.png", 484,6,102,114) 
img_lh_fire_Cover_Up_night = img_add("cover_fire_up_night.png", 484,6,102,114) visible(img_lh_fire_Cover_Up_night, false)
img_apu_fire_Cover_Dn_night = img_add("cover_fire_down_night.png", 603,28,68,76) 
img_apu_fire_Cover_Up_night = img_add("cover_fire_up_night.png", 603,28,68,76) visible(img_apu_fire_Cover_Up_night, false)

-----------------------------------------------------------------

-- Ambient Light Control
function ss_ambient_darkness(value)
    opacity(img_bg_night, value, "LOG", 0.04)
    opacity(img_stall_Cover_Dn_night, value, "LOG", 0.04)
    opacity(img_stall_Cover_Up_night , value, "LOG", 0.04)        
    opacity(img_rh_fire_Cover_Dn_night, value, "LOG", 0.04)
    opacity(img_rh_fire_Cover_Up_night , value, "LOG", 0.04)  
    opacity(img_lh_fire_Cover_Dn_night, value, "LOG", 0.04)
    opacity(img_lh_fire_Cover_Up_night , value, "LOG", 0.04)  
    opacity(img_apu_fire_Cover_Dn_night, value, "LOG", 0.04)
    opacity(img_apu_fire_Cover_Up_night , value, "LOG", 0.04)              
end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)
-----------------------------------------------------------------
-----------------------------------------------------------------
btn_rollsel = button_add(nil, "button_pressed.png", 27, 87, 54, 54, 
    function ()
            sound_play(snd_click)
            fs2020_variable_write("L:ASCRJ_GSC_ROLL_SPLR","number",1) timer_start(50, function () fs2020_variable_write("L:ASCRJ_GSC_ROLL_SPLR","number",0) end) 
    end)
fs2020_variable_subscribe("L:ASCRJ_GSC_ROLL_SPLR_ROLLSEL", "Number", 
        function  (state)
            visible(img_rollsel, state)
end)   
fs2020_variable_subscribe("L:ASCRJ_GSC_ROLL_SPLR_PLTROLL", "Number", 
        function  (state)
            visible(img_pltroll, state)
end)

btn_warning = button_add(nil,"button_pressed.png", 106, 73, 69, 67, 
    function ()
            sound_play(snd_click)
            fs2020_variable_write("L:ASCRJ_MASTER_WARN","number",1) timer_start(50, function () fs2020_variable_write("L:ASCRJ_MASTER_WARN","number",0) end) 
     end)            
fs2020_variable_subscribe("L:ASCRJ_GSC_MASTER_WARN_ON", "Number", 
        function  (state)
            visible(img_master_warning, state)
end)

btn_caution = button_add(nil, "button_pressed.png", 199, 73, 69, 67, 
    function ()
            sound_play(snd_click)
            fs2020_variable_write("L:ASCRJ_MASTER_CAUT","number",1) timer_start(50, function () fs2020_variable_write("L:ASCRJ_MASTER_CAUT","number",0) end) 
    end)
fs2020_variable_subscribe("L:ASCRJ_GSC_MASTER_CAUT_ON", "Number", 
        function  (state)
            visible(img_master_caution, state)
end)    
            

btn_stall = button_add(nil,"button_pressed.png", 291, 73, 69, 67, 
    function ()
            sound_play(snd_click)
            fs2020_variable_write("L:ASCRJ_STALL","number",1) timer_start(50, function () fs2020_variable_write("L:ASCRJ_STALL","number",0) end) 
     end)
visible(btn_stall, false)            
fs2020_variable_subscribe("L:ASCRJ_GSC_STALL_BTN_STATE", "Number", 
        function  (state)
            visible(img_stall, state)
end)

function  cb_stall_Cover()
    timer_start(3000, timer_stall_Cover)    --call timer to close cover
    visible(btn_stall, true)                        --enable button
    visible(img_stall_Cover_Up, true)  visible(img_stall_Cover_Up_night, true)        --show up cover
    visible(img_stall_Cover_Dn, false) visible(img_stall_Cover_Dn_night, false)        --hide down cover
    sound_play(snd_cover_open)    
    visible(sw_stall_Cover, false)               --disable cover switch
    
end
sw_stall_Cover = switch_add(nil,nil, 291, 73, 69, 67, cb_stall_Cover)

function timer_stall_Cover()
    visible(img_stall_Cover_Dn, true) visible(img_stall_Cover_Dn_night, true)        --show dn cover
    visible(img_stall_Cover_Up, false) visible(img_stall_Cover_Up_night, false)        --hide up cover
    sound_play(snd_cover_close)    
    visible(btn_stall, false)                        --disable button
    visible(sw_stall_Cover, true)                 --enable cover switch
end

--
btn_pullup = button_add(nil, "button_pressed.png", 386, 72, 66, 66, 
    function ()
            sound_play(snd_click)
            fs2020_variable_write("L:ASCRJ_GPWS","number",1) timer_start(50, function () fs2020_variable_write("L:ASCRJ_GPWS","number",0) end) 
     end)            
     
fs2020_variable_subscribe("L:ASCRJ_GSF_GPWS_PULLUP", "Number", 
        function  (state)
            visible(img_pullup, state)
end)
fs2020_variable_subscribe("L:ASCRJ_GSF_GPWS_GNDPROX", "Number", 
        function  (state)
            visible(img_gndprox, state)
end)
---
btn_apu_fire = button_add(nil,"button_pressed.png", 617, 50, 40, 39, 
    function ()
            sound_play(snd_click)
            fs2020_variable_write("L:ASCRJ_GSF_APU_FIRE","number",1) timer_start(50, function () fs2020_variable_write("L:ASCRJ_GSF_APU_FIRE","number",0) end) 
     end)  
visible(btn_apu_fire, false)                    
fs2020_variable_subscribe("L:ASCRJ_GSF_APU_FIRE_ON", "Number", 
        function  (state)
            visible(img_apu_fire, state)
end)

function  cb_apu_fire_Cover()
    timer_start(3000, timer_apufire_Cover)    --call timer to close cover
    visible(btn_apu_fire, true)                        --enable button
    visible(img_apu_fire_Cover_Up, true)  visible(img_apu_fire_Cover_Up_night, true)        --show up cover
    visible(img_apu_fire_Cover_Dn, false) visible(img_apu_fire_Cover_Dn_night, false)        --hide down cover
    sound_play(snd_cover_open)    
    visible(sw_apu_fire_Cover, false)               --disable cover switch
    
end
sw_apu_fire_Cover = switch_add(nil,nil, 617, 50, 40, 39, cb_apu_fire_Cover)

function timer_apufire_Cover()
    visible(img_apu_fire_Cover_Dn, true) visible(img_apu_fire_Cover_Dn_night, true)        --show dn cover
    visible(img_apu_fire_Cover_Up, false) visible(img_apu_fire_Cover_Up_night, false)        --hide up cover
    sound_play(snd_cover_close)    
    visible(btn_apu_fire, false)                        --disable button
    visible(sw_apu_fire_Cover, true)                 --enable cover switch
end
-----

btn_apubottle = button_add(nil, "button_pressed.png", 612, 126, 49, 48,
    function ()
            sound_play(snd_click)
            fs2020_variable_write("L:ASCRJ_GSF_APU_BOTTLE","number",1) timer_start(50, function () fs2020_variable_write("L:ASCRJ_GSF_APU_BOTTLE","number",0) end) 
     end)            
fs2020_variable_subscribe("L:ASCRJ_GSF_APU_BOTTLE_ON", "Number", 
        function  (state)
            visible(img_apu_bottle, state)
end)
--

btn_lh_fire = button_add(nil,"button_pressed.png", 500, 37, 68, 67,
    function ()
            sound_play(snd_click)
            fs2020_variable_write("L:ASCRJ_GSC_ENG_FIRE","number",1) timer_start(50, function () fs2020_variable_write("L:ASCRJ_GSC_ENG_FIRE","number",0) end) 
     end)      
visible(btn_lh_fire, false)           
fs2020_variable_subscribe("L:ASCRJ_GSC_ENG_FIRE_ON", "Number", 
        function  (state)
            visible(img_lh_fire, state)
end)

function  cb_lh_fire_Cover()
    timer_start(3000, timer_lh_fire_Cover)    --call timer to close cover
    visible(btn_lh_fire, true)                        --enable button
    visible(img_lh_fire_Cover_Up, true)  visible(img_lh_fire_Cover_Up_night, true)        --show up cover
    visible(img_lh_fire_Cover_Dn, false) visible(img_lh_fire_Cover_Dn_night, false)        --hide down cover
    sound_play(snd_cover_open)    
    visible(sw_lh_fire_Cover, false)               --disable cover switch
    
end
sw_lh_fire_Cover = switch_add(nil,nil, 500, 37, 68, 67, cb_lh_fire_Cover)

function timer_lh_fire_Cover()
    visible(img_lh_fire_Cover_Dn, true) visible(img_lh_fire_Cover_Dn_night, true)        --show dn cover
    visible(img_lh_fire_Cover_Up, false) visible(img_lh_fire_Cover_Up_night, false)        --hide up cover
    sound_play(snd_cover_close)    
    visible(btn_lh_fire, false)                        --disable button
    visible(sw_lh_fire_Cover, true)                 --enable cover switch
end
--

btn_lhbottle = button_add(nil,"button_pressed.png",  509, 124, 52, 52,
    function ()
            sound_play(snd_click)
            fs2020_variable_write("L:ASCRJ_GSC_ENG_BOTTLE","number",1) timer_start(50, function () fs2020_variable_write("L:ASCRJ_GSC_ENG_BOTTLE","number",0) end)  
     end)            
fs2020_variable_subscribe("L:ASCRJ_GSC_ENG_BOTTLE_ON", "Number", 
        function  (state)
            visible(img_lh_bottle, state)
end)
--

btn_rh_fire = button_add(nil,"button_pressed.png", 705, 37, 68, 67,
    function ()
            sound_play(snd_click)
            fs2020_variable_write("L:ASCRJ_GSF_ENG_FIRE","number",1) timer_start(50, function () fs2020_variable_write("L:ASCRJ_GSF_ENG_FIRE","number",0) end)  
     end)  
visible(btn_rh_fire, false)                  
fs2020_variable_subscribe("L:ASCRJ_GSF_ENG_FIRE_ON", "Number", 
        function  (state)
            visible(img_rh_fire, state)
end)

function  cb_rh_fire_Cover()
    timer_start(3000, timer_rh_fire_Cover)    --call timer to close cover
    visible(btn_rh_fire, true)                        --enable button
    visible(img_rh_fire_Cover_Up, true)  visible(img_rh_fire_Cover_Up_night, true)        --show up cover
    visible(img_rh_fire_Cover_Dn, false) visible(img_rh_fire_Cover_Dn_night, false)        --hide down cover
    sound_play(snd_cover_open)    
    visible(sw_rh_fire_Cover, false)               --disable cover switch
    
end
sw_rh_fire_Cover = switch_add(nil,nil, 705, 37, 68, 67, cb_rh_fire_Cover)

function timer_rh_fire_Cover()
    visible(img_rh_fire_Cover_Dn, true) visible(img_rh_fire_Cover_Dn_night, true)        --show dn cover
    visible(img_rh_fire_Cover_Up, false) visible(img_rh_fire_Cover_Up_night, false)        --hide up cover
    sound_play(snd_cover_close)    
    visible(btn_rh_fire, false)                        --disable button
    visible(sw_rh_fire_Cover, true)                 --enable cover switch
end
--
btn_rhbottle = button_add(nil,"button_pressed.png",  713, 124, 52, 52,
    function ()
            sound_play(snd_click)
            fs2020_variable_write("L:ASCRJ_GSF_ENG_BOTTLE","number",1) timer_start(50, function () fs2020_variable_write("L:ASCRJ_GSF_ENG_BOTTLE","number",0) end) 
     end)            
fs2020_variable_subscribe("L:ASCRJ_GSF_ENG_BOTTLE_ON", "Number", 
        function  (state)
            visible(img_rh_bottle, state)
end)