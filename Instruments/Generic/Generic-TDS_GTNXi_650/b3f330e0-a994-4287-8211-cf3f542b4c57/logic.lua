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

img_add_fullscreen("bg.png")
img_sd_black = img_add("sd_black.png", 38, 1783, 14, 152, "visible:false")
img_sd_blue  = img_add("sd_blue.png", 38, 178, 14, 152, "visible:false")
img_sd_red   = img_add("sd_red.png", 38, 178, 14, 152, "visible:false")
img_sd_white = img_add("sd_white.png", 38, 178, 14, 152, "visible:false")

visible(img_sd_black, user_prop_get(sd_prop) == "Black")
visible(img_sd_blue, user_prop_get(sd_prop) == "Blue")
visible(img_sd_red, user_prop_get(sd_prop) == "Red")
visible(img_sd_white, user_prop_get(sd_prop) == "White")

dial_add(nil, 0, 5, 80, 80, function(direction)
    if direction == 1 then
        fs2020_event("K:GPS_BUTTON2", 10)
        fs2020_event("K:GPS_BUTTON2", 12)
    elseif direction == -1 then
        fs2020_event("K:GPS_BUTTON3", 10)
        fs2020_event("K:GPS_BUTTON3", 12)
    end
    sound_play(dial_snd)
end)

button_add(nil, nil, 21, 22, 38, 38, function()
    fs2020_event("K:GPS_BUTTON1", 10)
    fs2020_event("K:GPS_BUTTON1", 12)
    sound_play(press_snd)
end)

button_add(nil, nil, 883, 130, 52, 38, function()
    fs2020_event("K:GPS_MENU_BUTTON", 10)
    fs2020_event("K:GPS_MENU_BUTTON", 12)
    sound_play(press_snd)
end)

button_add(nil, nil, 883, 225, 52, 38, function()
    fs2020_event("K:GPS_DIRECTTO_BUTTON", 10)
    fs2020_event("K:GPS_DIRECTTO_BUTTON", 12)
    sound_play(press_snd)
end)

input_prop = user_prop_add_enum("Input method", "Mouse / touch,Knobster", "Mouse / touch", "Choose your input method")
local outer_pos = nil
local inner_pos = nil
outer_pos = fif(user_prop_get(input_prop) == "Mouse / touch", {870, 318, 100, 100}, {746, 695, 80, 80} )
inner_pos = fif(user_prop_get(input_prop) == "Mouse / touch", {890, 340, 70, 70}, {757, 706, 58, 58} )

fms_outer = dial_add(nil, outer_pos[1], outer_pos[2], outer_pos[3], outer_pos[4], function(direction)
    if direction == 1 then
        fs2020_event("K:GPS_GROUP_KNOB_INC", 8)
    elseif direction == -1 then
        fs2020_event("K:GPS_GROUP_KNOB_DEC", 8)
    end
    sound_play(dial_snd)
end)

fms_inner = dial_add(nil, inner_pos[1], inner_pos[2], inner_pos[3], inner_pos[4], function(direction)
    if direction == 1 then
        fs2020_event("K:GPS_PAGE_KNOB_INC", 8)
    elseif direction == -1 then
        fs2020_event("K:GPS_PAGE_KNOB_DEC", 8)
    end
    sound_play(dial_snd)
end)
mouse_setting(fms_inner , "CURSOR_LEFT", "ctr_cursor_ccw.png")
mouse_setting(fms_inner , "CURSOR_RIGHT", "ctr_cursor_cw.png")

button_add(nil, nil, 767, 716, 38, 38, function()
    fs2020_event("K:GPS_CURSOR_BUTTON", 10)
    fs2020_event("K:GPS_CURSOR_BUTTON", 12)
end)