--[[
***************************Garmin GTC570 Overlay Bezel*******************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    http://www.simstrumentation.com

This GTC570 bezel is specifically designed for use with 

INSTRUCTIONS:

THIS INSTRUMENT IS ONLY AN OVERLAY. It does not generate the GTC570 screen content. It must be used
in conjunction with pop out instrument from Microsoft Flight Simulator. Right Alt + Click on the GTC570 
screen in MSFS to pop out the windows. 

Version info:
- **v1.0** (August 31 2022)

      
NOTES: 
- Select which position the unit will occupy via user properties. Can be placed in positions 1, 2, or 3.

KNOWN ISSUES:
- None

ATTRIBUTION:
Code and artwork and sound effects are original creations by Simstrumentation
Sharing or re-use of any code or assets is not permitted without credit to the original authors.
***************************************************************************************************************************************************************
]]--
unit_pos = user_prop_add_enum("Position", "1,2,3", "1", "Choose bezel position")
getPlaneType = user_prop_add_enum("Airframe", "HJet,Other", "Other", "Choose your plane")

local bezel_pos = 0
--local airFrame 

--  unit position
if user_prop_get(unit_pos) == "1" then
	bezel_pos = 1
elseif user_prop_get(unit_pos) == "2" then
	bezel_pos = 2
elseif user_prop_get(unit_pos) == "3" then
	bezel_pos = 3
end
--  end unit position

--    get airframe type

if user_prop_get(getPlaneType) == "HJet" then
    airFrame= "HJET"
else
    airFrame= "OTHER"
end
--[[
*****************************MULTI-PLANE *****************************
Command table mapping

*Left knob
1 - Inc
2 - Dec
3 - Push
4 - Push Long

*Middle knob
5 - Inc 
6 - Dec 
7 - Push

*Right knob
8 - Large Inc
9 - Large Dec
10 - Small Inc
11 - Small Dec
12 - Push
13 - Long Push
]]--

--set list of commands based on airframe used

if airFrame == "HJET" then
    if bezel_pos == 1 then
        cmd_table =  {
            "H:AS3000_TSC_Vertical_TopKnob_Large_INC", 
            "H:AS3000_TSC_Vertical_TopKnob_Large_DEC",
            "H:AS3000_TSC_Vertical_" .. bezel_pos .. "_Joystick_Push",                 --Placeholder only - does nothing in HJet
            "H:AS3000_TSC_Vertical_" .. bezel_pos .. "_Joystick_Push_Long",       --Placeholder only - does nothing in HJet
            "H:AS3000_TSC_Vertical_TopKnob_Small_INC",  
            "H:AS3000_TSC_Vertical_TopKnob_Small_DEC",                                
            "H:AS3000_TSC_Vertical_" .. bezel_pos .. "_MiddleKnob_Push",          --Placeholder only - does nothing in HJet  
            "H:AS3000_TSC_Vertical_BottomKnob_Large_INC",  
            "H:AS3000_TSC_Vertical_BottomKnob_Large_DEC",
            "H:AS3000_TSC_Vertical_BottomKnob_Small_INC",
            "H:AS3000_TSC_Vertical_BottomKnob_Small_DEC",
            "H:AS3000_TSC_Vertical_BottomKnob_Push",
            "H:AS3000_TSC_Vertical_" .. bezel_pos .. "_RightKnob_Push_long"    --Placeholder only - does nothing in HJet  
        } 
    else
        cmd_table =  {
            "H:AS3000_TSC_Vertical_" .. bezel_pos .. "_Joystick_INC",                 --Placeholder only - does nothing in HJet
            "H:AS3000_TSC_Vertical_" .. bezel_pos .. "_Joystick_DEC",                --Placeholder only - does nothing in HJet
            "H:AS3000_TSC_Vertical_" .. bezel_pos .. "_Joystick_Push",                --Placeholder only - does nothing in HJet
            "H:AS3000_TSC_Vertical_" .. bezel_pos .. "_Joystick_Push_Long",      --Placeholder only - does nothing in HJet
            "H:AS3000_TSC_Vertical_" .. bezel_pos .. "_MiddleKnob_INC",          --Placeholder only - does nothing in HJet
            "H:AS3000_TSC_Vertical_" .. bezel_pos .. "_MiddleKnob_DEC",         --Placeholder only - does nothing in HJet
            "H:AS3000_TSC_Vertical_" .. bezel_pos .. "_MiddleKnob_Push",        --Placeholder only - does nothing in HJet
            "H:AS3000_TSC_Vertical_" .. bezel_pos .. "_RightKnob_Large_INC",  --Placeholder only - does nothing in HJet  
            "H:AS3000_TSC_Vertical_" .. bezel_pos .. "_RightKnob_Large_DEC",  --Placeholder only - does nothing in HJet
            "H:gauges_ha420_sys_Checklist_scoll_down",
            "H:gauges_ha420_sys_Checklist_scoll_up",
            "H:gauges_ha420_sys_Checklist_enter",
            "H:gauges_ha420_sys_Checklist_Longenter"
        }     
    end
    
