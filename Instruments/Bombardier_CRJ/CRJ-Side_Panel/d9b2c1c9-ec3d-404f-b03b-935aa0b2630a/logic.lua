--[[
******************************************************************************************
******************Bombardier CRJ-Side Panel********************************************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation

- **v1.0**  06-21-2022 
    - Panel Created
- **v1.1**  02-21-2023
    - Graphics updated
    - All functions active

## Left To Do:
  - N/A
	
## Notes:
  - There is a user prop to set position to Pilot or CoPilot.
  - There is a user prop to show or hide the 5th Row Lighting Swithes, some may wish to hide this row as it may be useless to change the sim cockpit lighting.
 
******************************************************************************************               
--]]

--User Prop to set Pilot or CoPilot
prop_position_side = user_prop_add_enum("Position", "Pilot,CoPilot", "Pilot", "You can choose to control Pilot or CoPilot side")
if user_prop_get(prop_position_side) == "Pilot" then
    controlside = "L:ASCRJ_LSP_"
    else controlside = "L:ASCRJ_RSP_"
end  


prop_show_lighting = user_prop_add_enum("Show or Hide Bottom Lighting Panel", "Show Lighting Panel,Hide Lighting Panel", "Show Lighting", "You can choose to hide the bottom lighting panel.")
if user_prop_get(prop_show_lighting) == "Show Lighting" then
    lightingpanel = true
    img_add_fullscreen("background.png")
    img_bg_night = img_add_fullscreen("background_night.png")   
    img_labels_backlight = img_add_fullscreen("backlight.png")
else lightingpanel  = false
    img_add_fullscreen("background2.png")
    img_bg_night = img_add_fullscreen("background2_night.png")    
    img_labels_backlight = img_add_fullscreen("backlight2.png")    
end  


--Backlighting

function ss_backlighting(value, pwr)
    value = var_round(value,2) 
    if value == 0.0 or (pwr == false ) then 
        opacity(img_labels_backlight, 0, "LOG", 0.04) 
        opacity(img_dial_wiper_backlight, 0, "LOG", 0.04)         
        opacity(img_dial_pdf_mode_backlight, 0, "LOG", 0.04)      
        opacity(img_dial_light_dspl_backlight, 0, "LOG", 0.04)             
        opacity(img_dial_light_integ_backlight, 0, "LOG", 0.04)             
        opacity(img_dial_light_flood_backlight, 0, "LOG", 0.04)             
    else
        opacity(img_labels_backlight, (value), "LOG", 0.04)     
        opacity(img_dial_wiper_backlight, (value), "LOG", 0.04)              
        opacity(img_dial_pdf_mode_backlight, (value), "LOG", 0.04)  
        if (lightingpanel == true) then
            opacity(img_dial_light_dspl_backlight, (value), "LOG", 0.04)             
            opacity(img_dial_light_integ_backlight, (value), "LOG", 0.04)             
            opacity(img_dial_light_flood_backlight, (value), "LOG", 0.04)                               
        end
    end
end
fs2020_variable_subscribe("A:Light Potentiometer:5", "Number",
                                              "A:CIRCUIT GENERAL PANEL ON","Bool", ss_backlighting)



snd_click=sound_add("click.wav")
snd_dial=sound_add("dial.wav")


--Day Graphics   
img_knob_outer_refs = img_add("knob_selector_notched.png", 56,264,80,80)
img_knob_outer_height = img_add("knob_selector_notched.png", 214,188,80,80)
img_dial_wiper= img_add("knob_whiper.png",26,532,90,90)
img_sw_stickpusher_up = img_add("toggle_up.png", 208, 528, 125, 123)    
img_sw_stickpusher_dn = img_add("toggle_down.png", 208, 528, 125, 123) 
img_sw_nosewheel_up = img_add("toggle_up.png", 348, 528, 123, 123)    
img_sw_nosewheel_dn = img_add("toggle_down.png", 348, 528, 123, 123)    

if (lightingpanel == true) then
    img_light_dspl = img_add("knob_classic.png", 57,706,60,60)
    img_light_integ = img_add("knob_classic.png", 165,706,60,60)
    img_light_flood = img_add("knob_classic.png", 281,706,60,60)
    img_sw_light_floor_up = img_add("toggle_up.png", 362, 680, 123, 123)
    img_sw_light_floor_dn = img_add("toggle_down.png", 362, 680, 123, 123)    
 end
 
