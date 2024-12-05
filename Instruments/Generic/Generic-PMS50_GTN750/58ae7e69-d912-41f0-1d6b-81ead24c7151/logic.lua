--[[
******************************************************************************************
******************************Garmin G1000 Overlay Bezel**********************************
******************************************************************************************
    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation

This GTN750 is specifically made for the PMS50 GTN750 and will not work with other GTN units
for MSFS

INSTRUCTIONS:

THIS INSTRUMENT IS ONLY AN OVERLAY. It does not generate the Gtn screen content. It must be used
in conjunction with pop out instrument from Microsoft Flight Simulator. Right Alt + Click on the GTN750 
screens in MSFS to pop out the windows. 

When placing GTN750 bezel into a new panel:
    1. right click on bezel in panel preview
    2. Select Unit position (1 or 2)
    3. Select if you want the bezel to have sounds when buttons are pressed
    
NOTES: 
- 
KNOWN ISSUES:
- None

ATTRIBUTION:
Sharing or re-use of any code or assets is not permitted without credit to the original authors.
]]--

--***********************************************USER PROPERTY CONFIG***********************************************

--local vars
local unitvar

-- define user selectable properties
unit_position = user_prop_add_enum("Unit position","1,2","1","Select whether this is Unit 1 or 2 (1 is default)")                  -- Select unit mode. 1 is default
sd_prop = user_prop_add_enum("SD card", "Black,Blue,Red,White,None", "Blue", "Pick the color of the SD card")
play_sounds = user_prop_add_boolean("Play Sounds", true, "Play sounds in Air Manager")                           -- Use sounds in Air Manager    

-- play sound
if user_prop_get(play_sounds) then
    press_snd = sound_add("click.wav")
    dial_snd = sound_add("dial.wav")
else
    press_snd = sound_add("silence.wav")
    dial_snd = sound_add("silence.wav")
end
-- end play sound

if user_prop_get(unit_position) == "1" then
    unitvar = "H:GTN750_"
else
    unitvar = "H:GTN750_2_"
end
--********************************************END USER PROPERTY CONFIG********************************************

img_add_fullscreen("gtn750bezel.png")
img_sd_black =img_add("sd_black.png", 36, 158, 14, 152, "visible:false")
img_sd_blue  = img_add("sd_blue.png", 36, 158, 14, 152, "visible:false")
img_sd_red   = img_add("sd_red.png", 36, 158, 14, 152, "visible:false")
img_sd_white = img_add("sd_white.png", 36, 158, 14, 152, "visible:false")

visible(img_sd_black, user_prop_get(sd_prop) == "Black")
visible(img_sd_blue, user_prop_get(sd_prop) == "Blue")
visible(img_sd_red, user_prop_get(sd_prop) == "Red")
visible(img_sd_white, user_prop_get(sd_prop) == "White")

--Volume Knob
dial_add(nil, 0, 5, 80, 80, function(direction)
    if direction == 1 then
        msfs_event(unitvar .. "VolInc")
    elseif direction == -1 then
        msfs_event(unitvar .. "VolDec")
    end
    sound_play(dial_snd)
end)

-- volume button
button_add(nil, nil, 21, 26, 38, 38, function()
    msfs_event(unitvar .. "VolPush")
    sound_play(press_snd)
end)

--Home Button

function home_start()
    msfs_event(unitvar .. "HomePush")
    sound_play(press_snd)
    timer_id1 = timer_start(1000,CLR_LONG)
 end

 function home_end()
        timer_stop(timer_id1)
 end
 
 function CLR_LONG()
    msfs_event(unitvar .. "HomePushLong")
 end


button_add(nil, nil, 883, 639, 52, 38, home_start,  home_end)

--Direct To


function dtcpush()
    msfs_event(unitvar .. "DirectToPush")
    sound_play(press_snd)
end
button_add(nil, nil, 883, 721, 52, 38, dtcpush)


input_prop = user_prop_add_enum("Input method", "Mouse / touch,Knobster", "Mouse / touch", "Choose your input method")
local outer_pos = nil
local inner_pos = nil
outer_pos = fif(user_prop_get(input_prop) == "Mouse / touch", {861, 807, 100, 100}, {746, 695, 80, 80} )
inner_pos = fif(user_prop_get(input_prop) == "Mouse / touch", {886, 830, 70, 70}, {757, 706, 58, 58} )


--FMS Knob
fms_outer = dial_add(nil, outer_pos[1], outer_pos[2], outer_pos[3], outer_pos[4], function(direction)
    if direction == 1 then
        msfs_event(unitvar .. "KnobLargeInc")
    elseif direction == -1 then
        msfs_event(unitvar .. "KnobLargeDec")
    end
    sound_play(dial_snd)
end)

fms_inner = dial_add(nil, inner_pos[1], inner_pos[2], inner_pos[3], inner_pos[4], function(direction)
    if direction == 1 then
        msfs_event(unitvar .. "KnobSmallInc")
    elseif direction == -1 then
        msfs_event(unitvar .. "KnobSmallDec")
    end
    sound_play(dial_snd)
end)
mouse_setting(fms_inner , "CURSOR_LEFT", "ctr_cursor_ccw.png")
mouse_setting(fms_inner , "CURSOR_RIGHT", "ctr_cursor_cw.png")

--Knob Press
button_add(nil, nil, inner_pos[1], inner_pos[2], inner_pos[3], inner_pos[4], function()
   msfs_event(unitvar .. "KnobPush")
   sound_play(press_snd)
end)
