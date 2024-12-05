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
- **v1.1** (Feb 18, 2023)
    - removed specific HJet support and new HJet uses standard AAU I events
    - added touch zones around left joystick knob for joystick directional control
     
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
--Temporarily commented out. Left in for future plane types that don't adhere to the standard GTC configuration
--getPlaneType = user_prop_add_enum("Airframe", "HJet,Other", "Other", "Choose your plane")

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
--Temporarily commented out. Left in for future plane types that don't adhere to the standard GTC configuration
--if user_prop_get(getPlaneType) == "HJet" then
--    airFrame= "HJET"
--else
    airFrame= "GENERIC"    -- temporarily left as "other" as default
--end
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

* Joystick directional controls
14 - Joystick up
15 - Joystick down
16 - Joystick left 
17 - Joystick right
]]--

--set list of commands based on airframe used

   
if airFrame == "GENERIC" then
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
        "H:AS3000_TSC_Vertical_" .. bezel_pos .. "_RightKnob_Push_long",
        "H:AS3000_TSC_Vertical_" .. bezel_pos .. "_Joystick_Up",
        "H:AS3000_TSC_Vertical_" .. bezel_pos .. "_Joystick_Down",
        "H:AS3000_TSC_Vertical_" .. bezel_pos .. "_Joystick_Left",
        "H:AS3000_TSC_Vertical_" .. bezel_pos .. "_Joystick_Right"
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
        msfs_event(cmd_table[1])
    elseif direction == -1 then
        msfs_event(cmd_table[2])
    end
    sound_play(dial_snd)
  end
  
left_knob_dial = dial_add("knob.png" , 131 , 846 , 60 , 60 , leftKnob)
img_left_knob = img_add("knob.png" , 131 , 846 , 60 , 60 )

function leftKnobPress()
    -- not 100% sure if this function exists. Adding for now as a test
    msfs_event(cmd_table[3])
    sound_play(press_snd)
end
left_knob_press = button_add(nil, nil, 141 , 856 , 40 , 40 , leftKnobPress, knobRelease)


--middle knob
function middleKnob(direction)
    if direction == 1 then
        msfs_event(cmd_table[5])
    elseif direction == -1 then
        msfs_event(cmd_table[6])
    end
    sound_play(dial_snd)
end
middle_knob = dial_add("knob.png" , 302 , 842 , 47 , 47 , middleKnob, knobRelease)
img_middle_knob = img_add("knob.png" , 302 , 842 , 47 , 47)

function middleKnobPress()
    msfs_event(cmd_table[7])
    sound_play(press_snd)
end
middle_knob_press = button_add(nil, nil, 310 , 850 , 32 , 32 , middleKnobPress, knobRelease)

--right knob
    --large knob turn
function largeKnob(direction)
    if direction == 1 then
        msfs_event(cmd_table[8])
    elseif direction == -1 then
        msfs_event(cmd_table[9])
    end
    sound_play(dial_snd)
end
large_knob = dial_add("large_knob.png" , 450 , 841 , 86 , 86 , largeKnob)
img_large_knob = img_add("large_knob_cap.png" , 450 , 841 , 86 , 86)

    --small knob turn
function smallKnobRight(direction)
    if direction == 1 then
        msfs_event(cmd_table[10])
    elseif direction == -1 then
        msfs_event(cmd_table[11])
    end
    sound_play(dial_snd)
end

small_knob_right = dial_add("knob.png" , 462 , 852 , 60, 60 , smallKnobRight)
img_small_knob_right = img_add("knob.png" , 462 , 852 , 60, 60)

    --small knob press
function rightKnobRelease()
     if timer_running(timerLongPress) then    --short press
         msfs_event(cmd_table[12])
    end   
    timer_stop(timerLongPress)
    knobRelease()
end

function rightKnobLongPress()    
    --    execute long press event once timer reaches 1000ms without having to release button
    msfs_event(cmd_table[13])
    timer_stop(timerLongPress)
end

function rightKnobPress()
    sound_play(press_snd)
    --    start timer to determine short or long press
    timerLongPress = timer_start(1000, rightKnobLongPress)
end
right_knob_press = button_add(nil, nil, 471 , 861 , 44, 44, rightKnobPress, rightKnobRelease)

    --joystick directional controls
    
function joystickUpPress()
    msfs_event(cmd_table[14])
    print(cmd_table[14])
    sound_play(press_snd)
end    

function joystickDnPress()
    msfs_event(cmd_table[15])
    print(cmd_table[15])
    sound_play(press_snd)
end    

function joystickLftPress()
    msfs_event(cmd_table[16])
    print(cmd_table[16])
    sound_play(press_snd)
end    

function joystickRtPress()
    msfs_event(cmd_table[17])
    print(cmd_table[17])
    sound_play(press_snd)
end    

--joystick touch zones
upArrow_id = button_add(nil,"arrow_up.png", 138,780, 50, 50, joystickUpPress, knobRelease)
dnArrow_id = button_add(nil,"arrow_dn.png",136,924, 50, 50, joystickDnPress, knobRelease)
rotate(dnArrow_id, 180)
lftArrow_id = button_add(nil,"arrow_lft.png",68,854, 50, 50, joystickLftPress, knobRelease)
rotate(lftArrow_id, 270)
rtArrow_id = button_add(nil,"arrow_rt.png",204,840, 50, 50, joystickRtPress, knobRelease)
rotate(rtArrow_id, 90)