--Night Graphics   
img_knob_outer_refs_night = img_add("knob_selector_notched_night.png", 56,264,80,80)
img_knob_outer_height_night = img_add("knob_selector_notched_night.png", 214,188,80,80)
img_dial_wiper_night= img_add("knob_whiper_night.png",26,532,90,90)
img_sw_stickpusher_up_night = img_add("toggle_up_night.png", 208, 528, 125, 123)    
img_sw_stickpusher_dn_night = img_add("toggle_down_night.png", 208, 528, 125, 123) 
img_sw_nosewheel_up_night = img_add("toggle_up_night.png", 348, 528, 123, 123)    
img_sw_nosewheel_dn_night = img_add("toggle_down_night.png", 348, 528, 123, 123)   
if (lightingpanel == true) then
    img_light_dspl_night = img_add("knob_classic_night.png", 57,706,60,60)
    img_light_integ_night = img_add("knob_classic_night.png", 165,706,60,60)
    img_light_flood_night = img_add("knob_classic_night.png", 281,706,60,60)
    img_sw_light_floor_up_night = img_add("toggle_up_night.png", 362, 680, 123, 123)
    img_sw_light_floor_dn_night = img_add("toggle_down_night.png", 362, 680, 123, 123)
end

-- Ambient Light Control
function ss_ambient_darkness(value)
    opacity(img_bg_night, value, "LOG", 0.04)                
    opacity(img_dial_outer_range_night, value, "LOG", 0.04)        
    opacity(img_dial_inner_range_night, value, "LOG", 0.04)        
    opacity(img_navsource_night, value, "LOG", 0.04)      
    opacity(img_push_xside_night, value, "LOG", 0.04)           
    opacity(img_knob_outer_refs_night, value, "LOG", 0.04)    
    opacity(img_dial_inner_refs_night, value, "LOG", 0.04)      
    opacity(img_knob_outer_height_night, value, "LOG", 0.04)        
    opacity(img_dial_inner_height_night, value, "LOG", 0.04)       
    opacity(img_dial_baro_night, value, "LOG", 0.04)   
    opacity(img_push_std_night, value, "LOG", 0.04)       
    opacity(img_dial_pdf_mode_night, value, "LOG", 0.04)  
    opacity(img_dial_wiper_night, value, "LOG", 0.04)         
    opacity(img_sw_stickpusher_up_night, value, "LOG", 0.04)         
    opacity(img_sw_stickpusher_dn_night, value, "LOG", 0.04)   
    opacity(img_sw_nosewheel_up_night, value, "LOG", 0.04)         
    opacity(img_sw_nosewheel_dn_night, value, "LOG", 0.04)                 
    if (lightingpanel == true) then
        opacity(img_light_dspl_night, value, "LOG", 0.04)
        opacity(img_light_integ_night, value, "LOG", 0.04)
        opacity(img_light_flood_night, value, "LOG", 0.04)       
        opacity(img_sw_light_floor_up_night, value, "LOG", 0.04)         
        opacity(img_sw_light_floor_dn_night, value, "LOG", 0.04)    
    end
end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)

---------------------------------------------
----------ROW 1----------------     
---------------------------------------------    
button_add(nil,"button_pressed.png", 78,42,38,38, 
    function () fs2020_variable_write(controlside.."BRG1","number",1) sound_play(snd_click)  timer_start(100, function() fs2020_variable_write(controlside.."BRG1","number",0)end) end)
button_add(nil,"button_pressed.png", 78,110,38,38, 
    function () fs2020_variable_write(controlside.."BRG2","number",1) sound_play(snd_click) timer_start(100, function() fs2020_variable_write(controlside.."BRG2","number",0)end)end)
button_add(nil,"button_pressed.png", 176,110,38,38, 
    function () fs2020_variable_write(controlside.."RDR","number",1) sound_play(snd_click) timer_start(100, function() fs2020_variable_write(controlside.."RDR","number",0)end)end)
button_add(nil,"button_pressed.png", 298,110,38,38, 
    function () fs2020_variable_write(controlside.."TERR","number",1) sound_play(snd_click) timer_start(100, function() fs2020_variable_write(controlside.."TERR","number",0)end)end)
    
