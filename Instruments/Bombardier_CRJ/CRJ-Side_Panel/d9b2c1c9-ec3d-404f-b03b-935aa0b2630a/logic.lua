--[[
******************************************************************************************
******************Bombardier CRJ-Side Panel********************************************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation

- **v1.0**  06-21-2022 
    - Panel Created


##Left To Do:
    - Graphics all around
	
##Notes:
    - There is a user prop to set position to Pilot or CoPilot.
    - There is a user prop to show or hide the 5th Row Lighting Swithes, some may wish to hide this row as it may be useless to change the sim cockpit lighting.
        
--]]
--User Prop to set Pilot or CoPilot
prop_position_side = user_prop_add_enum("Position", "Pilot,CoPilot", "Pilot", "You can choose to control Pilot or CoPilot side")
if user_prop_get(prop_position_side) == "Pilot" then
    controlside = "L:ASCRJ_LSP_"
    else controlside = "L:ASCRJ_RSP_"
end  

prop_show_lighting = user_prop_add_enum("Show Lighting", "Show Lighting,Don't Show Lighting", "Show Lighting", "You can choose to hide the bottom lighting panel.")
if user_prop_get(prop_show_lighting) == "Show Lighting" then
    lightingpanel = true
    img_add_fullscreen("background3.png")
else lightingpanel  = false
    img_add_fullscreen("background2.png")
end  



snd_click=sound_add("click.wav")
snd_dial=sound_add("dial.wav")
   
---------------------------------------------
----------ROW 1----------------     
---------------------------------------------    
button_add(nil,"button_pressed.png", 85,42,35,35, 
    function () fs2020_variable_write(controlside.."BRG1","number",1) sound_play(snd_click)  timer_start(100, function() fs2020_variable_write(controlside.."BRG1","number",0)end) end)
button_add(nil,"button_pressed.png", 85,114,35,35, 
    function () fs2020_variable_write(controlside.."BRG2","number",1) sound_play(snd_click) timer_start(100, function() fs2020_variable_write(controlside.."BRG2","number",0)end)end)
button_add(nil,"button_pressed.png", 182,114,35,35, 
    function () fs2020_variable_write(controlside.."RDR","number",1) sound_play(snd_click) timer_start(100, function() fs2020_variable_write(controlside.."RDR","number",0)end)end)
button_add(nil,"button_pressed.png", 308,114,35,35, 
    function () fs2020_variable_write(controlside.."TERR","number",1) sound_play(snd_click) timer_start(100, function() fs2020_variable_write(controlside.."TERR","number",0)end)end)
    
--Outer Format
function cb_dial_format(direction)
    if direction == 1 then
        fs2020_variable_write(controlside.."FORMAT_CHANGE","number",1) timer_start(100, function() fs2020_variable_write(controlside.."FORMAT_CHANGE","number",0)end)
        sound_play(snd_dial)
    else
        fs2020_variable_write(controlside.."FORMAT_CHANGE","number",-1) timer_start(100, function() fs2020_variable_write(controlside.."FORMAT_CHANGE","number",0)end)
        sound_play(snd_dial)   
    end 
end
dial_format= dial_add("dial_outer.png", 224,40,70,70,cb_dial_format)                
--Inner Range    
function cb_dial_range(direction)
    if direction == 1 then
        fs2020_variable_write(controlside.."RANGE_CHANGE","number",1) timer_start(100, function() fs2020_variable_write(controlside.."RANGE_CHANGE","number",0)end)
        sound_play(snd_dial)
    else
        fs2020_variable_write(controlside.."RANGE_CHANGE","number",-1) timer_start(100, function() fs2020_variable_write(controlside.."RANGE_CHANGE","number",0)end)
        sound_play(snd_dial)   
    end 
end
dial_range= dial_add("dial_inner.png", 234,50,50,50,cb_dial_range)
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
dial_navsource= dial_add("dial_xside.png", 390,65,70,70,cb_dial_navsource)
button_add(nil,nil, 410,85,30,30, 
    function () fs2020_variable_write(controlside.."NAV_SOURCE_XSIDE","number",1) sound_play(snd_click) timer_start(100, function() fs2020_variable_write(controlside.."NAV_SOURCE_XSIDE","number",0)end)end)

---------------------------------------------
----------ROW 2----------------     
---------------------------------------------
button_add(nil,"button_pressed.png", 90,205,35,35, 
    function () fs2020_variable_write(controlside.."SEL","number",1) sound_play(snd_click) timer_start(100, function() fs2020_variable_write(controlside.."SEL","number",0)end)end) 
