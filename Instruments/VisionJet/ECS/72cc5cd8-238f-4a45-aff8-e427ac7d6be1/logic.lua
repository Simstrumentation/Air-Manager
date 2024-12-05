--[[
******************************************************************************************
******** CIRRUS SF50 VISION JET ENVIRONMENTAL CONTROL SYSTEMS *************
******************************************************************************************
    Made by SIMSTRUMENTATION - http://simstrumentation.com

ECS panel for the Vision Jet by FlightFX

Version info:
- **v1.1** - 2022-12-
    - Added backlighting
- **v1.0** - 2022-12-11
    - Original release

NOTES: 
-  Will only work with the FlightFX Vision Jet. Compatibility with other aircraft not supported 
    or guaranteed. 

KNOWN ISSUES:
- None

ATTRIBUTION:
Original code, graphics and sound by Simstrumentation. 
Sharing or re-use of any code or assets is not permitted without credit to the original authors.
******************************************************************************************
]]--

-- USER PROPERTIES
play_sounds = user_prop_add_boolean("Play Sounds", true, "Play sounds in Air Manager")                           -- Use sounds in Air Manager 

--    configure sound
if user_prop_get(play_sounds) then
    press_snd = sound_add("press.wav")
    release_snd = sound_add("release.wav")
else
    press_snd = sound_add("silence.wav")
    release_snd = sound_add("silence.wav")
end
 --LOCAL VARS
 local defog_state 
 local aft_state
 local temp_state
 local ecs_state 
 local power_state 
 local cabinTemp
 local tempFan
 local backlight = 0
 local power = false
 local lightKnob = 0
local panelLight = 0

--GRAPHICS

--    back layer
img_add_fullscreen("darkback.png")
img_add_fullscreen("IndicatorsOff.png")

--    indicators
annun_defog = img_add("indicator_light - green.png", 188, 172, 31, 58, "visible:false")
annun_aft = img_add("indicator_light - green.png", 188, 286, 31, 58, "visible:false")
annun_temp = img_add("indicator_light - green.png", 188, 486, 31, 58, "visible:false")
annun_ecs = img_add("indicator_light.png", 188, 610, 31, 58, "visible:false")

--    main backplate
img_add_fullscreen("bg.png")

--INDICATORS

function setIndicators(defog, aft, temp, ecs, power)
    if defog == 1 then
        defog_state = true
     else
         defog_state = false
     end
     
     if aft == 1 then
         aft_state = true
     else
         aft_state = false
     end 
    
    if temp == 1 then
        temp_state = true
    else
        temp_state = false
    end
    
    if ecs == 1 then
        ecs_state = true
    else
        ecs_state = false
    end

    if power then
        power_state = true
        opacity(backlit_labels, 1, "LINEAR", 0.05)
     else
         power_state = false
         opacity(backlit_labels, 0.5, "LINEAR", 0.05)
     end
   
    if defog_state and power_state then
        visible(annun_defog, true)
    else
        visible(annun_defog, false)
    end
    
    if aft_state and power_state then
        visible(annun_aft, true)
    else
        visible(annun_aft, false)
    end
    
    if temp_state and power_state then
        visible(annun_temp, true)
    else
        visible(annun_temp, false)
    end

    if ecs_state and power_state then
        visible(annun_ecs, true)
    else
        visible(annun_ecs, false)
    end
end

-- *****indicator test function -- remove when complete
--setIndicators(false, false, false, false, true)


--BUTTONS
function masterRelease()
    sound_play(release_snd)
end
--    defog
function defogToggle()
    msfs_variable_write("L:SF50_defog", "Int", 4)    --added to get around Air Manager lvar write bug
    if defog_state then
        msfs_variable_write("L:SF50_defog", "Int", 0)
    else
        msfs_variable_write("L:SF50_defog", "Int", 1)
    end
     sound_play(press_snd)
end

btn_defog = button_add(nil, "btn_pressed.png", 55, 152, 132, 93, defogToggle, masterRelease)

--    aft ctrl
function aftToggle()
    msfs_variable_write("L:SF50_aft", "Int", 4)    --added to get around Air Manager lvar write bug
    if aft_state then
        msfs_variable_write("L:SF50_aft", "Int", 0)
    else
        msfs_variable_write("L:SF50_aft", "Int", 1)
    end
    sound_play(press_snd)
end