--Outer Format
local dial_range_outer_position = 0
function cb_dial_format(direction)
    dial_range_outer_position =dial_range_outer_position + (direction*10)
    if direction == 1 then
        fs2020_variable_write(controlside.."FORMAT_CHANGE","number",1) timer_start(100, function() fs2020_variable_write(controlside.."FORMAT_CHANGE","number",0)end)
        sound_play(snd_dial)
    else
        fs2020_variable_write(controlside.."FORMAT_CHANGE","number",-1) timer_start(100, function() fs2020_variable_write(controlside.."FORMAT_CHANGE","number",0)end)
        sound_play(snd_dial)   
    end 
    rotate(img_dial_outer_range, dial_range_outer_position)
end
dial_format= dial_add("dial_double_outer.png", 221,30, 72, 72,cb_dial_format)     
img_dial_outer_range_night = img_add("dial_double_outer_night.png", 221,30,72,72)           

--Inner Range    
local dial_range_inner_position = 0
function cb_dial_range(direction)
    dial_range_inner_position =dial_range_inner_position + (direction*10)
    if direction == 1 then
        fs2020_variable_write(controlside.."RANGE_CHANGE","number",1) timer_start(100, function() fs2020_variable_write(controlside.."RANGE_CHANGE","number",0)end)
        sound_play(snd_dial)
    else
        fs2020_variable_write(controlside.."RANGE_CHANGE","number",-1) timer_start(100, function() fs2020_variable_write(controlside.."RANGE_CHANGE","number",0)end)
        sound_play(snd_dial)   
    end 
end
dial_range= dial_add("dial_double_inner.png", 227,36,60,60, cb_dial_range)
img_dial_inner_range_night = img_add("dial_double_inner_night.png",  227,36,60,60)

--Nav Source
function cb_dial_navsource(direction)
    if direction == 1 then
        fs2020_variable_write(controlside.."NAV_SOURCE_CHANGE","number",1) timer_start(100, function() fs2020_variable_write(controlside.."NAV_SOURCE_CHANGE","number",0)end)
        sound_play(snd_dial)
    else
        fs2020_variable_write(controlside.."NAV_SOURCE_CHANGE","number",-1) timer_start(100, function() fs2020_variable_write(controlside.."NAV_SOURCE_CHANGE","number",0)end)
        sound_play(snd_dial)   
    end 
end
dial_navsource= dial_add("dial.png", 390,65,70,70,cb_dial_navsource)
img_navsource_night= img_add("dial_night.png", 390,65,70,70)
img_push_xside= img_add("dial_xside.png", 395,70,60,60)
img_push_xside_night= img_add("dial_xside_night.png", 395,70,60,60)

button_add(nil,"btn_round_push.png", 402,76,48,48, 
    function () fs2020_variable_write(controlside.."NAV_SOURCE_XSIDE","number",1) sound_play(snd_click) timer_start(100, function() fs2020_variable_write(controlside.."NAV_SOURCE_XSIDE","number",0)end)end)

---------------------------------------------
----------ROW 2----------------     
---------------------------------------------
button_add(nil,"button_pressed.png", 78,206,38,38, 
    function () fs2020_variable_write(controlside.."SEL","number",1) sound_play(snd_click) timer_start(100, function() fs2020_variable_write(controlside.."SEL","number",0)end)end) 
--Outer REFS
function ss_outer_refs(state)
    switch_set_position(switch_outer_refs, state)
    rotate(img_knob_outer_refs, (state*45)-22,"LOG", 0.1)
    rotate(img_knob_outer_refs_night, (state*45)-22,"LOG", 0.1)    
end
fs2020_variable_subscribe(controlside.."SPEED_MODE", "Number", ss_outer_refs)

function cb_sw_outer_refs(position)
    fs2020_variable_write(controlside.."SPEED_MODE","number",5) --setting to get AM to react
    if (position == 0 ) then fs2020_variable_write(controlside.."SPEED_MODE","number",1) 
    elseif (position == 1 ) then fs2020_variable_write(controlside.."SPEED_MODE","number",0) 
    end 
end
switch_outer_refs= switch_add(nil,nil, 56,264,80,80, "CIRCULAIR" ,cb_sw_outer_refs)
--Inner REFS    
local knob_refs_inner_position = 0
function cb_dial_inner_refs(direction)
    knob_refs_inner_position =knob_refs_inner_position + (direction*10)
    if direction == 1 then
        fs2020_variable_write(controlside.."SPEED_SEL_CHANGE","number",1) timer_start(100, function() fs2020_variable_write(controlside.."SPEED_SEL_CHANGE","number",0)end)
    else
        fs2020_variable_write(controlside.."SPEED_SEL_CHANGE","number",-1) timer_start(100, function() fs2020_variable_write(controlside.."SPEED_SEL_CHANGE","number",0)end)
    end  
    rotate(img_dial_inner_refs_night, knob_refs_inner_position)
    sound_play(snd_dial)   