--Outer REFS
function ss_outer_refs(state)
    switch_set_position(switch_outer_refs, state)
end
fs2020_variable_subscribe(controlside.."SPEED_MODE", "Number", ss_outer_refs)
function cb_sw_outer_refs(position)
    if (position == 0 ) then
        fs2020_variable_write(controlside.."SPEED_MODE","number",1) 
    elseif (position == 1 ) then
        fs2020_variable_write(controlside.."SPEED_MODE","number",0) 
    end 
end
switch_outer_refs= switch_add("dial_selector0.png","dial_selector1.png", 70,270,80,80, "CIRCULAIR" ,cb_sw_outer_refs)
--Inner REFS    
function cb_dial_inner_refs(direction)
    if direction == 1 then
        fs2020_variable_write(controlside.."SPEED_SEL_CHANGE","number",1) timer_start(100, function() fs2020_variable_write(controlside.."SPEED_SEL_CHANGE","number",0)end)
        sound_play(snd_dial)
    else
        fs2020_variable_write(controlside.."SPEED_SEL_CHANGE","number",-1) timer_start(100, function() fs2020_variable_write(controlside.."SPEED_SEL_CHANGE","number",0)end)
        sound_play(snd_dial)   
    end 
end
dial_inner_refs= dial_add("dial_inner_push.png", 85,285,50,50,cb_dial_inner_refs)
button_add(nil,"button_pressed.png", 97,294,25,25, 
    function () fs2020_variable_write(controlside.."SPEED_SET","number",1) sound_play(snd_click) end)
--Middle Dial
--Outer Height Nide
function ss_outer_height(state)
    switch_set_position(switch_outer_height, state)
end
fs2020_variable_subscribe(controlside.."HEIGHT_MODE", "Number", ss_outer_height)
function cb_sw_outer_height(position)
    if (position == 0 ) then
        fs2020_variable_write(controlside.."HEIGHT_MODE","number",1)timer_start(100, function() fs2020_variable_write(controlside.."HEIGHT_MODE","number",0)end) 
    elseif (position == 1 ) then
        fs2020_variable_write(controlside.."HEIGHT_MODE","number",0) timer_start(100, function() fs2020_variable_write(controlside.."HEIGHT_MODE","number",0)end) 
    end 
end
switch_outer_height= switch_add("dial_selector0.png","dial_selector1.png", 225,190,80,80, "CIRCULAIR" ,cb_sw_outer_height)
--Inner height    
function cb_dial_inner_height(direction)
    if direction == 1 then
        fs2020_variable_write(controlside.."HEIGHT_SEL_CHANGE","number",1) timer_start(100, function() fs2020_variable_write(controlside.."HEIGHT_SEL_CHANGE","number",0)end) 
        sound_play(snd_dial)
    else
        fs2020_variable_write(controlside.."HEIGHT_SEL_CHANGE","number",-1) timer_start(100, function() fs2020_variable_write(controlside.."HEIGHT_SEL_CHANGE","number",0)end) 
        sound_play(snd_dial)   
    end 
end
dial_inner_height= dial_add("dial_inner_push.png", 240,205,50,50,cb_dial_inner_height)
button_add(nil,"button_pressed.png", 250,215,25,25, 
    function () fs2020_variable_write(controlside.."HEIGHT_SET","number",1) sound_play(snd_click) timer_start(100, function() fs2020_variable_write(controlside.."HEIGHT_SET","number",0)end) end)


button_add(nil,"button_pressed.png", 245,300,35,35, 
    function () fs2020_variable_write(controlside.."RA_TEST_BTN","number",1) sound_play(snd_click) end, 
    function () fs2020_variable_write(controlside.."RA_TEST_BTN","number",0) end) 

