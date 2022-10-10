--[[
******************************************************************************************
******************Bombardier CRJ Pedestal-ATC Transponder Panel********************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation

- **v1.0** 06-07-2022
    - Original Panel Created


##Left To Do:
    - N/A
	
##Notes:
    - N/A
        
--]]

snd_click = sound_add("click.wav")
snd_dial = sound_add("dial.wav")
img_add_fullscreen("background.png")
img_bg_night = img_add_fullscreen("background_night.png")

--=======Back  Lighting============
img_labels_backlight = img_add_fullscreen("backlighting.png")

function ss_backlighting(value, pwr)
    value = var_round(value*10,2) 
    if value == 0.0 or (pwr == false ) then 
        opacity(img_labels_backlight, 0, "LOG", 0.04)
        opacity(img_backlight_knob_ATC_SEL, 0, "LOG", 0.04)  
        opacity(img_backlight_radio_knob, 0, "LOG", 0.04)  
        opacity(img_backlight_tuning_inner, 0, "LOG", 0.04)                     
        opacity(img_backlight_tuning_outer, 0, "LOG", 0.04)    
                
    else
        opacity(img_labels_backlight, (value), "LOG", 0.04) 
        opacity(img_backlight_knob_ATC_SEL, (value), "LOG", 0.04) 
        opacity(img_backlight_radio_knob, (value), "LOG", 0.04) 
        opacity(img_backlight_tuning_inner, (value), "LOG", 0.04)                 
        opacity(img_backlight_tuning_outer, (value), "LOG", 0.04)            
    end
end
fs2020_variable_subscribe("A:Light Potentiometer:4", "Number",
                                              "A:CIRCUIT GENERAL PANEL ON","Bool", ss_backlighting)
-----------------------------------------------------------------
--Day Graphics
img_rtu1_inhb = img_add("rtu1_inhb.png", 48, 34, 35, 35)    
img_rtu2_inhb = img_add("rtu2_inhb.png", 100, 34, 35, 35)    
img_knob_ATC_SEL = img_add("round_knob.png", 80,116,65,65)
img_knob_XPDR_MODE = img_add("radio_knob.png", 203,130,35,35)
img_sw_COMNAV_up = img_add("white_flat_up.png", 296,53,15,40)   
img_sw_COMNAV_dn = img_add("white_flat_down.png", 296,53,15,40)  
img_sw_FMSINHIBIT_up = img_add("sw_circle_up.png", 40,125,30,60)  
img_sw_FMSINHIBIT_down = img_add("sw_circle_down.png", 40,125,30,60)  


--Night Graphics
img_knob_ATC_SEL_night = img_add("round_knob_night.png", 80,116,65,65)
img_knob_XPDR_MODE_night = img_add("radio_knob_night.png", 203,130,35,35)
img_sw_COMNAV_up_night = img_add("white_flat_up_night.png", 296,53,15,40)   
img_sw_COMNAV_dn_night = img_add("white_flat_down_night.png", 296,53,15,40)  
img_sw_FMSINHIBIT_up_night = img_add("sw_circle_up_night.png", 40,125,30,60)  
img_sw_FMSINHIBIT_down_night = img_add("sw_circle_down_night.png", 40,125,30,60)

--Backlighting
img_backlight_knob_ATC_SEL= img_add("backlight_round_knob.png", 80,116,65,65)
img_backlight_radio_knob= img_add("radio_knob_backlighting.png", 203,130,35,35)


-- Ambient Light Control
function ss_ambient_darkness(value)
    opacity(img_bg_night, value, "LOG", 0.04)
    opacity(img_knob_ATC_SEL_night, value, "LOG", 0.04)
    opacity(img_knob_XPDR_MODE_night, value, "LOG", 0.04)   
    opacity(img_tuning_outer_night, value, "LOG", 0.04)    
    opacity(img_tuning_inner_night, value, "LOG", 0.04)         
    opacity(img_sw_COMNAV_up_night, value, "LOG", 0.04)    --
    opacity(img_sw_COMNAV_dn_night, value, "LOG", 0.04)    --        
    opacity(img_sw_FMSINHIBIT_up_night, value, "LOG", 0.04)    --
    opacity(img_sw_FMSINHIBIT_down_night, value, "LOG", 0.04)    --     
