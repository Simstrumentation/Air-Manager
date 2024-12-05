--[[
******************************************************************************************
***** HJet (MG FlightFX) STANDBY FLIGHT INSTRUMENT / EADI BEZEL OVERLAY *****
******************************************************************************************
    Made by SIMSTRUMENTATION
    GitHub: https://simstrumentation.com

EADI bezel overlay for the HJet

- **v1.0** - 2023-04-07
    - Original Release
    
NOTES: 
- Designed for the HJet by Marwan Gharib. Will not work with any other aircraft.
- Requires popout instrument from the sim for complete functionality.

KNOWN ISSUES:
- None

ATTRIBUTION:
All graphics, sounds and code original work by Simstrumentation. 
Sharing or re-use of any code or assets is not permitted without credit to the original authors.
******************************************************************************************
]]--

img_add_fullscreen("background.png")
-- User Properties
play_sounds = user_prop_add_boolean("Play Sounds", true, "Play sounds in Air Manager")                    

--    sound config
if user_prop_get(play_sounds) then
    press_snd = sound_add("press.wav")
    release_snd = sound_add("release.wav")
    dial_snd = sound_add("dial.wav")
else
    press_snd = sound_add("silence.wav")
    release_snd = sound_add("silence.wav")
    dial_snd = sound_add("silence.wav")
end

--variables
local baroMode = 0
local eadMode = 0
function releaseAction()
    sound_play(release_snd)
end

function setBaro(direction)
    sound_play(dial_snd)
    if direction == 1 then
        msfs_event("K:KOHLSMAN_INC", 2)
    else
        msfs_event("K:KOHLSMAN_DEC", 2)
    end
end

baro_dial_id = dial_add("knob.png", 207, 280, 25, 18, setBaro)
function setBaroStd()
    sound_play(press_snd)
    msfs_event("K:BAROMETRIC_STD_PRESSURE", 2)
end
baro_std_id = button_add(nil, nil, 209, 282, 20, 15, setBaroStd, releaseAction)


function inHgAction()
    sound_play(press_snd)
    if baroMode == 0 then
        msfs_variable_write("L:HPIN Pushed", "ENUM", 1)
        msfs_variable_write("L:useHpaUnits", "ENUM", 1)
    else
        msfs_variable_write("L:HPIN Pushed", "ENUM", 0)
        msfs_variable_write("L:useHpaUnits", "ENUM", 0)
    end
end
inHg_id = button_add(nil, nil, 90, 280, 30, 16, inHgAction, releaseAction)

function navAction()
    sound_play(press_snd)
    if eadMode == 1 then
        msfs_variable_write("L:EADINAV Pushed", "ENUM", 0)
    else
        msfs_variable_write("L:EADINAV Pushed", "ENUM", 1)
    end
end
nav_id = button_add(nil, nil, 54, 280, 30, 16, navAction, releaseAction)

function setVars(baro, ead,units)
    baroMode = baro
    eadMode = ead
end
msfs_variable_subscribe("L:HPIN Pushed", "ENUM", 
                                              "L:EADINAV Pushed", "ENUM",
                                              "L:useHpaUnits", "ENUM",
                                              setVars)