end
dial_inner_refs= dial_add("dial_inner_push.png", 71,279,50,50,cb_dial_inner_refs)
img_dial_inner_refs_night = img_add("dial_inner_push_night.png", 71,279,50,50)

button_add(nil,"btn_round_push.png", 84,292,25,25, 
    function () fs2020_variable_write(controlside.."SPEED_SET","number",1) sound_play(snd_click) timer_start(100, function() fs2020_variable_write(controlside.."SPEED_SET","number",0)end )end )

--Middle Dial
--Outer Height Nide
function ss_outer_height(state)
    switch_set_position(switch_outer_height, state)
    rotate(img_knob_outer_height, (state*45)-22,"LOG", 0.1)
    rotate(img_knob_outer_height_night, (state*45)-22,"LOG", 0.1)       
end
fs2020_variable_subscribe(controlside.."HEIGHT_MODE", "Number", ss_outer_height)
function cb_sw_outer_height(position)
    fs2020_variable_write(controlside.."HEIGHT_MODE","number",5) --setting to get AM to react
    if (position == 0 ) then
        fs2020_variable_write(controlside.."HEIGHT_MODE","number",1)
    elseif (position == 1 ) then
        fs2020_variable_write(controlside.."HEIGHT_MODE","number",0)
    end 
end
switch_outer_height= switch_add(nil,nil, 214,188,80,80, "CIRCULAIR" ,cb_sw_outer_height)
--Inner height    
local knob_height_inner_position = 0
function cb_dial_inner_height(direction)
    knob_height_inner_position =knob_height_inner_position + (direction*10)
    if direction == 1 then
        fs2020_variable_write(controlside.."HEIGHT_SEL_CHANGE","number",1) timer_start(100, function() fs2020_variable_write(controlside.."HEIGHT_SEL_CHANGE","number",0)end) 
    else
        fs2020_variable_write(controlside.."HEIGHT_SEL_CHANGE","number",-1) timer_start(100, function() fs2020_variable_write(controlside.."HEIGHT_SEL_CHANGE","number",0)end)    
    end 
    rotate(img_dial_inner_height_night, knob_height_inner_position)    
        sound_play(snd_dial)    
end
dial_inner_height= dial_add("dial_inner_push.png", 229,203,50,50,cb_dial_inner_height)
img_dial_inner_height_night = img_add("dial_inner_push_night.png", 229,203,50,50)

button_add(nil,"btn_round_push.png", 242,215,25,25, 
    function () fs2020_variable_write(controlside.."HEIGHT_SET","number",1) sound_play(snd_click) timer_start(100, function() fs2020_variable_write(controlside.."HEIGHT_SET","number",0)end) end)

--RA Button
button_add(nil,"button_pressed.png", 238,304,38,38, 
    function () fs2020_variable_write(controlside.."RA_TEST_BTN","number",1) sound_play(snd_click) end, 
    function () fs2020_variable_write(controlside.."RA_TEST_BTN","number",0) end) 
--HPA Button
button_add(nil,"button_pressed.png", 398,206,38,38, 
    function () fs2020_variable_write(controlside.."HPA_IN","number",1) sound_play(snd_click) timer_start(100, function() fs2020_variable_write(controlside.."HPA_IN","number",0)end)end)     
--Baro Dial
function cb_dial_baro(direction)
    if direction == 1 then
        fs2020_variable_write(controlside.."BARO_CHANGE","number",1) timer_start(100, function() fs2020_variable_write(controlside.."BARO_CHANGE","number",0)end)
        sound_play(snd_dial)
    else
        fs2020_variable_write(controlside.."BARO_CHANGE","number",-1) timer_start(100, function() fs2020_variable_write(controlside.."BARO_CHANGE","number",0)end)
        sound_play(snd_dial)   
    end 