end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)
-----------------------------------------------------------------
local com1_active_freq_txt        =   txt_add("", "font:wwdigital.ttf; size:22; color: red; halign:right;", 35,40,240,25)
local nav1_active_freq_txt        =   txt_add("", "font:wwDigital.ttf; size:22; color: red; halign:right;", 35,70,240,25)

 function frequency_set(comfreq, navfreq, xpdrmode, power)
    txt_set(com1_active_freq_txt,  string.format("%06.03f",comfreq / 1000))
    txt_set(nav1_active_freq_txt,  string.format("%06.03f", navfreq / 1000))      
    if (power ==true and xpdrmode ~= 0) then visible(com1_active_freq_txt, true) visible(nav1_active_freq_txt, true)
    else visible(com1_active_freq_txt, false) visible(nav1_active_freq_txt, false)
    end
 end
 fs2020_variable_subscribe("COM ACTIVE FREQUENCY:1", "KHz", 
                                               "NAV ACTIVE FREQUENCY:1", "KHz", 
                                               "L:ASCRJ_XPDR_MODE", "Number",
                                               "A:CIRCUIT GENERAL PANEL ON","Bool", frequency_set)
-----------------------------------------------------------------
-----------------------------------------------------------------
function ss_rtu1_inhb(inhb,pwr)
	visible(img_rtu1_inhb, (inhb ==1 and pwr ==true))
end        
fs2020_variable_subscribe("L:ASCRJ_RTU1_INH", "Number","A:CIRCUIT GENERAL PANEL ON","Bool",  ss_rtu1_inhb)
function rtu1_inhb()
    fs2020_variable_write("L:ASCRJ_RTU1_INH_TRIGGER",  "Number", 1) timer_start(100, function() fs2020_variable_write("L:ASCRJ_RTU1_INH_TRIGGER", "Number", 0) end)
    sound_play(snd_click)
end
    btn_rtu1 = button_add(nil,"btn_push.png", 48, 34, 35, 35, rtu1_inhb) 

function ss_rtu2_inhb(inhb,pwr)
	visible(img_rtu2_inhb, (inhb ==1 and pwr ==true))
end        
fs2020_variable_subscribe("L:ASCRJ_RTU2_INH", "Number","A:CIRCUIT GENERAL PANEL ON","Bool",  ss_rtu2_inhb)
function rtu2_inhb()
    fs2020_variable_write("L:ASCRJ_RTU2_INH_TRIGGER",  "Number", 1) timer_start(100, function() fs2020_variable_write("L:ASCRJ_RTU2_INH_TRIGGER", "Number", 0) end)
    sound_play(snd_click)
end
    btn_rtu2 = button_add(nil,"btn_push.png", 100, 34, 35, 35, rtu2_inhb) 

--ATC SEL
fs2020_variable_subscribe("L:ASCRJ_XPDR_ATC_SEL", "Number",
        function (position)
                switch_set_position(sw_ATC_SEL, (var_round(position,0)))             
                rotate(img_knob_ATC_SEL, (position*52)-52,"LOG", 0.1)
                rotate(img_knob_ATC_SEL_night, (position*52)-52,"LOG", 0.1)
                rotate(img_backlight_knob_ATC_SEL, (position*52)-52,"LOG", 0.1)
        end)           

sw_ATC_SEL = switch_add(nil,nil,nil, 80,116,65,65, "CIRCULAIR",
        function (pos,dir) fs2020_variable_write("L:ASCRJ_XPDR_ATC_SEL","Number", pos+dir) end)    
        
--XPDR MODE
fs2020_variable_subscribe("L:ASCRJ_XPDR_MODE", "Number",
        function (position)
                switch_set_position(sw_XPDR_MODE, (var_round(position,0)))             
                rotate(img_knob_XPDR_MODE, (position*32)-80,"LOG", 0.1)
                rotate(img_knob_XPDR_MODE_night, (position*32)-80,"LOG", 0.1)
                rotate(img_backlight_radio_knob, (position*32)-80,"LOG", 0.1)                
        end)           

sw_XPDR_MODE = switch_add(nil,nil,nil,nil, 203,130,35,35, "CIRCULAIR",
        function (pos,dir) fs2020_variable_write("L:ASCRJ_XPDR_MODE","Number", pos+dir) end)     