button_add(nil,"button_pressed.png", 390,205,35,35, 
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
dial_baro= dial_add("dial_std.png", 390,275,50,50,cb_dial_baro)
button_add(nil,"button_pressed.png", 400,283,30,30, 
    function () fs2020_variable_write(controlside.."BARO_STD","number",1) sound_play(snd_click) timer_start(100, function() fs2020_variable_write(controlside.."BARO_STD","number",0)end)end)     
---------------------------------------------
----------ROW 3------------------------        
---------------------------------------------
img_dial_pdf_mode= img_add("knob.png",220,396,85,85)
function ss_pfd_mode(state)
    switch_set_position(switch_pfd_mode, state)
    rotate(img_dial_pdf_mode, -(40-(state*40)))
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
switch_pfd_mode= switch_add(nil,nil,nil, 215,390,100,100, "CIRCULAIR" ,cb_sw_pfd_mode)  
---------------------------------------------
----------ROW 4----------------     
---------------------------------------------     
img_dial_wiper= img_add("knob_wht.png",35,536,70,90)
function ss_wiper(state)
    switch_set_position(switch_wiper, state)
    rotate(img_dial_wiper, ((state*25)))
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
switch_wiper = switch_add(nil,nil,nil,nil, 25,530,100,100, "CIRCULAIR" ,cb_sw_wiper)

--STICK PUSHER
function cb_stickpusher(position)
   if position == 0 then
        fs2020_variable_write(controlside.."STICK_PUSHER","number",1) 
    else
        fs2020_variable_write(controlside.."STICK_PUSHER","number",0) 
    end
end
sw_stickpusher = switch_add("red_switch_dn.png", "red_switch_up.png", 186, 527, 125, 123, cb_stickpusher)   


fs2020_variable_subscribe(controlside.."STICK_PUSHER", "Number",  
         function (state)
            if state ==1  then switch_set_position(sw_stickpusher, 1)
            else switch_set_position(sw_stickpusher, 0)
            end
        end) 
  
--NOSEWHEEL  
function cb_nosewheel(position)
   if position == 0 then
        fs2020_variable_write(controlside.."NW_STEER","number",1) 
    else
        fs2020_variable_write(controlside.."NW_STEER","number",0) 
    end
end
sw_nosewheel = switch_add("red_switch_dn.png", "red_switch_up.png", 348, 527, 125, 123, cb_nosewheel)    
        

fs2020_variable_subscribe(controlside.."NW_STEER", "Number",     
        function (state)
            if state ==1  then switch_set_position(sw_nosewheel, 1)
            else switch_set_position(sw_nosewheel, 0)
            end
        end) 
---------------------------------------------
----------ROW 5----------------     
---------------------------------------------
--Only show lighting in userprop says too:
if (lightingpanel == true) then

--DSPL
local local_light_dspl = 0
img_light_dspl = img_add("dial_light.png", 57,706,60,60)

fs2020_variable_subscribe(controlside.."DSPL", "Number",     
        function (state)
            local_light_dspl = state
             rotate(img_light_dspl, local_light_dspl*10)
        end) 

function cb_light_dspl(direction) 
    if direction == 1 then fs2020_variable_write(controlside.."DSPL", "Number", var_cap(local_light_dspl+1,0,26) ) 
    else fs2020_variable_write(controlside.."DSPL", "Number", var_cap(local_light_dspl-1,0,26) )
    end 
end
dial_light_dspl = dial_add(nil, 57,705,60,60, cb_light_dspl)

--INTEG
local local_light_integ = 0
img_light_integ = img_add("dial_light.png", 165,706,60,60)

fs2020_variable_subscribe(controlside.."INTEG", "Number",     
        function (state)
            local_light_integ = state
             rotate(img_light_integ, local_light_integ*10)
        end) 

function cb_light_integ(direction) 
    if direction == 1 then fs2020_variable_write(controlside.."INTEG", "Number", var_cap(local_light_integ+1,0,26) ) 
    else fs2020_variable_write(controlside.."INTEG", "Number", var_cap(local_light_integ-1,0,26) )
    end 
end
dial_light_integ = dial_add(nil, 165,706,60,60, cb_light_integ)

--FLOOD
local local_light_flood = 0
img_light_flood = img_add("dial_light.png", 281,706,60,60)

fs2020_variable_subscribe(controlside.."FLOOD", "Number",     
        function (state)
            local_light_flood = state
             rotate(img_light_flood, local_light_flood*10)
        end) 

function cb_light_flood(direction) 
    if direction == 1 then fs2020_variable_write(controlside.."FLOOD", "Number", var_cap(local_light_flood+1,0,26) ) 
    else fs2020_variable_write(controlside.."FLOOD", "Number", var_cap(local_light_flood-1,0,26) )
    end 
end
dial_light_flood = dial_add(nil, 285,690,60,60, cb_light_flood)

--FLOOR LIGHT  
function cb_light_floor(position)
   if position == 0 then fs2020_variable_write(controlside.."FLOOR","number",1) 
    else fs2020_variable_write(controlside.."FLOOR","number",0)     
    end
end
sw_light_floor = switch_add("red_switch_dn.png", "red_switch_up.png", 360, 675, 125, 123, cb_light_floor)    
fs2020_variable_subscribe(controlside.."FLOOR", "Number",   
        function (state)
            if state ==1  then  switch_set_position(sw_light_floor, 1)
            else  switch_set_position(sw_light_floor, 0)
            end
        end)  
                
end --close user prop test                                               