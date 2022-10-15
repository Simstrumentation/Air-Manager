--[[
******************************************************************************************
*******CESSNA 414AW CHANCELLOR PRESSUR DUMP AND O2 CONTROL ***********
******************************************************************************************
    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://simstrumentation.com

Pressure dump and emergency oxygen control panel for the Cessna 414AWChancellor by FlySimware

Version info:
- **v1.0** - 2022-10-15

NOTES: 
- Designed to match the appearance of the C414AW
- Will only work with the Flysimware C414AW

KNOWN ISSUES:
- None

ATTRIBUTION:
Code and graphics by Simstrumentation
Sharing or re-use of any code or assets is not permitted without credit to the original authors.

Font : Mil Spec 33558
http://www.fontsaddict.com/font/MilSpec33558.html
******************************************************************************************

]]--
--***********************************************USER PROPERTY CONFIG***********************************************
font_color = user_prop_add_enum("Text Color","White, Black","White","Select color of labels")    -- user selects font color based on their background
--********************************************* END USER PROPERTY CONFIG*********************************************

--LOCAL VARIABLES
local doorSwitch = 0
local dumpLeverPos = 0
local dumpLPos = 0
local dumpRPos = 0
local oxyPos = 0

if user_prop_get(font_color ) == "White" then
    text_color = "#DDDDDDFF"
else
    text_color = "#020202FF"
end

    --text labels
txtRamDump = txt_add("RAM DUMP", "font:MS33558.ttf; size:24; color: "..tostring(text_color)..";  halign:center;", 190, 1, 300, 100)
txtPull = txt_add("PULL", "font:MS33558.ttf; size:24; color: "..tostring(text_color)..";  halign:center;", 190, 24, 300, 100)
txtDoor = txt_add("DOOR", "font:MS33558.ttf; size:24; color: "..tostring(text_color)..";  halign:center;", 88, 350, 100, 100)
txtLight = txt_add("LIGHT", "font:MS33558.ttf; size:24; color: "..tostring(text_color)..";  halign:center;", 88, 375, 100, 100)
txtLH = txt_add("LH", "font:MS33558.ttf; size:24; color: "..tostring(text_color)..";  halign:center;", 80, 145, 100, 100)
txtRH = txt_add("RH", "font:MS33558.ttf; size:24; color: "..tostring(text_color)..";  halign:center;", 480, 145, 100, 100)
txtPressAir = txt_add("PRESS AIR", "font:MS33558.ttf; size:24; color: "..tostring(text_color)..";  halign:center;", 190, 225, 300, 100)
txtPull2 = txt_add("PULL", "font:MS33558.ttf; size:24; color: "..tostring(text_color)..";  halign:center;", 190, 255, 300, 100)
txtToDump = txt_add("TO DUMP", "font:MS33558.ttf; size:24; color: "..tostring(text_color)..";  halign:center;", 190, 285, 300, 100)
 
       --graphics
    --    light switch
img_add("switch_base.png", 56.5, 350, 160, 160)    
function swtchTest()
print("SWTCHTEST:"..doorSwitch)    
    if doorSwitch == 1 then
        fs2020_variable_write("L:DOOR_LIGHT1", "Number", 0)            
        fs2020_variable_write("A:LIGHT PEDESTRAL:10", "Number", 0)   -- Yeah, Pedestral, with an extra R.  That's how it's spelled in the Dev Mode.  It doesn't work if you spell it correctly         
    else
        fs2020_variable_write("L:DOOR_LIGHT1", "Number", 1)            
        fs2020_variable_write("A:LIGHT PEDESTRAL:10", "Number", 1)            
    end
end
door_light_id = switch_add("switch_down.png", "switch_up.png", 107, 355, 60, 150, swtchTest)

function new_door_callback(val)
   print("Door State: " .. val)
   doorSwitch = val
   if val == 1 then
        switch_set_position(door_light_id, 1)   
   else
        switch_set_position(door_light_id, 0)   
   end
   --swtchTest()
end

fs2020_variable_subscribe("L:DOOR_LIGHT1", "Number", new_door_callback)            


dump_lever_shadow_id =img_add("knob_shadow.png", 235, 25, 200, 200)
opacity(dump_lever_shadow_id, 0.5)
dump_lever_id =img_add("dump_knob.png", 225, 16, 200, 200)

dump_l_shadow_id = img_add("knob_shadow.png", 35, 160, 200, 200)
opacity(dump_l_shadow_id, 0.5)
dump_l_id = img_add("lock_knob.png", 25, 150, 200, 200)

dump_r_shadow_id = img_add("knob_shadow.png", 435, 160, 200, 200)
opacity(dump_r_shadow_id, 0.5)
dump_r_id = img_add("lock_knob.png", 425, 150, 200, 200)

oxy_lever_shadow_id = img_add("knob_shadow.png", 235, 310, 200, 200)
opacity(oxy_lever_shadow_id, 0.5)
oxy_lever_id = img_add("oxy_lever.png", 225, 300, 200, 200)



    --    dump ram