end
dial_baro= dial_add("dial.png", 382,270,70,70,cb_dial_baro)
img_dial_baro_night= img_add("dial_night.png", 382,270,70,70)
img_push_std= img_add("dial_std.png", 387,275,60,60)
img_push_std_night= img_add("dial_std_night.png", 387,275,60,60)
button_add(nil,"btn_round_push.png", 394,282,48,48, 
    function () fs2020_variable_write(controlside.."BARO_STD","number",1) sound_play(snd_click) timer_start(100, function() fs2020_variable_write(controlside.."BARO_STD","number",0)end)end)     
---------------------------------------------
----------ROW 3------------------------        
---------------------------------------------
img_dial_pdf_mode= img_add("round_knob.png",212,392,85,85)
img_dial_pdf_mode_night= img_add("round_knob_night.png",212,392,85,85)
img_dial_pdf_mode_backlight= img_add("backlight_round_knob.png",212,392,85,85)
function ss_pfd_mode(state)
    switch_set_position(switch_pfd_mode, state)
    rotate(img_dial_pdf_mode, -(58-(state*58)),"LOG", 0.1)
    rotate(img_dial_pdf_mode_night, -(58-(state*58)),"LOG", 0.1)    
    rotate(img_dial_pdf_mode_backlight, -(58-(state*58)),"LOG", 0.1)    
end
fs2020_variable_subscribe(controlside.."PFD_MODE", "Number", ss_pfd_mode)
function cb_sw_pfd_mode(position, direction)
 fs2020_variable_write(controlside.."PFD_MODE","number",1) 
    if (position == 0 and direction == 1 ) then
        fs2020_variable_write(controlside.."PFD_MODE","number",1) 
    elseif (position == 1 and direction == 1 ) then
        fs2020_variable_write(controlside.."PFD_MODE","number",2) 
    elseif (position == 1 and direction == -1 ) then
        fs2020_variable_write(controlside.."PFD_MODE","number",0)         
    elseif (position == 2 and direction == -1) then
        fs2020_variable_write(controlside.."PFD_MODE","number",1)               
    end 
end
switch_pfd_mode= switch_add(nil,nil,nil, 212,392,85,85, "CIRCULAIR" ,cb_sw_pfd_mode)  
---------------------------------------------
----------ROW 4----------------     
---------------------------------------------     

function ss_wiper(state)
    switch_set_position(switch_wiper, state)
    rotate(img_dial_wiper, ((state*30)),"LOG", 0.1)
    rotate(img_dial_wiper_night, ((state*30)),"LOG", 0.1)    
    rotate(img_dial_wiper_backlight, ((state*30)),"LOG", 0.1)    
end
fs2020_variable_subscribe(controlside.."WIPER", "Number", ss_wiper)
function cb_sw_wiper(position, direction)
 fs2020_variable_write(controlside.."WIPER","number",1) 
    if (position == 0 and direction == 1 ) then fs2020_variable_write(controlside.."WIPER","number",1) 
    elseif (position == 1 and direction == 1 ) then fs2020_variable_write(controlside.."WIPER","number",2) 
    elseif (position == 1 and direction == -1 ) then fs2020_variable_write(controlside.."WIPER","number",0)         
    elseif (position == 2 and direction == 1) then fs2020_variable_write(controlside.."WIPER","number",3)               
    elseif (position == 2 and direction == -1) then fs2020_variable_write(controlside.."WIPER","number",1)    
    elseif (position == 3 and direction == -1) then fs2020_variable_write(controlside.."WIPER","number",2)                     
    end 
end
switch_wiper = switch_add(nil,nil,nil,nil, 25,532,120,120, "CIRCULAIR" ,cb_sw_wiper)
img_dial_wiper_backlight= img_add("backlight_whiper.png",26,532,90,90)
--STICK PUSHER
function cb_stickpusher(position)
   fs2020_variable_write(controlside.."STICK_PUSHER","number",5) 
   if position == 0 then
        fs2020_variable_write(controlside.."STICK_PUSHER","number",1) 
    else
        fs2020_variable_write(controlside.."STICK_PUSHER","number",0) 
    end
end
sw_stickpusher = switch_add(nil, nil, 208, 528, 125, 123, cb_stickpusher)   


fs2020_variable_subscribe(controlside.."STICK_PUSHER", "Number",  
         function (state)
            switch_set_position(sw_stickpusher, state)
            visible(img_sw_stickpusher_up, state ==1)
            visible(img_sw_stickpusher_up_night, state ==1)
            visible(img_sw_stickpusher_dn, state ==0)
            visible(img_sw_stickpusher_dn_night, state ==0)      
        end) 
  