elseif airFrame == "OTHER" then
    -- standard AAU I event list for all other planes
    cmd_table =  {
        "H:AS3000_TSC_Vertical_" .. bezel_pos .. "_Joystick_INC", 
        "H:AS3000_TSC_Vertical_" .. bezel_pos .. "_Joystick_DEC",
        "H:AS3000_TSC_Vertical_" .. bezel_pos .. "_Joystick_Push",
        "H:AS3000_TSC_Vertical_" .. bezel_pos .. "_Joystick_Push_Long",
        "H:AS3000_TSC_Vertical_" .. bezel_pos .. "_MiddleKnob_INC",  
        "H:AS3000_TSC_Vertical_" .. bezel_pos .. "_MiddleKnob_DEC",
        "H:AS3000_TSC_Vertical_" .. bezel_pos .. "_MiddleKnob_Push",
        "H:AS3000_TSC_Vertical_" .. bezel_pos .. "_RightKnob_Large_INC",  
        "H:AS3000_TSC_Vertical_" .. bezel_pos .. "_RightKnob_Large_DEC",
        "H:AS3000_TSC_Vertical_" .. bezel_pos .. "_RightKnob_Small_INC",
        "H:AS3000_TSC_Vertical_" .. bezel_pos .. "_RightKnob_Small_DEC",
        "H:AS3000_TSC_Vertical_" .. bezel_pos .. "_RightKnob_Push",
        "H:AS3000_TSC_Vertical_" .. bezel_pos .. "_RightKnob_Push_long"
    }    
end
--*************************************************************************

--sounds
press_snd = sound_add("press.wav")
release_snd = sound_add("release.wav")
dial_snd = sound_add("dial.wav")

--background images
backlight=img_add_fullscreen("greenback.png")
img_add_fullscreen("bg.png")


--KNOBS

function knobRelease()
    sound_play(release_snd)
end

--    left knob
function leftKnob (direction)    
    if direction == 1 then
        fs2020_event(cmd_table[1])
    elseif direction == -1 then
        fs2020_event(cmd_table[2])
    end
    sound_play(dial_snd)
  end
  
left_knob_dial = dial_add("knob.png" , 131 , 846 , 60 , 60 , leftKnob)
img_left_knob = img_add("knob.png" , 131 , 846 , 60 , 60 )

function leftKnobPress()
    -- not 100% sure if this function exists. Adding for now as a test
    fs2020_event(cmd_table[3])
    sound_play(press_snd)
end
left_knob_press = button_add(nil, nil, 141 , 856 , 40 , 40 , leftKnobPress, knobRelease)


--middle knob
function middleKnob(direction)
    if direction == 1 then
        fs2020_event(cmd_table[5])
    elseif direction == -1 then
        fs2020_event(cmd_table[6])
    end
    sound_play(dial_snd)
end
middle_knob = dial_add("knob.png" , 302 , 842 , 47 , 47 , middleKnob, knobRelease)
img_middle_knob = img_add("knob.png" , 302 , 842 , 47 , 47)

function middleKnobPress()
    fs2020_event(cmd_table[7])
    sound_play(press_snd)
end
middle_knob_press = button_add(nil, nil, 310 , 850 , 32 , 32 , middleKnobPress, knobRelease)

--right knob
    --large knob turn
function largeKnob(direction)
    if direction == 1 then
        fs2020_event(cmd_table[8])
        print(cmd_table[8])
    elseif direction == -1 then
        fs2020_event(cmd_table[9])
        print(cmd_table[9])
    end
    sound_play(dial_snd)
end
large_knob = dial_add("large_knob.png" , 450 , 841 , 86 , 86 , largeKnob)
img_large_knob = img_add("large_knob_cap.png" , 450 , 841 , 86 , 86)

    --small knob turn
function smallKnobRight(direction)
    if direction == 1 then
        fs2020_event(cmd_table[10])
        print(cmd_table[10])
    elseif direction == -1 then
        fs2020_event(cmd_table[11])
        print(cmd_table[11])
    end
    sound_play(dial_snd)
end

small_knob_right = dial_add("knob.png" , 462 , 852 , 60, 60 , smallKnobRight)
img_small_knob_right = img_add("knob.png" , 462 , 852 , 60, 60)

    --small knob press
function rightKnobRelease()
     if timer_running(timerLongPress) then    --short press
         fs2020_event(cmd_table[12])
         print(cmd_table[12])
    end   
    timer_stop(timerLongPress)
    knobRelease()
end

function rightKnobLongPress()    
    --    execute long press event once timer reaches 1000ms without having to release button
    fs2020_event(cmd_table[13])
    print(cmd_table[13])
    timer_stop(timerLongPress)
end

function rightKnobPress()
    sound_play(press_snd)
    --    start timer to determine short or long press
    timerLongPress = timer_start(1000, rightKnobLongPress)
end
right_knob_press = button_add(nil, nil, 471 , 861 , 44, 44, rightKnobPress, rightKnobRelease)
--[[
canvas_id = canvas_add(78, 126, 496, 643, function()
  -- Create a rectangle
  _rect(1, 1, 496, 643)
  _fill("black")
end)
txtTitle = txt_add("Error", "font:roboto_bold.ttf; size:50; color: white; halign:center;", 70, 130, 496, 643)

txtBody1= txt_add("Invalid unit position number for the ".. planeTitle ..". ", "font:roboto_bold.ttf; size:26; color: white; halign:center;", 70, 200, 496, 643)
txtBody2= txt_add("Please Select a valid position from user properties.", "font:roboto_bold.ttf; size:26; color: white; halign:center;", 70, 220, 496, 643)
]]