function dumpLeverCB()
    if dumpLeverPos == 1 then
        move(dump_lever_id, 200, 26, 220, 220, "LINEAR", 0.1)
        move(dump_lever_shadow_id, 255, 45, 210, 210, "LINEAR", 0.1)
        opacity(dump_lever_shadow_id, 0.3, "LINEAR", 0.1)
        dumpLeverPos = 0
        fs2020_variable_write("L:PRESSURIZATION_DUMP_LEVER", "Number", 1)            
    else
        move(dump_lever_id,225, 16, 200, 200, "LINEAR", 0.1)
        move(dump_lever_shadow_id, 235, 25, 200, 200, "LINEAR", 0.1)
        opacity(dump_lever_shadow_id, 0.5, "LINEAR", 0.1)
        dumpLeverPos = 1
        fs2020_variable_write("L:PRESSURIZATION_DUMP_LEVER", "Number", 0)            
    end
end
dump_lever_button =button_add(nil, nil, 225, 16, 200, 200, dumpLeverCB)

function new_dump_callback(val)
   --print("Dump State: " .. val)
   dumpLeverPos = val
   dumpLeverCB()
end

fs2020_variable_subscribe("L:PRESSURIZATION_DUMP_LEVER", "Number", new_dump_callback)            

    --    LH Dump
function dumpLCB()
    if dumpLPos == 100 then
        rotate(dump_l_id, -90, "LINEAR", 0.04)
        timer_start(400, function() move(dump_l_id, 1, 175, 220, 220, "LINEAR", 0.1) move(dump_l_shadow_id, 55, 180, 210, 210, "LINEAR", 0.1) opacity(dump_l_shadow_id, 0.3, "LINEAR", 0.1) end)
        dumpLPos = 0
        fs2020_variable_write("L:XMLVAR_PRESSURIZATION_CONTROL_LEFT_Position", "Number", 100)
    else
        move(dump_l_id, 25, 150, 200, 200, "LINEAR", 0.1) 
        move(dump_l_shadow_id, 35, 160, 200, 200, "LINEAR", 0.1) 
        opacity(dump_l_shadow_id, 0.5, "LINEAR", 0.1) 
        timer_start(400, function()  rotate(dump_l_id, 0, "LINEAR", 0.1) end)
        dumpLPos = 100
        fs2020_variable_write("L:XMLVAR_PRESSURIZATION_CONTROL_LEFT_Position", "Number", 0)
    end
end
dump_l_button = button_add(nil, nil, 25, 150, 200, 200, dumpLCB)

function new_dump_l_callback(val)
   --print("Dump L State: " .. val)
   dumpLPos = val
   dumpLCB()
end

 -- Subscribe to FS2020 variables on the databus
fs2020_variable_subscribe("L:XMLVAR_PRESSURIZATION_CONTROL_LEFT_Position", "Number", new_dump_l_callback)            

    --    RH Dump

function dumpRCB()
    if dumpRPos == 100 then
        rotate(dump_r_id, -90, "LINEAR", 0.04)
        timer_start(400, function() move(dump_r_id, 400, 175, 220, 220, "LINEAR", 0.1) move(dump_r_shadow_id, 455, 180, 210, 210, "LINEAR", 0.1) opacity(dump_r_shadow_id, 0.3, "LINEAR", 0.1) end)
        dumpRPos = 0
        fs2020_variable_write("L:XMLVAR_PRESSURIZATION_CONTROL_RIGHT_Position", "Number", 100)
    else
        move(dump_r_id, 425, 150, 200, 200, "LINEAR", 0.1) 
        move(dump_r_shadow_id, 435, 160, 200, 200, "LINEAR", 0.1) 
        opacity(dump_r_shadow_id, 0.5, "LINEAR", 0.1) 
        timer_start(400, function()  rotate(dump_r_id, 0, "LINEAR", 0.1) end)
        dumpRPos = 100
        fs2020_variable_write("L:XMLVAR_PRESSURIZATION_CONTROL_RIGHT_Position", "Number", 0)
    end
end
dump_r_button = button_add(nil, nil, 425, 150, 200, 200, dumpRCB)

function new_dump_r_callback(val)
   --print("Dump R State: " .. val)
   dumpRPos = val
   dumpRCB()
end

 -- Subscribe to FS2020 variables on the databus
fs2020_variable_subscribe("L:XMLVAR_PRESSURIZATION_CONTROL_RIGHT_Position", "Number", new_dump_r_callback)            

    --    Oxygen
    --    dump ram
function OxyLeverCB()
    if oxyLeverPos == 1 then
        move(oxy_lever_id , 200, 325, 220, 220, "LINEAR", 0.1)
        move(oxy_lever_shadow_id , 255, 330, 210, 210, "LINEAR", 0.1)
        opacity(oxy_lever_shadow_id , 0.3, "LINEAR", 0.1)
        oxyLeverPos = 0
        fs2020_variable_write("L:EMER_OXYGEN_PULL", "Number", 1)
    else
        move(oxy_lever_id , 225, 300, 200, 200, "LINEAR", 0.1)
        move(oxy_lever_shadow_id , 235, 310, 200, 200, "LINEAR", 0.1)
        opacity(oxy_lever_shadow_id , 0.5, "LINEAR", 0.1)
        oxyLeverPos = 1
        fs2020_variable_write("L:EMER_OXYGEN_PULL", "Number", 0)
    end
end
oxy_lever_button =button_add(nil, nil, 225, 300, 200, 200, OxyLeverCB)

    
function new_oxy_callback(val)
   --print("OXY State: " .. val)
   oxyLeverPos = val
   OxyLeverCB()
end

 -- Subscribe to FS2020 variables on the databus
fs2020_variable_subscribe("L:EMER_OXYGEN_PULL", "Number", new_oxy_callback)            