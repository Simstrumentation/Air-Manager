--[[
******************************************************************************************
******************************Garmin G1000 Overlay Bezel**********************************
******************************************************************************************
    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation

This GTN650 is specifically made for the PMS50 GTN650 and will not work with other GTN units
for MSFS

INSTRUCTIONS:

THIS INSTRUMENT IS ONLY AN OVERLAY. It does not generate the GTN screen content. It must be used
in conjunction with pop out instrument from Microsoft Flight Simulator. Right Alt + Click on the GTN650 
screens in MSFS to pop out the windows. 

When placing GTN650 bezel into a new panel:
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
unit_position = user_prop_add_enum("Unit position","1,2","2","Select whether this is Unit 1 or 2 (2 is default)")     
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
    unitvar = "H:GTN650_"
else
    unitvar = "H:GTN650_2_"
end
--********************************************END USER PROPERTY CONFIG********************************************

img_add_fullscreen("bg.png")
img_sd_black = img_add("sd_black.png", 38, 1783, 14, 152, "visible:false")
img_sd_blue  = img_add("sd_blue.png", 38, 178, 14, 152, "visible:false")
img_sd_red   = img_add("sd_red.png", 38, 178, 14, 152, "visible:false")
img_sd_white = img_add("sd_white.png", 38, 178, 14, 152, "visible:false")

visible(img_sd_black, user_prop_get(sd_prop) == "Black")
visible(img_sd_blue, user_prop_get(sd_prop) == "Blue")
visible(img_sd_red, user_prop_get(sd_prop) == "Red")
visible(img_sd_white, user_prop_get(sd_prop) == "White")

--Volume knob
dial_add(nil, 0, 5, 80, 80, function(direction)
    if direction == 1 then
        fs2020_event(unitvar .. "VolInc")
    elseif direction == -1 then
        fs2020_event(unitvar .. "VolDec")
    end
    sound_play(dial_snd)
end)

button_add(nil, nil, 21, 22, 38, 38, function()
    fs2020_event(unitvar .. "VolPush")
    sound_play(press_snd)
end)

--Home button
function home_start()
    fs2020_event(unitvar .. "HomePush")
    sound_play(press_snd)
    timer_id1 = timer_start(1000,CLR_LONG)
 end

 function home_end()
        timer_stop(timer_id1)
 end
 
 function CLR_LONG()
    fs2020_event(unitvar .. "HomePushLong")
 end

button_add(nil, nil, 883, 130, 52, 38, home_start,  home_end)

--Direct To
button_add(nil, nil, 883, 225, 52, 38, function()
    fs2020_event(unitvar .. "DirectToPush")
    sound_play(press_snd)
end)


input_prop = user_prop_add_enum("Input method", "Mouse / touch,Knobster", "Mouse / touch", "Choose your input method")
local outer_pos = nil
local inner_pos = nil
outer_pos = fif(user_prop_get(input_prop) == "Mouse / touch", {870, 318, 100, 100}, {746, 695, 80, 80} )
inner_pos = fif(user_prop_get(input_prop) == "Mouse / touch", {890, 340, 70, 70}, {757, 706, 58, 58} )

--FMS Knob

fms_outer = dial_add(nil, outer_pos[1], outer_pos[2], outer_pos[3], outer_pos[4], function(direction)
    if direction == 1 then
        fs2020_event(unitvar .. "KnobLargeInc")
    elseif direction == -1 then
        fs2020_event(unitvar .. "KnobLargeDec")
    end
    sound_play(dial_snd)
end)

fms_inner = dial_add(nil, inner_pos[1], inner_pos[2], inner_pos[3], inner_pos[4], function(direction)
    if direction == 1 then
        fs2020_event(unitvar .. "KnobSmallInc")
    elseif direction == -1 then
        fs2020_event(unitvar .. "KnobSmallDec")
    end
    sound_play(dial_snd)
end)
mouse_setting(fms_inner , "CURSOR_LEFT", "ctr_cursor_ccw.png")
mouse_setting(fms_inner , "CURSOR_RIGHT", "ctr_cursor_cw.png")

button_add(nil, nil, 767, 716, 38, 38, function()
    fs2020_event(unitvar .. "KnobPush")
end)

