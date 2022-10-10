--[[
******************************************************************************************
******************Bombardier CRJ Pedestal-Weather Radar System Panel***************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation

- **v1.0** 09-19-2022
    - Original Panel Created


##Left To Do:
    - N/A
	
##Notes:
    - This instrument has a user prop to control either the Pilot or CoPilot side unit.  
        
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
                                              
--Day Graphics   
img_knob_GAIN = img_add("knob_gain.png", 24,37,76,76)
img_btn_GCS = img_add("btn_gcs.png", 42,56,40,40)
img_knob_MODE = img_add("knob_gain.png", 150,52,60,60)
img_knob_TILT = img_add("knob_tilt.png", 284,58,45,45)
img_btn_AUTO = img_add("btn_auto.png", 284,58,45,45)

--Night Graphics
img_knob_GAIN_night = img_add("knob_gain_night.png", 24,37,76,76)
img_btn_GCS_night = img_add("btn_gcs_night.png", 42,56,40,40)
img_knob_MODE_night = img_add("knob_gain_night.png", 150,52,60,60)
img_knob_TILT_night = img_add("knob_tilt_night.png", 284,58,45,45)
img_btn_AUTO_night = img_add("btn_auto_night.png", 284,58,45,45)

-- Ambient Light Control
function ss_ambient_darkness(value)
    opacity(img_bg_night, value, "LOG", 0.04)
    opacity(img_knob_GAIN_night, value, "LOG", 0.04)
    opacity(img_btn_GCS_night , value, "LOG", 0.04)   
    opacity(img_knob_MODE_night, value, "LOG", 0.04)
    opacity(img_knob_TILT_night, value, "LOG", 0.04)      
    opacity(img_btn_AUTO_night, value, "LOG", 0.04)       
end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)

--------------------------------------------------------------------------------------------
--User Prop to set Control Panel
prop_ControlPanel = user_prop_add_enum("Weather Radar Panel", "Pilot,CoPilot", "Pilot", "You can choose to make this instrument Pilot Side or CoPilot Side")
if user_prop_get(prop_ControlPanel) == "Pilot" then
    controlside = "L:ASCRJ_WXR1_"
    elseif user_prop_get(prop_ControlPanel) == "CoPilot" then
    controlside = "L:ASCRJ_WXR2_"     
end   

-------------------------------------------------------------------
--GAIN KNOB
fs2020_variable_subscribe(controlside.."GAIN", "Number",
        function (position)
                switch_set_position(sw_GAIN, (var_round(position,0)))             
                rotate(img_knob_GAIN, (position*30)-90,"LOG", 0.1)
                rotate(img_knob_GAIN_night, (position*30)-90,"LOG", 0.1)
        end)           

sw_GAIN = switch_add(nil,nil,nil,nil,nil,nil,nil, 24,37,76,76, "CIRCULAIR",
        function (pos,dir) fs2020_variable_write(controlside.."GAIN","Number", pos+dir) end) 
        
--GCS BUTTON    
btn_gain_gcs = button_add(nil, "btn_round_push.png", 42,56,40,40,
    function() fs2020_variable_write(controlside.."GCS","number",1) 
    sound_play(snd_click) 
    timer_start(50, function() fs2020_variable_write(controlside.."GCS","number",0)end)
    end )        
-------------------------------------------------------------------
--SEC BUTTON    
btn_wxr_sec = button_add(nil, "btn_push.png", 126, 18, 25, 24, 
    function() fs2020_variable_write(controlside.."SEC","number",1) 
    sound_play(snd_click) 
    timer_start(50, function() fs2020_variable_write(controlside.."SEC","number",0)end)
    end )
--XFR BUTTON    
btn_wxr_xfr = button_add(nil, "btn_push.png", 168, 18, 25, 24, 
    function() fs2020_variable_write(controlside.."XFR","number",1) 
    sound_play(snd_click) 
    timer_start(50, function() fs2020_variable_write(controlside.."XFR","number",0)end)
    end )
--STAB BUTTON    
btn_wxr_stab = button_add(nil, "btn_push.png", 208, 18, 25, 24, 
    function() fs2020_variable_write(controlside.."STAB","number",1) 
    sound_play(snd_click) 
    timer_start(50, function() fs2020_variable_write(controlside.."STAB","number",0)end)
    end )

--MODE KNOB
fs2020_variable_subscribe(controlside.."MODE", "Number",
        function (position)
                switch_set_position(sw_MODE, (var_round(position,0)))             
                rotate(img_knob_MODE, (position*40)-60,"LOG", 0.1)
                rotate(img_knob_MODE_night, (position*40)-60,"LOG", 0.1)
        end)           

sw_MODE = switch_add(nil,nil,nil,nil, 150,56,60,60, "CIRCULAIR",
        function (pos,dir) fs2020_variable_write(controlside.."MODE","Number", pos+dir) end) 
        
--TILT KNOB
fs2020_variable_subscribe(controlside.."TILT", "Number",
        function (position)
                switch_set_position(sw_TILT, (var_round(position,0)))             
                rotate(img_knob_TILT, (position*40)-60,"LOG", 0.1)
                rotate(img_knob_TILT_night, (position*40)-60,"LOG", 0.1)
        end)           

sw_TILT = switch_add(nil,nil,nil,nil,nil,nil,nil, 284,58,45,45, "CIRCULAIR",
        function (pos,dir) fs2020_variable_write(controlside.."TILT","Number", pos+dir) end)
            
--AUTO BUTTON    
btn_tilt_auto = button_add(nil, "btn_round_push.png", 290,63,34,34,
    function() fs2020_variable_write(controlside.."TILT_AUTO","number",1) 
    sound_play(snd_click) 
    timer_start(50, function() fs2020_variable_write(controlside.."TILT_AUTO","number",0)end)
    end )     