--------Tuning Knobs
--Outer    
local knob_outer_position = 0
function cb_knob_outer(direction)
    sound_play(snd_dial) 
    knob_outer_position =knob_outer_position + (direction*10)
    if direction == 1 then   
        fs2020_variable_write("L:ASCRJ_XPDR_KNOB_OUTER_CHANGE","number",1) rotate(img_tuning_outer_night, knob_outer_position)  rotate(img_backlight_tuning_outer, knob_outer_position)  
                timer_start(50, function() fs2020_variable_write("L:ASCRJ_XPDR_KNOB_OUTER_CHANGE","number",0) end)
    else
        fs2020_variable_write("L:ASCRJ_XPDR_KNOB_OUTER_CHANGE","number",-1) rotate(img_tuning_outer_night, knob_outer_position)   rotate(img_backlight_tuning_outer, knob_outer_position)  
                timer_start(50, function() fs2020_variable_write("L:ASCRJ_XPDR_KNOB_OUTER_CHANGE","number",0) end)    
    end    
end
dial_tuning_outer = dial_add("double_outer_knob.png", 260,115,60,60, cb_knob_outer) 
img_tuning_outer_night = img_add("double_outer_knob_night.png", 260,115,60,60)
img_backlight_tuning_outer = img_add("double_outer_knob_backlighting.png", 260,115,60,60)

--Inner                
local knob_inner_position = 0
function cb_knob_inner(direction)
    sound_play(snd_dial)
   knob_inner_position =knob_inner_position + (direction*10)
    if direction == 1 then
        fs2020_variable_write("L:ASCRJ_XPDR_KNOB_INNER_CHANGE","number",1) rotate(img_tuning_inner_night, knob_inner_position) rotate(img_backlight_tuning_inner, knob_inner_position)   
                timer_start(50, function() fs2020_variable_write("L:ASCRJ_XPDR_KNOB_INNER_CHANGE","number",0) end)
    else
        fs2020_variable_write("L:ASCRJ_XPDR_KNOB_INNER_CHANGE","number",-1) rotate(img_tuning_inner_night, knob_inner_position) rotate(img_backlight_tuning_inner, knob_inner_position)    
                timer_start(50, function() fs2020_variable_write("L:ASCRJ_XPDR_KNOB_INNER_CHANGE","number",0) end)    
    end
end
dial_tuning_inner = dial_add("double_inner_knob.png", 273,127,35,35, cb_knob_inner)   
img_tuning_inner_night = img_add("double_inner_knob_night.png", 273,127,35,35) 
img_backlight_tuning_inner= img_add("double_inner_knob_backlighting.png", 273,127,35,35)

--COM/NAV SWITCH
fs2020_variable_subscribe("L:ASCRJ_XPDR_COMNAV", "Number",   
        function (state)
            if state == 1 then visible(img_sw_COMNAV_up, false) visible(img_sw_COMNAV_dn, true) visible(img_sw_COMNAV_up_night, false) visible(img_sw_COMNAV_dn_night, true) 
            else  visible(img_sw_COMNAV_up, true) visible(img_sw_COMNAV_dn, false) visible(img_sw_COMNAV_up_night, true) visible(img_sw_COMNAV_dn_night, false) 
            end
            switch_set_position(sw_COMNAV, state)
        end) 
function cb_COMNAV(state) 
    if state == 1 then fs2020_variable_write("L:ASCRJ_XPDR_COMNAV", "Number", 0 ) 
    else fs2020_variable_write("L:ASCRJ_XPDR_COMNAV", "Number", 1 )
    end 
end
sw_COMNAV = switch_add(nil, nil, 296,53,15,40, cb_COMNAV)

--TUNE INHIBIT
fs2020_variable_subscribe("L:ASCRJ_XPDR_FMSINHIBIT", "Number",   
        function (state)
            if state == 1 then visible(img_sw_FMSINHIBIT_up, false) visible(img_sw_FMSINHIBIT_down, true) visible(img_sw_FMSINHIBIT_up_night, false) visible(img_sw_FMSINHIBIT_down_night, true) 
            else  visible(img_sw_FMSINHIBIT_up, true) visible(img_sw_FMSINHIBIT_down, false) visible(img_sw_FMSINHIBIT_up_night, true) visible(img_sw_FMSINHIBIT_down_night, false) 
            end
            switch_set_position(sw_FMSINHIBIT, state)
        end) 
function cb_FMSINHIBIT(state) 
    if state == 1 then fs2020_variable_write("L:ASCRJ_XPDR_FMSINHIBIT", "Number", 0 ) 
    else fs2020_variable_write("L:ASCRJ_XPDR_FMSINHIBIT", "Number", 1 )
    end 
end
sw_FMSINHIBIT = switch_add(nil, nil, 40,125,30,60, cb_FMSINHIBIT) 