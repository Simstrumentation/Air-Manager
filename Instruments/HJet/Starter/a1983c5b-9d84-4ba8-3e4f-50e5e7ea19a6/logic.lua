--[[
******************************************************************************************
********* HJet (MG FlightFX) STARTER AND PARKING BRAKE PANEL ******************
******************************************************************************************
    Made by SIMSTRUMENTATION
    GitHub: https://simstrumentation.com

Starter and parking brake panel for the HJet

- **v1.0** - 2023-04-07
    - Original Release
    
NOTES: 
- Designed for the HJet by Marwan Gharib. Will not work with any other aircraft.
- BONUS HIDDEN FUNCTION: Pressing the button between the starters will 
   toggle the throttles in and out of idle cutoff. DO NOT USE IN FLIGHT!!!

KNOWN ISSUES:
- None

ATTRIBUTION:
All graphics, sounds and code original work by Simstrumentation. 
Sharing or re-use of any code or assets is not permitted without credit to the original authors.
******************************************************************************************
]]--

play_sounds = user_prop_add_boolean("Play Sounds", true, "Play sounds in Air Manager")                    

--    sound config
if user_prop_get(play_sounds) then
    press_snd = sound_add("press.wav")
    release_snd = sound_add("release.wav")
else
    press_snd = sound_add("silence.wav")
    release_snd = sound_add("silence.wav")
end
img_add_fullscreen("background.png")

-- variables

local thottleLState = 0
local thottleRState = 0

function releaseAction()
    sound_play(release_snd)
end

function startLAction()
    sound_play(press_snd)
    fs2020_event("TOGGLE_STARTER1")
end
start_l_id = button_add(nil, "start_press.png", 368, 46, 88, 88, startLAction, releaseAction)

function startRAction()
    sound_play(press_snd)
    fs2020_event("TOGGLE_STARTER2")
end
start_R_id = button_add(nil, "start_press.png", 600, 46, 88, 88, startRAction, releaseAction)

function brakeAction()
    fs2020_event("PARKING_BRAKES")
end

brake_id = button_add(nil, nil, 730, 10, 311, 136, brakeAction)
brake_lever_shadow_id = img_add("parking_brake_shadow.png", 735, 15, 311, 136)
brake_lever_id = img_add("parking_brake_handle.png", 730, 10, 311, 136)

function throttleAction()
    sound_play(press_snd)
    if thottleLState == 0 and thottleRState == 0 then
        fs2020_variable_write("L:HA420_THROTTLEPOS_L", "Number", 50)
        fs2020_variable_write("L:HA420_THROTTLEPOS_R", "Number", 50)
    elseif thottleLState == 50 and thottleRState == 50 then
        fs2020_variable_write("L:HA420_THROTTLEPOS_L", "Number", 0)
        fs2020_variable_write("L:HA420_THROTTLEPOS_R", "Number", 0)
    end
end

throttle_id = button_add(nil, "pressed.png", 496, 58, 64, 64, throttleAction, releaseAction)

start_l_annun_id = canvas_add(359, 40, 200, 200, function()
  -- Create a circle
  _circle(55, 53, 38)

  _stroke("yellow", 4)
end)

start_r_annun_id = canvas_add(589, 41, 200, 200, function()
  -- Create a circle
  _circle(55, 53, 38)

  _stroke("yellow", 4)
end)

function setVars(eng1, eng2, brake, posL, posR)
    thottleLState = posL
    thottleRState = posR
    if eng1 then
        visible(start_l_annun_id, true)
    else
        visible(start_l_annun_id, false)
    end
    
    if eng2 then
        visible(start_r_annun_id, true)
    else
        visible(start_r_annun_id, false)
    end
    
    if brake then
        move(brake_lever_id, 736, 20, 360, 157, "LINEAR", 0.05)
        move(brake_lever_shadow_id, 746, 40, 360, 157, "LINEAR", 0.05)
    else
        move(brake_lever_id, 730, 10, 311, 136, "LINEAR", 0.05)
        move(brake_lever_shadow_id, 735, 15, 311, 136, "LINEAR", 0.05 )
    end

end
fs2020_variable_subscribe("A:GENERAL ENG STARTER:1", "BOOL", 
                                              "A:GENERAL ENG STARTER:2", "BOOL", 
                                              "A:BRAKE PARKING INDICATOR", "BOOL",
                                              "L:HA420_THROTTLEPOS_L", "ENUM", 
                                              "L:HA420_THROTTLEPOS_R", "ENUM", 
                                              setVars)