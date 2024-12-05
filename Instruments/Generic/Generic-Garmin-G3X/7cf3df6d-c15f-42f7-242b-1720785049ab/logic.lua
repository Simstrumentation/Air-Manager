--[[
--*****************************************************************************************
-- ******************    Garmin G3X TEST  ***********************
--******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation

- **v1.0** 01-09-22 
    - Original Panel Created

##Left To Do:
    - 
    
##Notes:
    - 
]]--
img_add_fullscreen("background.png")
--***********************************************USER PROPERTY CONFIG***********************************************
-- define user selectable properties
mode = user_prop_add_enum("Unit Mode","PFD, MFD","PFD","Select whether this is the PFD or MFD")                  -- Select unit mode. PFD is default
logo_used = user_prop_add_enum("Select Logo","Simstrumentation, Garmin","Simstrumentation","Select which logo to display at the top of the bezel")     -- Select which logo to show - Simstrumentation default
play_sounds = user_prop_add_boolean("Play Sounds", true, "Play sounds in Air Manager")                           -- Use sounds in Air Manager    

-- end define user selectable properties

-- set user properties

--  unit mode
if user_prop_get(mode) == "PFD" then
    unit_mode = "1"
else
    unit_mode = "2"
end
--  end unit mode

-- logo to display
if user_prop_get(logo_used) == "Simstrumentation" then
    
    img_add("simstrumentation_logo.png",285,20,161,12)                                                  -- Show Simstrumentation logo
else 
    img_add("garmin-logo-white.png",300,12,100,28)                                                         -- Show Garmin logo
end
-- end logo to display

-- play sound
if user_prop_get(play_sounds) then
    press_snd = sound_add("click.wav")
    dial_snd = sound_add("dial.wav")
else
    press_snd = sound_add("silence.wav")
    dial_snd = sound_add("silence.wav")
end
-- end play sound

--*********************************************END USER PROPERTY CONFIG***********************************************

function callback_NRST()
    msfs_event("H:AS3X_Touch_" .. unit_mode .. "_NRST_PUSH")
    sound_play(press_snd)
end
button_add(nil,nil, 241,840,91,58, callback_NRST)

function callback_back()
    msfs_event("H:AS3X_Touch_" .. unit_mode .. "_Back_Push")
    sound_play(press_snd)
end
button_add(nil,nil, 372,840,91,58, callback_back)

function callback_direct()
    msfs_event("H:AS3X_Touch_" .. unit_mode .. "_DIRECTTO_Push")
    sound_play(press_snd)
end
button_add(nil,nil, 932,840,91,58, callback_direct)



function callback_menu()
    msfs_event("H:AS3X_Touch_" .. unit_mode .. "_MENU_PUSH")
    sound_play(press_snd)
end
button_add(nil,nil, 1058,840,91,58, callback_menu)


-- LEFT knob
function knob_alt_outer( direction)
    if direction ==  1 then
        msfs_event("H:AS3X_Touch_" .. unit_mode .. "_Knob_Outer_L_INC")
    elseif direction == -1 then
        msfs_event("H:AS3X_Touch_" .. unit_mode .. "_Knob_Outer_L_DEC")
    end
    sound_play(dial_snd)
end

knob_alt_outer_id = dial_add("plain_knob_outer.png", 47,793,79,79, knob_alt_outer)
dial_click_rotate( knob_alt_outer_id, 6)


function knob_alt_inner( direction)
    if direction ==  1 then
        msfs_event("H:AS3X_Touch_" .. unit_mode .. "_Knob_Inner_L_INC")
    elseif direction == -1 then
        msfs_event("H:AS3X_Touch_" .. unit_mode .. "_Knob_Inner_L_DEC")
    end
    sound_play(dial_snd)
end

knob_alt_inner_id = dial_add("plain_knob_inner.png", 61,807,52,52, knob_alt_inner)
dial_click_rotate( knob_alt_inner_id, 6)

-- end LEFT knob

-- RIGHT knob
function knob_alt_outer( direction)
    if direction ==  1 then
        msfs_event("H:AS3X_Touch_" .. unit_mode .. "_Knob_Outer_R_INC")
    elseif direction == -1 then
        msfs_event("H:AS3X_Touch_" .. unit_mode .. "_Knob_Outer_R_DEC")
    end
    sound_play(dial_snd)
end

knob_alt_outer_id = dial_add("plain_knob_outer.png", 1247,793,79,79, knob_alt_outer)
dial_click_rotate( knob_alt_outer_id, 6)


function knob_alt_inner( direction)
    if direction ==  1 then
        msfs_event("H:AS3X_Touch_" .. unit_mode .. "_Knob_Inner_R_INC")
    elseif direction == -1 then
        msfs_event("H:AS3X_Touch_" .. unit_mode .. "_Knob_Inner_R_DEC")
    end
    sound_play(dial_snd)
end

knob_alt_inner_id = dial_add("plain_knob_inner.png", 1260,807,52,52, knob_alt_inner)
dial_click_rotate( knob_alt_inner_id, 6)

-- end RIGHT knob