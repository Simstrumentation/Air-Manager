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

img_add_fullscreen("gtn750bezel.png")
img_sd_black = img_add("sd_black.png", 36, 158, 14, 152, "visible:false")
img_sd_blue  = img_add("sd_blue.png", 36, 158, 14, 152, "visible:false")
img_sd_red   = img_add("sd_red.png", 36, 158, 14, 152, "visible:false")
img_sd_white = img_add("sd_white.png", 36, 158, 14, 152, "visible:false")

visible(img_sd_black, user_prop_get(sd_prop) == "Black")
visible(img_sd_blue, user_prop_get(sd_prop) == "Blue")
visible(img_sd_red, user_prop_get(sd_prop) == "Red")
visible(img_sd_white, user_prop_get(sd_prop) == "White")

dial_add(nil, 0, 5, 80, 80, function(direction)
    if direction == 1 then
        fs2020_event("K:GPS_BUTTON2", 2)
        fs2020_event("K:GPS_BUTTON2", 4)
    elseif direction == -1 then
        fs2020_event("K:GPS_BUTTON3", 2)
        fs2020_event("K:GPS_BUTTON3", 4)
    end
    sound_play(dial_snd)
end)

button_add(nil, nil, 21, 26, 38, 38, function()
    fs2020_event("K:GPS_BUTTON1", 2)
    fs2020_event("K:GPS_BUTTON1", 4)
    sound_play(press_snd)
end)

button_add(nil, nil, 883, 639, 52, 38, function()
    fs2020_event("K:GPS_MENU_BUTTON", 2)
    fs2020_event("K:GPS_MENU_BUTTON", 4)
    sound_play(press_snd)
end)

button_add(nil, nil, 883, 721, 52, 38, function()
    fs2020_event("K:GPS_DIRECTTO_BUTTON", 2)
    fs2020_event("K:GPS_DIRECTTO_BUTTON", 4)
    sound_play(press_snd)
end)

input_prop = user_prop_add_enum("Input method", "Mouse / touch,Knobster", "Mouse / touch", "Choose your input method")
local outer_pos = nil
local inner_pos = nil
outer_pos = fif(user_prop_get(input_prop) == "Mouse / touch", {861, 807, 100, 100}, {746, 695, 80, 80} )
inner_pos = fif(user_prop_get(input_prop) == "Mouse / touch", {886, 830, 70, 70}, {757, 706, 58, 58} )

fms_outer = dial_add(nil, outer_pos[1], outer_pos[2], outer_pos[3], outer_pos[4], function(direction)
    if direction == 1 then
        fs2020_event("K:GPS_GROUP_KNOB_INC", 0)
    elseif direction == -1 then
        fs2020_event("K:GPS_GROUP_KNOB_DEC", 0)
    end
    sound_play(dial_snd)
end)

fms_inner = dial_add(nil, inner_pos[1], inner_pos[2], inner_pos[3], inner_pos[4], function(direction)
    if direction == 1 then
        fs2020_event("K:GPS_PAGE_KNOB_INC", 0)
    elseif direction == -1 then
        fs2020_event("K:GPS_PAGE_KNOB_DEC", 0)
    end
    sound_play(dial_snd)
end)
mouse_setting(fms_inner , "CURSOR_LEFT", "ctr_cursor_ccw.png")
mouse_setting(fms_inner , "CURSOR_RIGHT", "ctr_cursor_cw.png")

button_add(nil, nil, 767, 716, 38, 38, function()
    fs2020_event("K:GPS_CURSOR_BUTTON", 2)
    fs2020_event("K:GPS_CURSOR_BUTTON", 4)
    --fsx_event("GPS_CURSOR_BUTTON")
end)