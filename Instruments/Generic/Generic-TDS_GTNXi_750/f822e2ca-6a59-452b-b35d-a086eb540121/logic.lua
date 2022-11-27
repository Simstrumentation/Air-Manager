unit_pos_prop = user_prop_add_enum("Unit Position", "Primary,C414AW_Secondary", "Primary", "Select whether the unit is the primary (default) or the secondary unit in the FSW C414AW")
sd_prop = user_prop_add_enum("SD card", "Black,Blue,Red,White,None", "Blue", "Pick the color of the SD card")
blackout_prop = user_prop_add_boolean("Blackout", true, "screen stays black until avionics on")    
play_sounds = user_prop_add_boolean("Play Sounds", true, "Play sounds in Air Manager")                           -- Use sounds in Air Manager    

local unitPos

if user_prop_get(unit_pos_prop) == "Primary" then
    unitPos = 0
else
    unitPos = 1
end        
    
-- play sound
if user_prop_get(play_sounds) then
    press_snd = sound_add("press.wav")
    release_snd = sound_add("release.wav")
    dial_snd = sound_add("dial.wav")
else
    press_snd = sound_add("silence.wav")
    release_snd = sound_add("silence.wav")
    dial_snd = sound_add("silence.wav")
end
-- end play sound

--
--black screen when avionics off
if user_prop_get(blackout_prop) then
    img_black_screen = img_add("black_screen.png", 0, 0, 958, 926, "visible:true")
    function power_on(power)
        if power then
            opacity(img_black_screen, 0, "LOG", 0.03)
        else
            opacity(img_black_screen, 1, "LOG", 0.03)
        end
    end
    fs2020_variable_subscribe("CIRCUIT AVIONICS ON", "BOOL", power_on)
end


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
        if unitPos == 0 then
            fs2020_event("K:GPS_BUTTON2", 2)
            timer_start(15, function()fs2020_event("K:GPS_BUTTON2", 4) end)
         else
             fs2020_variable_write("L:TDSGTNXI750U2_LKnobInc", "Number", 1)
             timer_start(15, function()fs2020_variable_write("L:TDSGTNXI750U2_LKnobInc", "Number", 0) end)
         end
    elseif direction == -1 then
        if unitPos == 0 then
            fs2020_event("K:GPS_BUTTON3", 2)
            timer_start(15, function()fs2020_event("K:GPS_BUTTON3", 4) end)
            sound_play(dial_snd)
        else
            fs2020_variable_write("L:TDSGTNXI750U2_LKnobDec", "Number", 1)
            timer_start(15, function() fs2020_variable_write("L:TDSGTNXI750U2_LKnobDec", "Number", 0) end)
        end
     end
    
end)

-- volume button
function vol_press()
    if unitPos == 0 then
        fs2020_event("K:GPS_BUTTON1", 2)
        sound_play(press_snd)
    else
        fs2020_variable_write("L:TDSGTNXI750U2_LKnobCRSR", "Number", 1)
        sound_play(release_snd)
    end
end

function vol_release()
    if unitPos == 0 then
        fs2020_event("K:GPS_BUTTON1", 4)
    else
        fs2020_variable_write("L:TDSGTNXI750U2_LKnobCRSR", "Number", 0)
    end
    sound_play(release_snd)
end
vol_button = button_add(nil, nil, 21, 26, 38, 38, vol_press, vol_release)
--Home Button

function home_press()
    if unitPos == 0 then
        fs2020_event("K:GPS_MENU_BUTTON", 2)
    else
        fs2020_variable_write("L:TDSGTNXI750U2_HomeKEY", "Number", 1)
    end
    sound_play(press_snd)
 end

function home_release()
    if unitPos == 0 then
        fs2020_event("K:GPS_MENU_BUTTON", 4)
    else
        fs2020_variable_write("L:TDSGTNXI750U2_HomeKEY", "Number", 0)
    end
    sound_play(release_snd)
end
button_add(nil, nil, 883, 639, 52, 38, home_press,  home_release)

--Direct To

