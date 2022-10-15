--[[
******************************************************************************************
***************CESSNA 414AW CHANCELLOR INTERIOR LIGHTING PANEL ***********
******************************************************************************************
    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://simstrumentation.com

Interior lighting control panel for the Cessna 414AWChancellor by FlySimware

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
local switchVal = 0

img_add_fullscreen("bg.png")


    -- day / night switch
function switchToggle(pos)
    if switchVal == 1 then
        fs2020_variable_write("A:BUS CONNECTION ON:5", "Number", 0)
    else
        fs2020_variable_write("A:BUS CONNECTION ON:5", "Number", 1)
    end
end
        
light_switch_id = switch_add("white_up.png", "white_down.png", 26, 130, 60, 113, switchToggle)

function toggleSwitch(val)
    switchVal = val
    if val ==1 then
        switch_set_position(light_switch_id, 0)
    else
        switch_set_position(light_switch_id, 1)
    end
end

fs2020_variable_subscribe("A:BUS CONNECTION ON:5", "Number", toggleSwitch)

    --side console
function console(pos)
    slider_set_position(slider_sideConsole, pos)
    if pos == 0 then
        sliderVal = 100
    else
        sliderVal = 100 -(pos * 100)
    end
   fs2020_variable_write("L:XMLVAR_LIGHTSWITCH_SIDE_CONSOLE_1_Position", "Number", sliderVal)
   fs2020_event("GLARESHIELD_LIGHTS_POWER_SETTING_SET", 6, sliderVal)
end

slider_sideConsole=slider_add_ver(nil, 124, 30, 30, 370, "slider.png", 70, 73, console)

function moveConsoleSlider(pos)
   slider_set_position(slider_sideConsole, 1-(pos/100))
end
fs2020_variable_subscribe("L:XMLVAR_LIGHTSWITCH_SIDE_CONSOLE_1_Position", "Number", moveConsoleSlider)

    --lower panel
function lowerPanel(pos)
    slider_set_position(slider_lowerPanel, pos)
    if pos == 0 then
        sliderVal = 100
    else
        sliderVal = 100 -(pos * 100)
    end
   fs2020_variable_write("L:XMLVAR_LIGHTSWITCH_LOWER_INST_1_Position", "Number", sliderVal)
   fs2020_event("GLARESHIELD_LIGHTS_POWER_SETTING_SET", 3, sliderVal)
end

slider_lowerPanel=slider_add_ver(nil, 224, 30, 30, 370, "slider.png", 70, 73, lowerPanel)

function moveLowerPanelSlider(pos)
   slider_set_position(slider_lowerPanel, 1-(pos/100))
end
fs2020_variable_subscribe("L:XMLVAR_LIGHTSWITCH_LOWER_INST_1_Position", "Number", moveLowerPanelSlider)

    --left instruments
function leftInst(pos)
    slider_set_position(slider_leftInst, pos)
    if pos == 0 then
        sliderVal = 100
    else
        sliderVal = 100 -(pos * 100)
    end
   fs2020_variable_write("L:XMLVAR_LIGHTSWITCH_LEFT_INST_1_Position", "Number", sliderVal)
   fs2020_event("GLARESHIELD_LIGHTS_POWER_SETTING_SET", 5, sliderVal)
end

slider_leftInst=slider_add_ver(nil, 324, 30, 30, 370, "slider.png", 70, 73, leftInst)

function moveLeftInst(pos)
   slider_set_position(slider_leftInst, 1-(pos/100))
end
fs2020_variable_subscribe("L:XMLVAR_LIGHTSWITCH_LEFT_INST_1_Position", "Number", moveLeftInst)

    --engine instruments
function engInst(pos)
    slider_set_position(slider_engInst, pos)
    if pos == 0 then
        sliderVal = 100
    else
        sliderVal = 100 -(pos * 100)
    end
   fs2020_variable_write("L:XMLVAR_LIGHTSWITCH_ENGINE_INST_1_Position", "Number", sliderVal)
   fs2020_event("GLARESHIELD_LIGHTS_POWER_SETTING_SET", 2, sliderVal)
end

slider_engInst=slider_add_ver(nil, 424, 30, 30, 370, "slider.png", 70, 73, engInst)

function moveEngInst(pos)
   slider_set_position(slider_engInst, 1-(pos/100))
end
fs2020_variable_subscribe("L:XMLVAR_LIGHTSWITCH_ENGINE_INST_1_Position", "Number", moveEngInst)

    --radio
function radio(pos)
    slider_set_position(slider_radio, pos)
    if pos == 0 then
        sliderVal = 100
    else
        sliderVal = 100 -(pos * 100)
    end
   fs2020_variable_write("L:XMLVAR_LIGHTSWITCH_RADIO_1_Position", "Number", sliderVal)
   fs2020_event("GLARESHIELD_LIGHTS_POWER_SETTING_SET", 1, sliderVal)
end

slider_radio=slider_add_ver(nil, 524, 30, 30, 370, "slider.png", 70, 73, radio)

function moveradio(pos)
   slider_set_position(slider_radio, 1-(pos/100))
end
fs2020_variable_subscribe("L:XMLVAR_LIGHTSWITCH_RADIO_1_Position", "Number", moveradio)

    --compass
function compass(pos)
    slider_set_position(slider_compass, pos)
    if pos == 0 then
        sliderVal = 100
    else
        sliderVal = 100 -(pos * 100)
    end
   fs2020_variable_write("L:XMLVAR_LIGHTSWITCH_COMPASS_1_Position", "Number", sliderVal)
   fs2020_event("GLARESHIELD_LIGHTS_POWER_SETTING_SET", 7, sliderVal)
end

slider_compass=slider_add_ver(nil, 624, 30, 30, 370, "slider.png", 70, 73, compass)

function moveCompass(pos)
   slider_set_position(slider_compass, 1-(pos/100))
end
fs2020_variable_subscribe("L:XMLVAR_LIGHTSWITCH_COMPASS_1_Position", "Number", moveCompass)

    --RFLT
function RFLT(pos)
    slider_set_position(slider_RFLT, pos)
    if pos == 0 then
        sliderVal = 100
    else
        sliderVal = 100 -(pos * 100)
    end
   fs2020_variable_write("L:XMLVAR_LIGHTSWITCH_RFLT_INST_1_Position", "Number", sliderVal)
   fs2020_event("GLARESHIELD_LIGHTS_POWER_SETTING_SET", 4, sliderVal)
end

slider_RFLT=slider_add_ver(nil, 724, 30, 30, 370, "slider.png", 70, 73, RFLT)

function moveRFLT(pos)
   slider_set_position(slider_RFLT, 1-(pos/100))
end
fs2020_variable_subscribe("L:XMLVAR_LIGHTSWITCH_RFLT_INST_1_Position", "Number", moveRFLT)
--[[
function switchTest(val)
    print(val)
end

fs2020_variable_subscribe("A:LIGHT CABIN ON:1", "Number", switchTest)
]]--