--NOSEWHEEL  
function cb_nosewheel(position)
   if position == 0 then
        fs2020_variable_write(controlside.."NW_STEER","number",1) 
    else
        fs2020_variable_write(controlside.."NW_STEER","number",0) 
    end
end
sw_nosewheel = switch_add(nil, nil, 348, 528, 125, 123, cb_nosewheel)    
        

fs2020_variable_subscribe(controlside.."NW_STEER", "Number",     
        function (state)
            switch_set_position(sw_nosewheel, state)
            visible(img_sw_nosewheel_up, state ==1)
            visible(img_sw_nosewheel_up_night, state ==1)
            visible(img_sw_nosewheel_dn, state ==0)
            visible(img_sw_nosewheel_dn_night, state ==0)      
        end) 
---------------------------------------------
----------ROW 5----------------     
---------------------------------------------
--Only show lighting in userprop says too:
if (lightingpanel == true) then

--DSPL
local local_light_dspl = 0
fs2020_variable_subscribe(controlside.."DSPL", "Number",     
        function (state)
            local_light_dspl = state
             rotate(img_light_dspl, (local_light_dspl*10)-130)
             rotate(img_light_dspl_night, (local_light_dspl*10)-130)             
             rotate(img_dial_light_dspl_backlight, (local_light_dspl*10)-130)                    
        end) 

function cb_light_dspl(direction) 
    if direction == 1 then fs2020_variable_write(controlside.."DSPL", "Number", var_cap(local_light_dspl+1,0,26) ) 
    else fs2020_variable_write(controlside.."DSPL", "Number", var_cap(local_light_dspl-1,0,26) )
    end 
end
dial_light_dspl = dial_add(nil, 57,705,60,60, cb_light_dspl)
img_dial_light_dspl_backlight= img_add("knob_classic_backlighting.png", 57,705,60,60)

--INTEG
local local_light_integ = 0
fs2020_variable_subscribe(controlside.."INTEG", "Number",     
        function (state)
            local_light_integ = state
             rotate(img_light_integ, (local_light_integ*10)-130)
             rotate(img_light_integ_night, (local_light_integ*10)-130)             
             rotate(img_dial_light_integ_backlight, (local_light_integ*10)-130)                
        end) 

function cb_light_integ(direction) 
    if direction == 1 then fs2020_variable_write(controlside.."INTEG", "Number", var_cap(local_light_integ+1,0,26) ) 
    else fs2020_variable_write(controlside.."INTEG", "Number", var_cap(local_light_integ-1,0,26) )
    end 
end
dial_light_integ = dial_add(nil, 165,706,60,60, cb_light_integ)
img_dial_light_integ_backlight= img_add("knob_classic_backlighting.png", 165,706,60,60)

--FLOOD
local local_light_flood = 0
fs2020_variable_subscribe(controlside.."FLOOD", "Number",     
        function (state)
            local_light_flood = state
             rotate(img_light_flood, (local_light_flood*10)-130)
             rotate(img_light_flood_night, (local_light_flood*10)-130)             
             rotate(img_dial_light_flood_backlight, (local_light_flood*10)-130)                  
        end) 

function cb_light_flood(direction) 
    if direction == 1 then fs2020_variable_write(controlside.."FLOOD", "Number", var_cap(local_light_flood+1,0,26) ) 
    else fs2020_variable_write(controlside.."FLOOD", "Number", var_cap(local_light_flood-1,0,26) )
    end 
end
dial_light_flood = dial_add(nil, 281,706,60,60, cb_light_flood)
img_dial_light_flood_backlight= img_add("knob_classic_backlighting.png", 281,706,60,60)

--FLOOR LIGHT  
function cb_light_floor(position)
   if position == 0 then fs2020_variable_write(controlside.."FLOOR","number",1) 
    else fs2020_variable_write(controlside.."FLOOR","number",0)     
    end
end
sw_light_floor = switch_add(nil,nil, 360, 680, 125, 123, cb_light_floor)    
fs2020_variable_subscribe(controlside.."FLOOR", "Number",   
        function (state)
            switch_set_position(sw_light_floor, state)
            visible(img_sw_light_floor_up, state ==1)
            visible(img_sw_light_floor_up_night, state ==1)
            visible(img_sw_light_floor_dn, state ==0)
            visible(img_sw_light_floor_dn_night, state ==0)      
        end)  
                
end --close user prop test                                               