function dtc_press()
    if unitPos == 0 then
        fs2020_event("K:GPS_DIRECTTO_BUTTON", 2)
    else
        fs2020_variable_write("L:TDSGTNXI750U2_DTOKEY", "Number", 1)
    end
    sound_play(press_snd)
end

function dtc_release()
    if unitPos == 0 then
        fs2020_event("K:GPS_DIRECTTO_BUTTON", 4)
    else
        fs2020_variable_write("L:TDSGTNXI750U2_DTOKEY", "Number", 0)
    end
    sound_play(release_snd)
end
button_add(nil, nil, 883, 721, 52, 38, dtc_press, dtc_release)

--
input_prop = user_prop_add_enum("Input method", "Mouse / touch,Knobster", "Mouse / touch", "Choose your input method")
local outer_pos = nil
local inner_pos = nil
outer_pos = fif(user_prop_get(input_prop) == "Mouse / touch", {861, 807, 100, 100}, {746, 695, 80, 80} )
inner_pos = fif(user_prop_get(input_prop) == "Mouse / touch", {886, 830, 70, 70}, {757, 706, 58, 58} )


--FMS Knob
fms_outer = dial_add(nil, outer_pos[1], outer_pos[2], outer_pos[3], outer_pos[4], function(direction)
    if direction == 1 then
        if unitPos == 0 then
            fs2020_event("K:GPS_GROUP_KNOB_INC", 0)
        else
            fs2020_variable_write("L:TDSGTNXI750U2_RKnobOuterInc", "Number", 1)
            timer_start(15, function()fs2020_variable_write("L:TDSGTNXI750U2_RKnobOuterInc", "Number", 0) end)
        end
    elseif direction == -1 then
        if unitPos == 0 then
            fs2020_event("K:GPS_GROUP_KNOB_DEC", 0)
        else
            fs2020_variable_write("L:TDSGTNXI750U2_RKnobOuterDec", "Number", 1)
            timer_start(15, function()fs2020_variable_write("L:TDSGTNXI750U2_RKnobOuterDec", "Number", 0) end)
            
        end
    end
    sound_play(dial_snd)
end)

fms_inner = dial_add(nil, inner_pos[1], inner_pos[2], inner_pos[3], inner_pos[4], function(direction)
    if direction == 1 then
        if unitPos == 0 then
            fs2020_event("K:GPS_PAGE_KNOB_INC", 0)
        else
            fs2020_variable_write("L:TDSGTNXI750U2_RKnobInnerInc", "Number", 1)
            timer_start(20, function()fs2020_variable_write("L:TDSGTNXI750U2_RKnobInnerInc", "Number", 0)end)
            
        end
    elseif direction == -1 then
        if unitPos == 0 then
            fs2020_event("K:GPS_PAGE_KNOB_DEC", 0)
        else
            fs2020_variable_write("L:TDSGTNXI750U2_RKnobInnerDec", "Number", 1)
           timer_start(20, function() fs2020_variable_write("L:TDSGTNXI750U2_RKnobInnerDec", "Number", 0)end)
        end
    end
    sound_play(dial_snd)
end)
mouse_setting(fms_inner , "CURSOR_LEFT", "ctr_cursor_ccw.png")
mouse_setting(fms_inner , "CURSOR_RIGHT", "ctr_cursor_cw.png")

--Knob Press

function fms_knob_press()
    if unitPos == 0 then
        fs2020_event("K:GPS_CURSOR_BUTTON", 2)
    else
        fs2020_variable_write("L:TDSGTNXI750U2_RKnobCRSR", "Number", 1)
    end
    
   sound_play(press_snd)
end

function fms_knob_release()
    if unitPos == 0 then
        fs2020_event("K:GPS_CURSOR_BUTTON", 4)
    else
        fs2020_variable_write("L:TDSGTNXI750U2_RKnobCRSR", "Number", 0)
    end
    
   sound_play(release_snd)
end
fms_knob_button = button_add(nil, nil, inner_pos[1], inner_pos[2], inner_pos[3], inner_pos[4], fms_knob_press, fms_knob_release)