btn_aft = button_add(nil, "btn_pressed.png", 55, 273, 132, 93, aftToggle, masterRelease)

--    temp backup
function tempToggle()
    msfs_variable_write("L:SF50_TempBKP", "Int", 4)    --added to get around Air Manager lvar write bug
     if temp_state then
        msfs_variable_write("L:SF50_TempBKP", "Int", 0)
    else
        msfs_variable_write("L:SF50_TempBKP", "Int", 1)
    end   
    sound_play(press_snd)
end

btn_temp = button_add(nil, "btn_pressed.png", 55,470, 132, 93, tempToggle, masterRelease)

--    ecs disable
function ecsToggle()
    msfs_variable_write("L:SF50_ecs", "Int", 4)    --added to get around Air Manager lvar write bug
    if ecs_state then
        msfs_variable_write("L:SF50_ecs", "Int", 0)
    else
         msfs_variable_write("L:SF50_ecs", "Int", 1)
    end
    sound_play(press_snd)
end

btn_ecs = button_add(nil, "btn_pressed.png", 55,598, 132, 93, ecsToggle, masterRelease)

--KNOBS

--    temperature
function tempControl(direction)
    if direction == 1 then
        if cabinTemp < 1.0 then
            newTemp = cabinTemp + 0.05
            msfs_variable_write("L:SF50_TempControl", "Number", newTemp)   
         end
    elseif direction == -1 then
        if cabinTemp > 0 then
            newTemp = cabinTemp - 0.05
            msfs_variable_write("L:SF50_TempControl", "Number", newTemp)
         end
    end
end
temp_dial = dial_add(nil, 320, 100, 230,230, tempControl)

--    fan
function fanControl(direction)
    if direction == 1 then
        if tempFan < 1.0 then
            newFan = tempFan + 0.05
            msfs_variable_write("L:SF50_TempFan", "Number", newFan)   
         end
    elseif direction == -1 then
        if tempFan > 0 then
            newFan = tempFan - 0.05
            msfs_variable_write("L:SF50_TempFan", "Number", newFan)
         end
    end
end
fan_dial = dial_add(nil, 320, 470, 230,230, fanControl)

function setKnobs(temperature, fan)
     cabinTemp = temperature
     tempFan = fan
     rotate(temp_group, (320*cabinTemp)-160, "LINEAR", 0.04) 
     rotate(fan_group, (300*tempFan)-140, "LINEAR", 0.04) 

end

msfs_variable_subscribe("L:SF50_TempControl", "Number",
                                                "L:SF50_TempFan", "Number", 
                                                setKnobs)


 --defog, aft, temp, ecs, power
msfs_variable_subscribe("L:SF50_defog", "Int", 
                                              "L:SF50_aft", "Int",
                                              "L:SF50_TempBKP", "Int",
                                              "L:SF50_ecs", "Int", 
                                               "A:ELECTRICAL MASTER BATTERY", "Bool",
                                                 setIndicators)

--backlight labels here to preserve z-order

temp_indicator = img_add("knob_indicator.png", 320, 100, 230,230)
opacity(temp_indicator, 0.3)
fan_indicator =img_add("knob_indicator.png", 320, 470, 230,230)
opacity(fan_indicator, 0.3)
backlit_temp_indicator = img_add("knob_indicator.png", 320, 100, 230,230)
backlit_fan_indicator =img_add("knob_indicator.png", 320, 470, 230,230)
temp_group = group_add(temp_indicator, backlit_temp_indicator)
fan_group = group_add(fan_indicator, backlit_fan_indicator)

--[[
group all backlit labels together

]]--
backlight_labels = img_add_fullscreen("backlight_labels.png")
opacity(backlight_labels, 0)

backlit_labels = group_add(backlit_temp_indicator, backlit_fan_indicator, backlight_labels)

-- backlight
function lightPot(val, panel, pot, power)
    lightKnob = val
    panelLight = panel
    if power  then
        opacity(backlit_labels, (pot/100), "LOG", 0.1)  
    else
        opacity(backlit_labels, 0, "LOG", 0.1)  
    end
end

msfs_variable_subscribe("L:LIGHTING_PANEL_1", "Number",
                                                "A:LIGHT PANEL:1", "Bool", 
                                                "A:LIGHT POTENTIOMETER:3", "Percent", 
                                                "A:ELECTRICAL MASTER BATTERY", "Bool",
                                                 lightPot)